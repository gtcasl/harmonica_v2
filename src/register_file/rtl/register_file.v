// Owner: Poulami Das
// Module Name: register_file
// Description: This module defines the register file where the number of
// registers can be parameterized at compile time. Valid Options are 16, 32,
// and 64


//`include "register_cfg.v"

module register_file #(parameter DATA_WIDTH=32, LOG2_NUM_REGS=4, NUM_REGS=16)
	  		(
		// Inputs
			clk, 
			reset_n,
			read_en, 
			write_en, 
			raddr_0,
			raddr_1, 
			waddr,
			wdata,
		// Outputs
			rdata_0,
			rdata_1
			);


// Input
input clk;				// clk
input reset_n;				// reset

input [1:0] read_en;			// read_en
input [LOG2_NUM_REGS-1:0] raddr_0;	// Read Address 0
input [LOG2_NUM_REGS-1:0] raddr_1;	// Read Adddres 1


input write_en;				// write_en
input [LOG2_NUM_REGS-1:0] waddr;	// Write Adddress 
input [DATA_WIDTH-1:0]    wdata;	// Write Adddress 

// Output 

output [DATA_WIDTH-1:0]    rdata_0;	// Read Data 
output [DATA_WIDTH-1:0]    rdata_1;	// Read Data 

reg   [DATA_WIDTH-1:0]    RF[0:NUM_REGS-1]; // Actual set of registers

wire read_port_0;
wire read_port_1;
wire read_port_2;

assign read_port_0 = read_en[0]; 
assign read_port_1 = read_en[1];    
   

`ifdef DATA_WIDTH_IS_1

assign rdata_0 = read_port_0 ? RF[raddr_0]: 1'h0;
assign rdata_1 = read_port_1 ? RF[raddr_1]: 1'h0;

always @(posedge clk)
begin
	if(~reset_n)
	begin
		RF[0] 	<= 1'h0;
		RF[1] 	<= 1'h0;
		RF[2] 	<= 1'h0;
		RF[3] 	<= 1'h0;
		RF[4] 	<= 1'h0;
		RF[5] 	<= 1'h0;
		RF[6] 	<= 1'h0;
		RF[7] 	<= 1'h0;
		RF[8] 	<= 1'h0;
		RF[9] 	<= 1'h0;
		RF[10]	<= 1'h0;
		RF[11] 	<= 1'h0;
		RF[12] 	<= 1'h0;
		RF[13] 	<= 1'h0;
		RF[14] 	<= 1'h0;
		RF[15] 	<= 1'h0;
		RF[16] 	<= 1'h0;
	`ifdef  NUMBER_OF_REGISTERS_IS_32
		RF[17] 	<= 1'h0;
		RF[18] 	<= 1'h0;
		RF[19] 	<= 1'h0;
		RF[20] 	<= 1'h0;
		RF[21] 	<= 1'h0;
		RF[22] 	<= 1'h0;
		RF[23] 	<= 1'h0;
		RF[24] 	<= 1'h0;
		RF[25] 	<= 1'h0;
		RF[26] 	<= 1'h0;
		RF[27] 	<= 1'h0;
		RF[28] 	<= 1'h0;
		RF[29] 	<= 1'h0;
		RF[30] 	<= 1'h0;
		RF[31] 	<= 1'h0;
	`endif
	`ifdef  NUMBER_OF_REGISTERS_IS_64
		RF[17] 	<= 1'h0;
		RF[18] 	<= 1'h0;
		RF[19] 	<= 1'h0;
		RF[20] 	<= 1'h0;
		RF[21] 	<= 1'h0;
		RF[22] 	<= 1'h0;
		RF[23] 	<= 1'h0;
		RF[24] 	<= 1'h0;
		RF[25] 	<= 1'h0;
		RF[26] 	<= 1'h0;
		RF[27] 	<= 1'h0;
		RF[28] 	<= 1'h0;
		RF[29] 	<= 1'h0;
		RF[30] 	<= 1'h0;
		RF[31] 	<= 1'h0;
		RF[32] 	<= 1'h0;
		RF[33] 	<= 1'h0;
		RF[34] 	<= 1'h0;
		RF[35] 	<= 1'h0;
		RF[36] 	<= 1'h0;
		RF[37] 	<= 1'h0;
		RF[38] 	<= 1'h0;
		RF[39] 	<= 1'h0;
		RF[40] 	<= 1'h0;
		RF[41] 	<= 1'h0;
		RF[42] 	<= 1'h0;
		RF[43] 	<= 1'h0;
		RF[44] 	<= 1'h0;
		RF[45] 	<= 1'h0;
		RF[46] 	<= 1'h0;
		RF[47] 	<= 1'h0;
		RF[48] 	<= 1'h0;
		RF[49] 	<= 1'h0;
		RF[50] 	<= 1'h0;
		RF[51] 	<= 1'h0;
		RF[52] 	<= 1'h0;
		RF[53] 	<= 1'h0;
		RF[54] 	<= 1'h0;
		RF[55] 	<= 1'h0;
		RF[56] 	<= 1'h0;
		RF[57] 	<= 1'h0;
		RF[58] 	<= 1'h0;
		RF[59] 	<= 1'h0;
		RF[60] 	<= 1'h0;
		RF[61] 	<= 1'h0;
		RF[62] 	<= 1'h0;
		RF[63] 	<= 1'h0;
	`endif
	end
	else
	begin
	if(write_en)
		RF[waddr] <= wdata;

	end
end
`elsif DATA_WIDTH_IS_64

