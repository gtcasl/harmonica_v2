// Module : stack
// Owner  : Poulami Das
// This module implements a stack that assists in handling control divergence


module	stack	#(parameter STACK_DEPTH=8, LOG2_STACK_DEPTH=3, STACK_WIDTH=72)
		(
		clk, 
		rst_n, 
		data_in, 
		push,
		pop, 
		push_back, 
		read_tos,
		data_vld,
		data_out,
		stack_full, 
		stack_empty
		);

input	clk;
input 	rst_n;
input   [STACK_WIDTH-1:0] data_in;
input	push;
input	pop;
input	push_back;
input	read_tos;

output	data_vld;
output	[STACK_WIDTH-1:0] data_out;
output	stack_full;	
output	stack_empty;	

reg   [STACK_WIDTH-1:0]    STACK[0:STACK_DEPTH-1];
reg   [LOG2_STACK_DEPTH-1:0] top_stack;
reg	data_vld;
reg	[STACK_WIDTH-1:0] data_out;
reg 	stack_full;

wire			      stack_full_next;
wire   [LOG2_STACK_DEPTH-1:0] top_stack_next;
wire   [LOG2_STACK_DEPTH-1:0] top_stack_prev;
wire			      data_valid_next;

`ifdef    STACK_DEPTH_IS_16
parameter MIN_STACK_TOP = 4'h0;
parameter MAX_STACK_TOP = 4'hF;
`else 
parameter MIN_STACK_TOP = 3'h0;
parameter MAX_STACK_TOP = 3'h7;
`endif
always @(posedge clk)
begin
	if(!rst_n)
	begin
	stack_full <= 1'b0; 
	`ifdef STACK_DEPTH_IS_16
		top_stack <= 4'h0;
	`else 
		top_stack <= 3'h0;
	`endif
		data_vld  <= 1'b0;
	`ifdef NUM_LANES_IS_16
		data_out  <= 80'h0;				
	`else
		data_out  <= 72'h0;			
	`endif
	end	
	else
	begin
	stack_full <= stack_full_next;
	if(push && pop) // both push and pop are true)
	begin
		STACK[top_stack] <= data_in;
		top_stack 	 <= top_stack_next;
		data_out	 <= STACK[top_stack_prev];
		data_vld 	 <= data_valid_next;
	end
	else if(push) // only push
	begin
		STACK[top_stack] <= data_in;
		top_stack 	 <= top_stack_next;
		data_vld	 <= data_valid_next;
		`ifdef NUM_LANES_IS_16
			data_out  <= 80'h0;				
		`else
			data_out  <= 72'h0;			
		`endif
	end
	else if (pop) // pop only
	begin
		data_out	 <= STACK[top_stack_prev];
		data_vld 	 <= data_valid_next;
		top_stack 	 <= top_stack_next;
	end
	else if(push_back)	// pushback
	begin
		STACK[top_stack_prev] <= data_in;
		data_vld 	 <= data_valid_next;
		top_stack 	 <= top_stack_next;
	end
	else if(read_tos)
	begin
		data_out	 <= STACK[top_stack_prev];
		data_vld 	 <= data_valid_next;
		top_stack 	 <= top_stack_next;	// Does not change on read_tos
	end
	else	
		`ifdef NUM_LANES_IS_16
			data_out  <= 80'h0;				
		`else
			data_out  <= 72'h0;			
		`endif
		data_vld 	 <= data_valid_next;
		top_stack 	 <= top_stack_next;
	end
end

assign stack_empty = ((top_stack == MIN_STACK_TOP) && (!stack_full)) ? 1'b1: 1'b0;

assign top_stack_next = push? top_stack + 1'b1 :
			pop ? top_stack - 1'b1 :
			top_stack;

assign top_stack_prev = pop ? top_stack - 1'b1 :
			push_back ? top_stack - 2'b11:
			(top_stack - 1'b1); 
			
assign data_valid_next = pop ? 1'b1: 1'b0;

// Implemented as a sticky bit: Can we do better?
assign stack_full_next = ((top_stack == MAX_STACK_TOP) && (top_stack_next == MIN_STACK_TOP)) ? 1'b1: 
			 ((top_stack == MIN_STACK_TOP) && (top_stack_next == MAX_STACK_TOP)) ? 1'b0:
			 stack_full;



endmodule
