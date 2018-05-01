//	Module Name: Control divergence stack
//	This module instantiates a stack and
//	a state machine that controls the data 
//	movement into and out of the stack
//	
//


module 	control_divergence_stack	#(parameter STACK_DEPTH=8, LOG2_STACK_DEPTH=3, STACK_WIDTH=72, PC_WIDTH=32)
					(
					clk, 
					rst_n,
					is_branch, 
					data_in_1, 
					data_in_2,
					new_reconv_PC, 
					fetch_PC,
					stack_full, 
					stack_empty, 
					sm_busy,
					data_out, 
					data_vld
					);


input 	clk;
input	rst_n;
input 	is_branch;
input	[STACK_WIDTH-1:0] data_in_1;
input	[STACK_WIDTH-1:0] data_in_2;
input	[PC_WIDTH-1:0]	  new_reconv_PC;
input	[PC_WIDTH-1:0]	  fetch_PC;
output	stack_full;
output	stack_empty;
output	sm_busy;
output	[STACK_WIDTH-1:0] data_out;
output	data_vld;

parameter SIDLE	= 3'h0;
parameter SPUSH_POP_SAVE = 3'h1;
parameter SPOP	= 3'h2;
parameter SPUSH = 3'h3;
parameter SPUSH_SAVE = 3'h4;
// Register and Net declarations

wire 	[PC_WIDTH-1:0] next_reconv_PC;
reg 	[PC_WIDTH-1:0] next_reconv_PC_reg;
wire	[PC_WIDTH-1:0] next_reconv_PC_data;
reg 	[STACK_WIDTH-1:0] popped_data;
wire 	[STACK_WIDTH-1:0] popped_data_next;
reg 	[STACK_WIDTH-1:0] data_in_saved;
wire 	[STACK_WIDTH-1:0] data_in_saved_next;

reg 	[2:0] curr_state;
reg 	[2:0] next_state;
reg 	      read_tos_ff;

wire	[STACK_WIDTH-1:0] data_in;

wire 	push;
wire 	pop;
wire 	push_back;
wire	read_tos;
wire	save_in_data;

// Instantiate the stack 
stack		#(.STACK_DEPTH(8), .LOG2_STACK_DEPTH(3), .STACK_WIDTH(72))
	STACK	(
		.clk		(clk), 
		.rst_n		(rst_n), 
		.data_in	(data_in), 
		.push		(push),
		.pop		(pop), 
		.push_back	(push_back), 
		.read_tos	(read_tos),
		.data_vld	(data_vld),
		.data_out	(data_out),
		.stack_full	(stack_full),	 
		.stack_empty	(stack_empty)
		);

// State machine to control data movement into and out of the stack


always @(posedge clk)
begin
	if(!rst_n)
	begin
		curr_state <= SIDLE;
		next_reconv_PC_reg <= 32'h0; 
		`ifdef NUM_LANES_IS_16 
			popped_data <= 80'h0;
			data_in_saved <= 80'h0;
		`else
			popped_data <= 72'h0;
			data_in_saved <= 72'h0;
 		`endif
		read_tos_ff <= 1'b0;
	end
	else
	begin
		curr_state <= next_state;
		next_reconv_PC_reg <= next_reconv_PC_data;
		popped_data <= popped_data_next;
		data_in_saved <= data_in_saved_next;
		read_tos_ff <= read_tos;
	end
end

// FIXME Check if always @(*) works for other versions of VCS
// always @(curr_state or is_branch or stack_empty or fetch_PC or next_reconv_PC)
always @(*)
begin
	case(curr_state)
	SIDLE: 		next_state <= (is_branch & !stack_empty) ? SPUSH_POP_SAVE : 
				     (is_branch & stack_empty)  ? SPUSH_SAVE     :
				     (fetch_PC==next_reconv_PC) ? SPOP           : SIDLE;
	SPUSH_POP_SAVE: next_state <= SPUSH;
	SPUSH_SAVE    : next_state <= SIDLE;
	SPUSH:		next_state <= SIDLE;
	SPOP:		next_state <= SIDLE;
	endcase
end

assign sm_busy = (curr_state == SIDLE) ? 1'b0: 1'b1;

assign push = 	((curr_state == SIDLE) && (next_state == SPUSH_POP_SAVE)) ? 1'b1:
	 	((curr_state == SIDLE) && (next_state == SPUSH_SAVE))     ? 1'b1:
	 	((curr_state == SPUSH_SAVE) && (next_state == SIDLE))     ? 1'b1:
		((curr_state == SPUSH_POP_SAVE) && (next_state == SPUSH)) ? 1'b1:
		1'b0;
assign pop  =   ((curr_state == SIDLE) && (next_state == SPOP)) 	 ? 1'b1: 
		((curr_state == SIDLE) && (next_state == SPUSH_POP_SAVE)) ? 1'b1:
		1'b0;
 
assign push_back = ((curr_state == SPUSH) && (next_state == SIDLE)) ? 1'b1: 1'b0;

assign read_tos  = ((curr_state == SPOP) && (next_state == SIDLE)) ? 1'b1: 1'b0;

assign save_in_data = 	((curr_state == SIDLE) && (next_state == SPUSH_POP_SAVE)) ? 1'b1: 
	 		((curr_state == SIDLE) && (next_state == SPUSH_SAVE))     ? 1'b1:
			1'b0;

`ifdef NUM_LANES_IS_16
assign data_in = ((curr_state== SIDLE) && (next_state == SPUSH_POP_SAVE))  ? data_in_1:
	 	 ((curr_state == SIDLE) && (next_state == SPUSH_SAVE))     ? data_in_1:
		 ((curr_state == SPUSH_SAVE) && (next_state == SIDLE))     ? data_in_saved:  
		 ((curr_state == SPUSH_POP_SAVE) && (next_state == SPUSH)) ? data_in_saved: 
		 push_back 						   ? {popped_data[79:32], next_reconv_PC} : 80'h0; 
`else
assign data_in = ((curr_state== SIDLE) && (next_state == SPUSH_POP_SAVE))  ? data_in_1:
	 	 ((curr_state == SIDLE) && (next_state == SPUSH_SAVE))     ? data_in_1:
		 ((curr_state == SPUSH_SAVE) && (next_state == SIDLE))     ? data_in_saved:  
		 ((curr_state == SPUSH_POP_SAVE) && (next_state == SPUSH)) ? data_in_saved: 
		 push_back 						   ? {popped_data[71:32], next_reconv_PC} : 72'h0; 
`endif
assign popped_data_next = ((next_state== SPUSH) && (curr_state == SPUSH_POP_SAVE)) ? data_out : popped_data;

assign next_reconv_PC_data	=	((curr_state == SIDLE) && is_branch) ? 	new_reconv_PC :
				        (read_tos_ff && (!stack_empty)) ? data_out[63:32] : next_reconv_PC_reg ;
assign next_reconv_PC = (read_tos_ff && (!stack_empty)) ? data_out[63:32] : next_reconv_PC_reg;

assign data_in_saved_next = save_in_data ? data_in_2: data_in_saved ;

endmodule
