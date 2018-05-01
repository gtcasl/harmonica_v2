// Owner: Poulami Das
// Module Name: predicate register block
// Description: This contains all the predicate registers
// The module instantiates a copy of the register block 
// from the general purpose register block with a data width fixed at 1
//
// Required connectivity variables
//
//


module predicate_register_block #(parameter NUM_WARPS=8, DATA_WIDTH=1, NUM_LANES=8, NUM_REGS=16, LOG2_NUM_REGS=4) 
			(
			clk, 
			rst_n, 
			read_en_0, 
			read_en_1, 
			raddr_0, 
			raddr_1, 
			write_en, 
			waddr,
		// lane specific wdata port
			wdata_0,	// Wdata for Lane 0
			wdata_1,	// Wdata for Lane 1
			wdata_2,	// Wdata for Lane 2
			wdata_3,	// Wdata for Lane 3
			wdata_4,	// Wdata for Lane 4
			wdata_5,	// Wdata for Lane 5
			wdata_6,	// Wdata for Lane 6
			wdata_7,	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			wdata_8,	// Wdata for Lane 8
			wdata_9,	// Wdata for Lane 9
			wdata_10,	// Wdata for Lane 10
			wdata_11,	// Wdata for Lane 11
			wdata_12,	// Wdata for Lane 12
			wdata_13,	// Wdata for Lane 13
			wdata_14,	// Wdata for Lane 14
			wdata_15,	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			rdata_0_0,	// Lane 0 
			rdata_1_0,	// Lane 0 
			rdata_0_1,	// Lane 1 
			rdata_1_1,	// Lane 1 
			rdata_0_2,	// Lane 2 
			rdata_1_2,	// Lane 2 
			rdata_0_3,	// Lane 3 
			rdata_1_3,	// Lane 3 
			rdata_0_4,	// Lane 4 
			rdata_1_4,	// Lane 4 
			rdata_0_5,	// Lane 5 
			rdata_1_5,	// Lane 5 
			rdata_0_6,	// Lane 6 
			rdata_1_6,	// Lane 6 
			rdata_0_7,	// Lane 7 
			rdata_1_7,	// Lane 7 
	`ifdef NUM_LANES_IS_16
			rdata_0_8,	// Lane 8 
			rdata_1_8,	// Lane 8 
			rdata_0_9,	// Lane 9 
			rdata_1_9,	// Lane 9 
			rdata_0_10,	// Lane 10 
			rdata_1_10,	// Lane 10 
			rdata_0_11,	// Lane 11 
			rdata_1_11,	// Lane 11 
			rdata_0_12,	// Lane 12 
			rdata_1_12,	// Lane 12 
			rdata_0_13,	// Lane 13 
			rdata_1_13,	// Lane 13 
			rdata_0_14,	// Lane 14 
			rdata_1_14,	// Lane 14 
			rdata_0_15,	// Lane 15 
			rdata_1_15,	// Lane 15 
	`endif		
			warp_selector			
			);


input clk;				// Clock 
input rst_n;				// Reset

input [NUM_LANES-1:0] read_en_0; 	// Enable per lane
input [NUM_LANES-1:0] read_en_1;
input [NUM_LANES-1:0] write_en;
input [LOG2_NUM_REGS-1:0] raddr_0;
input [LOG2_NUM_REGS-1:0] raddr_1;
input [LOG2_NUM_REGS-1:0] waddr;

input [DATA_WIDTH-1:0]    wdata_0;	// Write Data for lane 0
input [DATA_WIDTH-1:0]    wdata_1;	// Write Data for lane 1
input [DATA_WIDTH-1:0]    wdata_2;	// Write Data for lane 2
input [DATA_WIDTH-1:0]    wdata_3;	// Write Data for lane 3
input [DATA_WIDTH-1:0]    wdata_4;	// Write Data for lane 4
input [DATA_WIDTH-1:0]    wdata_5;	// Write Data for lane 5
input [DATA_WIDTH-1:0]    wdata_6;	// Write Data for lane 6
input [DATA_WIDTH-1:0]    wdata_7;	// Write Data for lane 7

`ifdef NUM_LANES_IS_16
input [DATA_WIDTH-1:0]    wdata_8;	// Write Data for lane 8
input [DATA_WIDTH-1:0]    wdata_9;	// Write Data for lane 9
input [DATA_WIDTH-1:0]    wdata_10;	// Write Data for lane 10
input [DATA_WIDTH-1:0]    wdata_11;	// Write Data for lane 11
input [DATA_WIDTH-1:0]    wdata_12;	// Write Data for lane 12
input [DATA_WIDTH-1:0]    wdata_13;	// Write Data for lane 13
input [DATA_WIDTH-1:0]    wdata_14;	// Write Data for lane 14
input [DATA_WIDTH-1:0]    wdata_15;	// Write Data for lane 15
`endif

// Output