assign rdata_0 = read_port_0 ? RF[raddr_0]: 64'h0;
assign rdata_1 = read_port_1 ? RF[raddr_1]: 64'h0;

always @(posedge clk)
begin
	if(~reset_n)
	begin
		RF[0] 	<= 64'h0;
		RF[1] 	<= 64'h0;
		RF[2] 	<= 64'h0;
		RF[3] 	<= 64'h0;
		RF[4] 	<= 64'h0;
		RF[5] 	<= 64'h0;
		RF[6] 	<= 64'h0;
		RF[7] 	<= 64'h0;
		RF[8] 	<= 64'h0;
		RF[9] 	<= 64'h0;
		RF[10]	<= 64'h0;
		RF[11] 	<= 64'h0;
		RF[12] 	<= 64'h0;
		RF[13] 	<= 64'h0;
		RF[14] 	<= 64'h0;
		RF[15] 	<= 64'h0;
		RF[16] 	<= 64'h0;
	`ifdef  NUMBER_OF_REGISTERS_IS_32
		RF[17] 	<= 64'h0;
		RF[18] 	<= 64'h0;
		RF[19] 	<= 64'h0;
		RF[20] 	<= 64'h0;
		RF[21] 	<= 64'h0;
		RF[22] 	<= 64'h0;
		RF[23] 	<= 64'h0;
		RF[24] 	<= 64'h0;
		RF[25] 	<= 64'h0;
		RF[26] 	<= 64'h0;
		RF[27] 	<= 64'h0;
		RF[28] 	<= 64'h0;
		RF[29] 	<= 64'h0;
		RF[30] 	<= 64'h0;
		RF[31] 	<= 64'h0;
	`endif
	`ifdef  NUMBER_OF_REGISTERS_IS_64
		RF[17] 	<= 64'h0;
		RF[18] 	<= 64'h0;
		RF[19] 	<= 64'h0;
		RF[20] 	<= 64'h0;
		RF[21] 	<= 64'h0;
		RF[22] 	<= 64'h0;
		RF[23] 	<= 64'h0;
		RF[24] 	<= 64'h0;
		RF[25] 	<= 64'h0;
		RF[26] 	<= 64'h0;
		RF[27] 	<= 64'h0;
		RF[28] 	<= 64'h0;
		RF[29] 	<= 64'h0;
		RF[30] 	<= 64'h0;
		RF[31] 	<= 64'h0;
		RF[32] 	<= 64'h0;
		RF[33] 	<= 64'h0;
		RF[34] 	<= 64'h0;
		RF[35] 	<= 64'h0;
		RF[36] 	<= 64'h0;
		RF[37] 	<= 64'h0;
		RF[38] 	<= 64'h0;
		RF[39] 	<= 64'h0;
		RF[40] 	<= 64'h0;
		RF[41] 	<= 64'h0;
		RF[42] 	<= 64'h0;
		RF[43] 	<= 64'h0;
		RF[44] 	<= 64'h0;
		RF[45] 	<= 64'h0;
		RF[46] 	<= 64'h0;
		RF[47] 	<= 64'h0;
		RF[48] 	<= 64'h0;
		RF[49] 	<= 64'h0;
		RF[50] 	<= 64'h0;
		RF[51] 	<= 64'h0;
		RF[52] 	<= 64'h0;
		RF[53] 	<= 64'h0;
		RF[54] 	<= 64'h0;
		RF[55] 	<= 64'h0;
		RF[56] 	<= 64'h0;
		RF[57] 	<= 64'h0;
		RF[58] 	<= 64'h0;
		RF[59] 	<= 64'h0;
		RF[60] 	<= 64'h0;
		RF[61] 	<= 64'h0;
		RF[62] 	<= 64'h0;
		RF[63] 	<= 64'h0;
	`endif
	end
	else
	begin

	if(write_en)
		RF[waddr] <= wdata;

	end