output [DATA_WIDTH-1:0]    rdata_0_0;	// Read Data for Port 0 Lane 0
output [DATA_WIDTH-1:0]    rdata_1_0;	// Read Data for Port 1 Lane 0
output [DATA_WIDTH-1:0]    rdata_0_1;	// Read Data for Port 0 Lane 1
output [DATA_WIDTH-1:0]    rdata_1_1;	// Read Data for Port 1 Lane 1
output [DATA_WIDTH-1:0]    rdata_0_2;	// Read Data for Port 0 Lane 2
output [DATA_WIDTH-1:0]    rdata_1_2;	// Read Data for Port 1 Lane 2
output [DATA_WIDTH-1:0]    rdata_0_3;	// Read Data for Port 0 Lane 3
output [DATA_WIDTH-1:0]    rdata_1_3;	// Read Data for Port 1 Lane 3
output [DATA_WIDTH-1:0]    rdata_0_4;	// Read Data for Port 0 Lane 4
output [DATA_WIDTH-1:0]    rdata_1_4;	// Read Data for Port 1 Lane 4
output [DATA_WIDTH-1:0]    rdata_0_5;	// Read Data for Port 0 Lane 5
output [DATA_WIDTH-1:0]    rdata_1_5;	// Read Data for Port 1 Lane 5
output [DATA_WIDTH-1:0]    rdata_0_6;	// Read Data for Port 0 Lane 6
output [DATA_WIDTH-1:0]    rdata_1_6;	// Read Data for Port 1 Lane 6
output [DATA_WIDTH-1:0]    rdata_0_7;	// Read Data for Port 0 Lane 7
output [DATA_WIDTH-1:0]    rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
output [DATA_WIDTH-1:0]    rdata_0_8;	// Read Data for Port 0 Lane 8
output [DATA_WIDTH-1:0]    rdata_1_8;	// Read Data for Port 1 Lane 8
output [DATA_WIDTH-1:0]    rdata_0_9;	// Read Data for Port 0 Lane 9
output [DATA_WIDTH-1:0]    rdata_1_9;	// Read Data for Port 1 Lane 9
output [DATA_WIDTH-1:0]    rdata_0_10;	// Read Data for Port 0 Lane 10
output [DATA_WIDTH-1:0]    rdata_1_10;	// Read Data for Port 1 Lane 10
output [DATA_WIDTH-1:0]    rdata_0_11;	// Read Data for Port 0 Lane 10
output [DATA_WIDTH-1:0]    rdata_1_11;	// Read Data for Port 1 Lane 10
output [DATA_WIDTH-1:0]    rdata_0_12;	// Read Data for Port 0 Lane 10
output [DATA_WIDTH-1:0]    rdata_1_12;	// Read Data for Port 1 Lane 10
output [DATA_WIDTH-1:0]    rdata_0_13;	// Read Data for Port 0 Lane 10
output [DATA_WIDTH-1:0]    rdata_1_13;	// Read Data for Port 1 Lane 10
output [DATA_WIDTH-1:0]    rdata_0_14;	// Read Data for Port 0 Lane 10
output [DATA_WIDTH-1:0]    rdata_1_14;	// Read Data for Port 1 Lane 10
output [DATA_WIDTH-1:0]    rdata_0_15;	// Read Data for Port 0 Lane 10
output [DATA_WIDTH-1:0]    rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

// Select warp 

`ifndef NUMBER_OF_WARPS_IS_16
input [2:0] warp_selector;  // Default Number of warps is 8
`else
input [3:0] warp_selector;  // Number of warps is 16
`endif



// Instantiate the Register Bank 


register_block		 #(.NUM_WARPS(8),
			   .NUM_LANES(8),
			   .DATA_WIDTH(1),
			   .NUM_REGS(16),
			   .LOG2_NUM_REGS(4)
			  ) 
		RBLOCK	(
			.clk		(clk), 
			.rst_n		(rst_n),
			.read_en_0	(read_en_0), 
			.read_en_1	(read_en_1), 
			.raddr_0	(raddr_0), 
			.raddr_1	(raddr_1), 
			.write_en	(write_en), 
			.wdata_0	(wdata_0), 
			.wdata_1	(wdata_1), 
			.wdata_2	(wdata_2), 
			.wdata_3	(wdata_3), 
			.wdata_4	(wdata_4), 
			.wdata_5	(wdata_5), 
			.wdata_6	(wdata_6), 
			.wdata_7	(wdata_7), 
	`ifdef NUM_LANES_IS_16
			.wdata_8	(wdata_8), 
			.wdata_9	(wdata_9), 
			.wdata_10	(wdata_10), 
			.wdata_11	(wdata_11), 
			.wdata_12	(wdata_12), 
			.wdata_13	(wdata_13), 
			.wdata_14	(wdata_14), 
			.wdata_15	(wdata_15), 
	`endif
			.waddr		(waddr), 
			.rdata_0_0	(rdata_0_0), 
			.rdata_1_0	(rdata_1_0),
			.rdata_0_1	(rdata_0_1), 
			.rdata_1_1	(rdata_1_1),
			.rdata_0_2	(rdata_0_2), 
			.rdata_1_2	(rdata_1_2),
			.rdata_0_3	(rdata_0_3), 
			.rdata_1_3	(rdata_1_3),
			.rdata_0_4	(rdata_0_4), 
			.rdata_1_4	(rdata_1_4),
			.rdata_0_5	(rdata_0_5), 
			.rdata_1_5	(rdata_1_5),
			.rdata_0_6	(rdata_0_6), 
			.rdata_1_6	(rdata_1_6),
			.rdata_0_7	(rdata_0_7), 
			.rdata_1_7	(rdata_1_7),
	`ifdef NUM_LANES_IS_16
			.rdata_0_8	(rdata_0_8), 
			.rdata_1_8	(rdata_1_8),
			.rdata_0_9	(rdata_0_9), 
			.rdata_1_9	(rdata_1_9),
			.rdata_0_10	(rdata_0_10), 
			.rdata_1_10	(rdata_1_10),
			.rdata_0_11	(rdata_0_11), 
			.rdata_1_11	(rdata_1_11),
			.rdata_0_12	(rdata_0_12), 
			.rdata_1_12	(rdata_1_12),
			.rdata_0_13	(rdata_0_13), 
			.rdata_1_13	(rdata_1_13),
			.rdata_0_14	(rdata_0_14), 
			.rdata_1_14	(rdata_1_14),
			.rdata_0_15	(rdata_0_15), 
			.rdata_1_15	(rdata_1_15), 
	`endif
			.warp_selector  (warp_selector)
			);

`include "predicate_register_block_param_ovrd.v"


endmodule