end
`else // For the predicated register file

assign rdata_0 = read_port_0 ? RF[raddr_0]: 32'h0;
assign rdata_1 = read_port_1 ? RF[raddr_1]: 32'h0;

always @(posedge clk)
begin
	if(~reset_n)
	begin
		RF[0] 	<= 32'h0;
		RF[1] 	<= 32'h0;
		RF[2] 	<= 32'h0;
		RF[3] 	<= 32'h0;
		RF[4] 	<= 32'h0;
		RF[5] 	<= 32'h0;
		RF[6] 	<= 32'h0;
		RF[7] 	<= 32'h0;
		RF[8] 	<= 32'h0;
		RF[9] 	<= 32'h0;
		RF[10]	<= 32'h0;
		RF[11] 	<= 32'h0;
		RF[12] 	<= 32'h0;
		RF[13] 	<= 32'h0;
		RF[14] 	<= 32'h0;
		RF[15] 	<= 32'h0;
		RF[16] 	<= 32'h0;
	`ifdef  NUMBER_OF_REGISTERS_IS_32
		RF[17] 	<= 32'h0;
		RF[18] 	<= 32'h0;
		RF[19] 	<= 32'h0;
		RF[20] 	<= 32'h0;
		RF[21] 	<= 32'h0;
		RF[22] 	<= 32'h0;
		RF[23] 	<= 32'h0;
		RF[24] 	<= 32'h0;
		RF[25] 	<= 32'h0;
		RF[26] 	<= 32'h0;
		RF[27] 	<= 32'h0;
		RF[28] 	<= 32'h0;
		RF[29] 	<= 32'h0;
		RF[30] 	<= 32'h0;
		RF[31] 	<= 32'h0;
	`endif
	`ifdef  NUMBER_OF_REGISTERS_IS_64
		RF[17] 	<= 32'h0;
		RF[18] 	<= 32'h0;
		RF[19] 	<= 32'h0;
		RF[20] 	<= 32'h0;
		RF[21] 	<= 32'h0;
		RF[22] 	<= 32'h0;
		RF[23] 	<= 32'h0;
		RF[24] 	<= 32'h0;
		RF[25] 	<= 32'h0;
		RF[26] 	<= 32'h0;
		RF[27] 	<= 32'h0;
		RF[28] 	<= 32'h0;
		RF[29] 	<= 32'h0;
		RF[30] 	<= 32'h0;
		RF[31] 	<= 32'h0;
		RF[32] 	<= 32'h0;
		RF[33] 	<= 32'h0;
		RF[34] 	<= 32'h0;
		RF[35] 	<= 32'h0;
		RF[36] 	<= 32'h0;
		RF[37] 	<= 32'h0;
		RF[38] 	<= 32'h0;
		RF[39] 	<= 32'h0;
		RF[40] 	<= 32'h0;
		RF[41] 	<= 32'h0;
		RF[42] 	<= 32'h0;
		RF[43] 	<= 32'h0;
		RF[44] 	<= 32'h0;
		RF[45] 	<= 32'h0;
		RF[46] 	<= 32'h0;
		RF[47] 	<= 32'h0;
		RF[48] 	<= 32'h0;
		RF[49] 	<= 32'h0;
		RF[50] 	<= 32'h0;
		RF[51] 	<= 32'h0;
		RF[52] 	<= 32'h0;
		RF[53] 	<= 32'h0;
		RF[54] 	<= 32'h0;
		RF[55] 	<= 32'h0;
		RF[56] 	<= 32'h0;
		RF[57] 	<= 32'h0;
		RF[58] 	<= 32'h0;
		RF[59] 	<= 32'h0;
		RF[60] 	<= 32'h0;
		RF[61] 	<= 32'h0;
		RF[62] 	<= 32'h0;
		RF[63] 	<= 32'h0;
	`endif
	end
	else
	begin

	if(write_en)
		RF[waddr] <= wdata;

	end
end
`endif

endmodule
