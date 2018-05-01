// Owner: Poulami Das
// Module Name: register_block
// Description: The module instantiates a register bank per warp




module register_block #(parameter NUM_WARPS=8, NUM_LANES=8, DATA_WIDTH=32, NUM_REGS=16, LOG2_NUM_REGS=4) 
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

wire bank_0_sel;
wire bank_1_sel;
wire bank_2_sel;
wire bank_3_sel;
wire bank_4_sel;
wire bank_5_sel;
wire bank_6_sel;
wire bank_7_sel;

`ifdef NUMBER_OF_WARPS_IS_16
wire bank_8_sel;
wire bank_9_sel;
wire bank_10_sel;
wire bank_11_sel;
wire bank_12_sel;
wire bank_13_sel;
wire bank_14_sel;
wire bank_15_sel;
`endif

wire [DATA_WIDTH-1:0]    rb_0_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_0_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif


wire [DATA_WIDTH-1:0]    rb_1_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_1_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_2_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_2_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_3_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_3_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_4_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_4_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_5_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_5_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif


wire [DATA_WIDTH-1:0]    rb_6_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_6_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_7_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_7_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif


`ifdef NUMBER_OF_WARPS_IS_16
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_8_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_9_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_9_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_10_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_10_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_11_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_11_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_12_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_12_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_13_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_13_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_14_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_14_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif

wire [DATA_WIDTH-1:0]    rb_15_rdata_0_0;	// Read Data for Port 0 Lane 0
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_0;	// Read Data for Port 1 Lane 0
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_1;	// Read Data for Port 0 Lane 1
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_1;	// Read Data for Port 1 Lane 1
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_2;	// Read Data for Port 0 Lane 2
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_2;	// Read Data for Port 1 Lane 2
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_3;	// Read Data for Port 0 Lane 3
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_3;	// Read Data for Port 1 Lane 3
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_4;	// Read Data for Port 0 Lane 4
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_4;	// Read Data for Port 1 Lane 4
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_5;	// Read Data for Port 0 Lane 5
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_5;	// Read Data for Port 1 Lane 5
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_6;	// Read Data for Port 0 Lane 6
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_6;	// Read Data for Port 1 Lane 6
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_7;	// Read Data for Port 0 Lane 7
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_7;	// Read Data for Port 1 Lane 7

`ifdef NUM_LANES_IS_16
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_8;	// Read Data for Port 0 Lane 8
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_8;	// Read Data for Port 1 Lane 8
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_9;	// Read Data for Port 0 Lane 9
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_9;	// Read Data for Port 1 Lane 9
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_10;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_10;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_11;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_11;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_12;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_12;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_13;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_13;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_14;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_14;	// Read Data for Port 1 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_0_15;	// Read Data for Port 0 Lane 10
wire [DATA_WIDTH-1:0]    rb_15_rdata_1_15;	// Read Data for Port 1 Lane 10
`endif


`endif






`ifndef NUMBER_OF_WARPS_IS_16
assign bank_0_sel = ~warp_selector[2] & ~warp_selector[1] & ~warp_selector[0];
assign bank_1_sel = ~warp_selector[2] & ~warp_selector[1] & warp_selector[0];
assign bank_2_sel = ~warp_selector[2] & warp_selector[1]  & ~warp_selector[0];
assign bank_3_sel = ~warp_selector[2] & warp_selector[1]  & warp_selector[0];
assign bank_4_sel = warp_selector[2]  & ~warp_selector[1] & ~warp_selector[0];
assign bank_5_sel = warp_selector[2]  & ~warp_selector[1] & warp_selector[0];
assign bank_6_sel = warp_selector[2]  & warp_selector[1]  & ~warp_selector[0];
assign bank_7_sel = warp_selector[2]  & warp_selector[1]  & warp_selector[0];
`else
assign bank_0_sel =  ~warp_selector[3]  & ~warp_selector[2]  & ~warp_selector[1]  & ~warp_selector[0];
assign bank_1_sel =  ~warp_selector[3]  & ~warp_selector[2]  & ~warp_selector[1]  & warp_selector[0];
assign bank_2_sel =  ~warp_selector[3]  & ~warp_selector[2]  & warp_selector[1]   & ~warp_selector[0];
assign bank_3_sel =  ~warp_selector[3]  & ~warp_selector[2]  & warp_selector[1]   & warp_selector[0];
assign bank_4_sel =  ~warp_selector[3]  & warp_selector[2]   & ~warp_selector[1]  & ~warp_selector[0];
assign bank_5_sel =  ~warp_selector[3]  & warp_selector[2]   & ~warp_selector[1]  & warp_selector[0];
assign bank_6_sel =  ~warp_selector[3]  & warp_selector[2]   & warp_selector[1]   & ~warp_selector[0];
assign bank_7_sel =  ~warp_selector[3]  & warp_selector[2]   & warp_selector[1]   & warp_selector[0];
assign bank_8_sel =  warp_selector[3]   & ~warp_selector[2]  & ~warp_selector[1]  & ~warp_selector[0];
assign bank_9_sel =  warp_selector[3]   & ~warp_selector[2]  & ~warp_selector[1]  & warp_selector[0];
assign bank_10_sel = warp_selector[3]   & ~warp_selector[2]  & warp_selector[1]   & ~warp_selector[0];
assign bank_11_sel = warp_selector[3]   & ~warp_selector[2]  & warp_selector[1]   & warp_selector[0];
assign bank_12_sel = warp_selector[3]   & warp_selector[2]   & ~warp_selector[1]  & ~warp_selector[0];
assign bank_13_sel = warp_selector[3]   & warp_selector[2]   & ~warp_selector[1]  & warp_selector[0];
assign bank_14_sel = warp_selector[3]   & warp_selector[2]   & warp_selector[1]   & ~warp_selector[0];
assign bank_15_sel = warp_selector[3]   & warp_selector[2]   & warp_selector[1]   & warp_selector[0];

`endif


// Assign read data outputs


assign rdata_0_0	= bank_0_sel ?	rb_0_rdata_0_0	:
			  bank_1_sel ?	rb_1_rdata_0_0	:
			  bank_2_sel ?	rb_2_rdata_0_0	:
			  bank_3_sel ?	rb_3_rdata_0_0	:
			  bank_4_sel ?	rb_4_rdata_0_0	:
			  bank_5_sel ?	rb_5_rdata_0_0	:
			  bank_6_sel ?	rb_6_rdata_0_0	:
			  bank_7_sel ?	rb_7_rdata_0_0	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_0	:
			  bank_9_sel ?	rb_9_rdata_0_0	:
			  bank_10_sel ?	rb_10_rdata_0_0	:
			  bank_11_sel ?	rb_11_rdata_0_0	:
			  bank_12_sel ?	rb_12_rdata_0_0	:
			  bank_13_sel ?	rb_13_rdata_0_0	:
			  bank_14_sel ?	rb_14_rdata_0_0	:
			  bank_15_sel ?	rb_15_rdata_0_0	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_0	= bank_0_sel ?	rb_0_rdata_1_0	:
			  bank_1_sel ?	rb_1_rdata_1_0	:
			  bank_2_sel ?	rb_2_rdata_1_0	:
			  bank_3_sel ?	rb_3_rdata_1_0	:
			  bank_4_sel ?	rb_4_rdata_1_0	:
			  bank_5_sel ?	rb_5_rdata_1_0	:
			  bank_6_sel ?	rb_6_rdata_1_0	:
			  bank_7_sel ?	rb_7_rdata_1_0	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_0	:
			  bank_9_sel ?	rb_9_rdata_1_0	:
			  bank_10_sel ?	rb_10_rdata_1_0	:
			  bank_11_sel ?	rb_11_rdata_1_0	:
			  bank_12_sel ?	rb_12_rdata_1_0	:
			  bank_13_sel ?	rb_13_rdata_1_0	:
			  bank_14_sel ?	rb_14_rdata_1_0	:
			  bank_15_sel ?	rb_15_rdata_1_0	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_1	= bank_0_sel ?	rb_0_rdata_0_1	:
			  bank_1_sel ?	rb_1_rdata_0_1	:
			  bank_2_sel ?	rb_2_rdata_0_1	:
			  bank_3_sel ?	rb_3_rdata_0_1	:
			  bank_4_sel ?	rb_4_rdata_0_1	:
			  bank_5_sel ?	rb_5_rdata_0_1	:
			  bank_6_sel ?	rb_6_rdata_0_1	:
			  bank_7_sel ?	rb_7_rdata_0_1	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_1	:
			  bank_9_sel ?	rb_9_rdata_0_1	:
			  bank_10_sel ?	rb_10_rdata_0_1	:
			  bank_11_sel ?	rb_11_rdata_0_1	:
			  bank_12_sel ?	rb_12_rdata_0_1	:
			  bank_13_sel ?	rb_13_rdata_0_1	:
			  bank_14_sel ?	rb_14_rdata_0_1	:
			  bank_15_sel ?	rb_15_rdata_0_1	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_1	= bank_0_sel ?	rb_0_rdata_1_1	:
			  bank_1_sel ?	rb_1_rdata_1_1	:
			  bank_2_sel ?	rb_2_rdata_1_1	:
			  bank_3_sel ?	rb_3_rdata_1_1	:
			  bank_4_sel ?	rb_4_rdata_1_1	:
			  bank_5_sel ?	rb_5_rdata_1_1	:
			  bank_6_sel ?	rb_6_rdata_1_1	:
			  bank_7_sel ?	rb_7_rdata_1_1	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_1	:
			  bank_9_sel ?	rb_9_rdata_1_1	:
			  bank_10_sel ?	rb_10_rdata_1_1	:
			  bank_11_sel ?	rb_11_rdata_1_1	:
			  bank_12_sel ?	rb_12_rdata_1_1	:
			  bank_13_sel ?	rb_13_rdata_1_1	:
			  bank_14_sel ?	rb_14_rdata_1_1	:
			  bank_15_sel ?	rb_15_rdata_1_1	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_2	= bank_0_sel ?	rb_0_rdata_0_2	:
			  bank_1_sel ?	rb_1_rdata_0_2	:
			  bank_2_sel ?	rb_2_rdata_0_2	:
			  bank_3_sel ?	rb_3_rdata_0_2	:
			  bank_4_sel ?	rb_4_rdata_0_2	:
			  bank_5_sel ?	rb_5_rdata_0_2	:
			  bank_6_sel ?	rb_6_rdata_0_2	:
			  bank_7_sel ?	rb_7_rdata_0_2	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_2	:
			  bank_9_sel ?	rb_9_rdata_0_2	:
			  bank_10_sel ?	rb_10_rdata_0_2	:
			  bank_11_sel ?	rb_11_rdata_0_2	:
			  bank_12_sel ?	rb_12_rdata_0_2	:
			  bank_13_sel ?	rb_13_rdata_0_2	:
			  bank_14_sel ?	rb_14_rdata_0_2	:
			  bank_15_sel ?	rb_15_rdata_0_2	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_2	= bank_0_sel ?	rb_0_rdata_1_2	:
			  bank_1_sel ?	rb_1_rdata_1_2	:
			  bank_2_sel ?	rb_2_rdata_1_2	:
			  bank_3_sel ?	rb_3_rdata_1_2	:
			  bank_4_sel ?	rb_4_rdata_1_2	:
			  bank_5_sel ?	rb_5_rdata_1_2	:
			  bank_6_sel ?	rb_6_rdata_1_2	:
			  bank_7_sel ?	rb_7_rdata_1_2	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_2	:
			  bank_9_sel ?	rb_9_rdata_1_2	:
			  bank_10_sel ?	rb_10_rdata_1_2	:
			  bank_11_sel ?	rb_11_rdata_1_2	:
			  bank_12_sel ?	rb_12_rdata_1_2	:
			  bank_13_sel ?	rb_13_rdata_1_2	:
			  bank_14_sel ?	rb_14_rdata_1_2	:
			  bank_15_sel ?	rb_15_rdata_1_2	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_3	= bank_0_sel ?	rb_0_rdata_0_3	:
			  bank_1_sel ?	rb_1_rdata_0_3	:
			  bank_2_sel ?	rb_2_rdata_0_3	:
			  bank_3_sel ?	rb_3_rdata_0_3	:
			  bank_4_sel ?	rb_4_rdata_0_3	:
			  bank_5_sel ?	rb_5_rdata_0_3	:
			  bank_6_sel ?	rb_6_rdata_0_3	:
			  bank_7_sel ?	rb_7_rdata_0_3	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_3	:
			  bank_9_sel ?	rb_9_rdata_0_3	:
			  bank_10_sel ?	rb_10_rdata_0_3	:
			  bank_11_sel ?	rb_11_rdata_0_3	:
			  bank_12_sel ?	rb_12_rdata_0_3	:
			  bank_13_sel ?	rb_13_rdata_0_3	:
			  bank_14_sel ?	rb_14_rdata_0_3	:
			  bank_15_sel ?	rb_15_rdata_0_3	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_3	= bank_0_sel ?	rb_0_rdata_1_3	:
			  bank_1_sel ?	rb_1_rdata_1_3	:
			  bank_2_sel ?	rb_2_rdata_1_3	:
			  bank_3_sel ?	rb_3_rdata_1_3	:
			  bank_4_sel ?	rb_4_rdata_1_3	:
			  bank_5_sel ?	rb_5_rdata_1_3	:
			  bank_6_sel ?	rb_6_rdata_1_3	:
			  bank_7_sel ?	rb_7_rdata_1_3	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_3	:
			  bank_9_sel ?	rb_9_rdata_1_3	:
			  bank_10_sel ?	rb_10_rdata_1_3	:
			  bank_11_sel ?	rb_11_rdata_1_3	:
			  bank_12_sel ?	rb_12_rdata_1_3	:
			  bank_13_sel ?	rb_13_rdata_1_3	:
			  bank_14_sel ?	rb_14_rdata_1_3	:
			  bank_15_sel ?	rb_15_rdata_1_3	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_4	= bank_0_sel ?	rb_0_rdata_0_4	:
			  bank_1_sel ?	rb_1_rdata_0_4	:
			  bank_2_sel ?	rb_2_rdata_0_4	:
			  bank_3_sel ?	rb_3_rdata_0_4	:
			  bank_4_sel ?	rb_4_rdata_0_4	:
			  bank_5_sel ?	rb_5_rdata_0_4	:
			  bank_6_sel ?	rb_6_rdata_0_4	:
			  bank_7_sel ?	rb_7_rdata_0_4	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_4	:
			  bank_9_sel ?	rb_9_rdata_0_4	:
			  bank_10_sel ?	rb_10_rdata_0_4	:
			  bank_11_sel ?	rb_11_rdata_0_4	:
			  bank_12_sel ?	rb_12_rdata_0_4	:
			  bank_13_sel ?	rb_13_rdata_0_4	:
			  bank_14_sel ?	rb_14_rdata_0_4	:
			  bank_15_sel ?	rb_15_rdata_0_4	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_4	= bank_0_sel ?	rb_0_rdata_1_4	:
			  bank_1_sel ?	rb_1_rdata_1_4	:
			  bank_2_sel ?	rb_2_rdata_1_4	:
			  bank_3_sel ?	rb_3_rdata_1_4	:
			  bank_4_sel ?	rb_4_rdata_1_4	:
			  bank_5_sel ?	rb_5_rdata_1_4	:
			  bank_6_sel ?	rb_6_rdata_1_4	:
			  bank_7_sel ?	rb_7_rdata_1_4	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_4	:
			  bank_9_sel ?	rb_9_rdata_1_4	:
			  bank_10_sel ?	rb_10_rdata_1_4	:
			  bank_11_sel ?	rb_11_rdata_1_4	:
			  bank_12_sel ?	rb_12_rdata_1_4	:
			  bank_13_sel ?	rb_13_rdata_1_4	:
			  bank_14_sel ?	rb_14_rdata_1_4	:
			  bank_15_sel ?	rb_15_rdata_1_4	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif


assign rdata_0_5	= bank_0_sel ?	rb_0_rdata_0_5	:
			  bank_1_sel ?	rb_1_rdata_0_5	:
			  bank_2_sel ?	rb_2_rdata_0_5	:
			  bank_3_sel ?	rb_3_rdata_0_5	:
			  bank_4_sel ?	rb_4_rdata_0_5	:
			  bank_5_sel ?	rb_5_rdata_0_5	:
			  bank_6_sel ?	rb_6_rdata_0_5	:
			  bank_7_sel ?	rb_7_rdata_0_5	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_5	:
			  bank_9_sel ?	rb_9_rdata_0_5	:
			  bank_10_sel ?	rb_10_rdata_0_5	:
			  bank_11_sel ?	rb_11_rdata_0_5	:
			  bank_12_sel ?	rb_12_rdata_0_5	:
			  bank_13_sel ?	rb_13_rdata_0_5	:
			  bank_14_sel ?	rb_14_rdata_0_5	:
			  bank_15_sel ?	rb_15_rdata_0_5	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_5	= bank_0_sel ?	rb_0_rdata_1_5	:
			  bank_1_sel ?	rb_1_rdata_1_5	:
			  bank_2_sel ?	rb_2_rdata_1_5	:
			  bank_3_sel ?	rb_3_rdata_1_5	:
			  bank_4_sel ?	rb_4_rdata_1_5	:
			  bank_5_sel ?	rb_5_rdata_1_5	:
			  bank_6_sel ?	rb_6_rdata_1_5	:
			  bank_7_sel ?	rb_7_rdata_1_5	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_5	:
			  bank_9_sel ?	rb_9_rdata_1_5	:
			  bank_10_sel ?	rb_10_rdata_1_5	:
			  bank_11_sel ?	rb_11_rdata_1_5	:
			  bank_12_sel ?	rb_12_rdata_1_5	:
			  bank_13_sel ?	rb_13_rdata_1_5	:
			  bank_14_sel ?	rb_14_rdata_1_5	:
			  bank_15_sel ?	rb_15_rdata_1_5	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_6	= bank_0_sel ?	rb_0_rdata_0_6	:
			  bank_1_sel ?	rb_1_rdata_0_6	:
			  bank_2_sel ?	rb_2_rdata_0_6	:
			  bank_3_sel ?	rb_3_rdata_0_6	:
			  bank_4_sel ?	rb_4_rdata_0_6	:
			  bank_5_sel ?	rb_5_rdata_0_6	:
			  bank_6_sel ?	rb_6_rdata_0_6	:
			  bank_7_sel ?	rb_7_rdata_0_6	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_6	:
			  bank_9_sel ?	rb_9_rdata_0_6	:
			  bank_10_sel ?	rb_10_rdata_0_6	:
			  bank_11_sel ?	rb_11_rdata_0_6	:
			  bank_12_sel ?	rb_12_rdata_0_6	:
			  bank_13_sel ?	rb_13_rdata_0_6	:
			  bank_14_sel ?	rb_14_rdata_0_6	:
			  bank_15_sel ?	rb_15_rdata_0_6	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_6	= bank_0_sel ?	rb_0_rdata_1_6	:
			  bank_1_sel ?	rb_1_rdata_1_6	:
			  bank_2_sel ?	rb_2_rdata_1_6	:
			  bank_3_sel ?	rb_3_rdata_1_6	:
			  bank_4_sel ?	rb_4_rdata_1_6	:
			  bank_5_sel ?	rb_5_rdata_1_6	:
			  bank_6_sel ?	rb_6_rdata_1_6	:
			  bank_7_sel ?	rb_7_rdata_1_6	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_6	:
			  bank_9_sel ?	rb_9_rdata_1_6	:
			  bank_10_sel ?	rb_10_rdata_1_6	:
			  bank_11_sel ?	rb_11_rdata_1_6	:
			  bank_12_sel ?	rb_12_rdata_1_6	:
			  bank_13_sel ?	rb_13_rdata_1_6	:
			  bank_14_sel ?	rb_14_rdata_1_6	:
			  bank_15_sel ?	rb_15_rdata_1_6	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_7	= bank_0_sel ?	rb_0_rdata_0_7	:
			  bank_1_sel ?	rb_1_rdata_0_7	:
			  bank_2_sel ?	rb_2_rdata_0_7	:
			  bank_3_sel ?	rb_3_rdata_0_7	:
			  bank_4_sel ?	rb_4_rdata_0_7	:
			  bank_5_sel ?	rb_5_rdata_0_7	:
			  bank_6_sel ?	rb_6_rdata_0_7	:
			  bank_7_sel ?	rb_7_rdata_0_7	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_0_7	:
			  bank_9_sel ?	rb_9_rdata_0_7	:
			  bank_10_sel ?	rb_10_rdata_0_7	:
			  bank_11_sel ?	rb_11_rdata_0_7	:
			  bank_12_sel ?	rb_12_rdata_0_7	:
			  bank_13_sel ?	rb_13_rdata_0_7	:
			  bank_14_sel ?	rb_14_rdata_0_7	:
			  bank_15_sel ?	rb_15_rdata_0_7	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_7	= bank_0_sel ?	rb_0_rdata_1_7	:
			  bank_1_sel ?	rb_1_rdata_1_7	:
			  bank_2_sel ?	rb_2_rdata_1_7	:
			  bank_3_sel ?	rb_3_rdata_1_7	:
			  bank_4_sel ?	rb_4_rdata_1_7	:
			  bank_5_sel ?	rb_5_rdata_1_7	:
			  bank_6_sel ?	rb_6_rdata_1_7	:
			  bank_7_sel ?	rb_7_rdata_1_7	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel ?	rb_8_rdata_1_7	:
			  bank_9_sel ?	rb_9_rdata_1_7	:
			  bank_10_sel ?	rb_10_rdata_1_7	:
			  bank_11_sel ?	rb_11_rdata_1_7	:
			  bank_12_sel ?	rb_12_rdata_1_7	:
			  bank_13_sel ?	rb_13_rdata_1_7	:
			  bank_14_sel ?	rb_14_rdata_1_7	:
			  bank_15_sel ?	rb_15_rdata_1_7	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif



`ifdef NUMBER_OF_LANES_IS_16

assign rdata_0_8	= bank_0_sel  ?	 rb_0_rdata_0_8	:
			  bank_1_sel  ?	 rb_1_rdata_0_8	:
			  bank_2_sel  ?	 rb_2_rdata_0_8	:
			  bank_3_sel  ?	 rb_3_rdata_0_8	:
			  bank_4_sel  ?	 rb_4_rdata_0_8	:
			  bank_5_sel  ?	 rb_5_rdata_0_8	:
			  bank_6_sel  ?	 rb_6_rdata_0_8	:
			  bank_7_sel  ?  rb_7_rdata_0_8	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_8	:
			  bank_9_sel  ?	 rb_9_rdata_0_8	:
			  bank_10_sel ?	rb_10_rdata_0_8	:
			  bank_11_sel ?	rb_11_rdata_0_8	:
			  bank_12_sel ?	rb_12_rdata_0_8	:
			  bank_13_sel ?	rb_13_rdata_0_8	:
			  bank_14_sel ?	rb_14_rdata_0_8	:
			  bank_15_sel ?	rb_15_rdata_0_8	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_8	= bank_0_sel  ?	 rb_0_rdata_1_8	:
			  bank_1_sel  ?	 rb_1_rdata_1_8	:
			  bank_2_sel  ?  rb_2_rdata_1_8	:
			  bank_3_sel  ?	 rb_3_rdata_1_8	:
			  bank_4_sel  ?	 rb_4_rdata_1_8	:
			  bank_5_sel  ?	 rb_5_rdata_1_8	:
			  bank_6_sel  ?	 rb_6_rdata_1_8	:
			  bank_7_sel  ?	 rb_7_rdata_1_8	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_8	:
			  bank_9_sel  ?	 rb_9_rdata_1_8	:
			  bank_10_sel ?	rb_10_rdata_1_8	:
			  bank_11_sel ?	rb_11_rdata_1_8	:
			  bank_12_sel ?	rb_12_rdata_1_8	:
			  bank_13_sel ?	rb_13_rdata_1_8	:
			  bank_14_sel ?	rb_14_rdata_1_8	:
			  bank_15_sel ?	rb_15_rdata_1_8	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_9	= bank_0_sel  ?	 rb_0_rdata_0_9	:
			  bank_1_sel  ?	 rb_1_rdata_0_9	:
			  bank_2_sel  ?	 rb_2_rdata_0_9	:
			  bank_3_sel  ?	 rb_3_rdata_0_9	:
			  bank_4_sel  ?	 rb_4_rdata_0_9	:
			  bank_5_sel  ?	 rb_5_rdata_0_9	:
			  bank_6_sel  ?	 rb_6_rdata_0_9	:
			  bank_7_sel  ?  rb_7_rdata_0_9	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_9	:
			  bank_9_sel  ?	 rb_9_rdata_0_9	:
			  bank_10_sel ?	rb_10_rdata_0_9	:
			  bank_11_sel ?	rb_11_rdata_0_9	:
			  bank_12_sel ?	rb_12_rdata_0_9	:
			  bank_13_sel ?	rb_13_rdata_0_9	:
			  bank_14_sel ?	rb_14_rdata_0_9	:
			  bank_15_sel ?	rb_15_rdata_0_9	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_9	= bank_0_sel  ?	 rb_0_rdata_1_9	:
			  bank_1_sel  ?	 rb_1_rdata_1_9	:
			  bank_2_sel  ?  rb_2_rdata_1_9	:
			  bank_3_sel  ?	 rb_3_rdata_1_9	:
			  bank_4_sel  ?	 rb_4_rdata_1_9	:
			  bank_5_sel  ?	 rb_5_rdata_1_9	:
			  bank_6_sel  ?	 rb_6_rdata_1_9	:
			  bank_7_sel  ?	 rb_7_rdata_1_9	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_9	:
			  bank_9_sel  ?	 rb_9_rdata_1_9	:
			  bank_10_sel ?	rb_10_rdata_1_9	:
			  bank_11_sel ?	rb_11_rdata_1_9	:
			  bank_12_sel ?	rb_12_rdata_1_9	:
			  bank_13_sel ?	rb_13_rdata_1_9	:
			  bank_14_sel ?	rb_14_rdata_1_9	:
			  bank_15_sel ?	rb_15_rdata_1_9	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif


assign rdata_0_10	= bank_0_sel  ?	 rb_0_rdata_0_10	:
			  bank_1_sel  ?	 rb_1_rdata_0_10	:
			  bank_2_sel  ?	 rb_2_rdata_0_10	:
			  bank_3_sel  ?	 rb_3_rdata_0_10	:
			  bank_4_sel  ?	 rb_4_rdata_0_10	:
			  bank_5_sel  ?	 rb_5_rdata_0_10	:
			  bank_6_sel  ?	 rb_6_rdata_0_10	:
			  bank_7_sel  ?  rb_7_rdata_0_10	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_10	:
			  bank_9_sel  ?	 rb_9_rdata_0_10	:
			  bank_10_sel ?	rb_10_rdata_0_10	:
			  bank_11_sel ?	rb_11_rdata_0_10	:
			  bank_12_sel ?	rb_12_rdata_0_10	:
			  bank_13_sel ?	rb_13_rdata_0_10	:
			  bank_14_sel ?	rb_14_rdata_0_10	:
			  bank_15_sel ?	rb_15_rdata_0_10	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_10	= bank_0_sel  ?	 rb_0_rdata_1_10	:
			  bank_1_sel  ?	 rb_1_rdata_1_10	:
			  bank_2_sel  ?  rb_2_rdata_1_10	:
			  bank_3_sel  ?	 rb_3_rdata_1_10	:
			  bank_4_sel  ?	 rb_4_rdata_1_10	:
			  bank_5_sel  ?	 rb_5_rdata_1_10	:
			  bank_6_sel  ?	 rb_6_rdata_1_10	:
			  bank_7_sel  ?	 rb_7_rdata_1_10	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_10	:
			  bank_9_sel  ?	 rb_9_rdata_1_10	:
			  bank_10_sel ?	rb_10_rdata_1_10	:
			  bank_11_sel ?	rb_11_rdata_1_10	:
			  bank_12_sel ?	rb_12_rdata_1_10	:
			  bank_13_sel ?	rb_13_rdata_1_10	:
			  bank_14_sel ?	rb_14_rdata_1_10	:
			  bank_15_sel ?	rb_15_rdata_1_10	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_11	= bank_0_sel  ?	 rb_0_rdata_0_11	:
			  bank_1_sel  ?	 rb_1_rdata_0_11	:
			  bank_2_sel  ?	 rb_2_rdata_0_11	:
			  bank_3_sel  ?	 rb_3_rdata_0_11	:
			  bank_4_sel  ?	 rb_4_rdata_0_11	:
			  bank_5_sel  ?	 rb_5_rdata_0_11	:
			  bank_6_sel  ?	 rb_6_rdata_0_11	:
			  bank_7_sel  ?  rb_7_rdata_0_11	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_11	:
			  bank_9_sel  ?	 rb_9_rdata_0_11	:
			  bank_10_sel ?	rb_10_rdata_0_11	:
			  bank_11_sel ?	rb_11_rdata_0_11	:
			  bank_12_sel ?	rb_12_rdata_0_11	:
			  bank_13_sel ?	rb_13_rdata_0_11	:
			  bank_14_sel ?	rb_14_rdata_0_11	:
			  bank_15_sel ?	rb_15_rdata_0_11	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_11	= bank_0_sel  ?	 rb_0_rdata_1_11	:
			  bank_1_sel  ?	 rb_1_rdata_1_11	:
			  bank_2_sel  ?  rb_2_rdata_1_11	:
			  bank_3_sel  ?	 rb_3_rdata_1_11	:
			  bank_4_sel  ?	 rb_4_rdata_1_11	:
			  bank_5_sel  ?	 rb_5_rdata_1_11	:
			  bank_6_sel  ?	 rb_6_rdata_1_11	:
			  bank_7_sel  ?	 rb_7_rdata_1_11	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_11	:
			  bank_9_sel  ?	 rb_9_rdata_1_11	:
			  bank_10_sel ?	rb_10_rdata_1_11	:
			  bank_11_sel ?	rb_11_rdata_1_11	:
			  bank_12_sel ?	rb_12_rdata_1_11	:
			  bank_13_sel ?	rb_13_rdata_1_11	:
			  bank_14_sel ?	rb_14_rdata_1_11	:
			  bank_15_sel ?	rb_15_rdata_1_11	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_12	= bank_0_sel  ?	 rb_0_rdata_0_12	:
			  bank_1_sel  ?	 rb_1_rdata_0_12	:
			  bank_2_sel  ?	 rb_2_rdata_0_12	:
			  bank_3_sel  ?	 rb_3_rdata_0_12	:
			  bank_4_sel  ?	 rb_4_rdata_0_12	:
			  bank_5_sel  ?	 rb_5_rdata_0_12	:
			  bank_6_sel  ?	 rb_6_rdata_0_12	:
			  bank_7_sel  ?  rb_7_rdata_0_12	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_12	:
			  bank_9_sel  ?	 rb_9_rdata_0_12	:
			  bank_10_sel ?	rb_10_rdata_0_12	:
			  bank_11_sel ?	rb_11_rdata_0_12	:
			  bank_12_sel ?	rb_12_rdata_0_12	:
			  bank_13_sel ?	rb_13_rdata_0_12	:
			  bank_14_sel ?	rb_14_rdata_0_12	:
			  bank_15_sel ?	rb_15_rdata_0_12	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_12	= bank_0_sel  ?	 rb_0_rdata_1_12	:
			  bank_1_sel  ?	 rb_1_rdata_1_12	:
			  bank_2_sel  ?  rb_2_rdata_1_12	:
			  bank_3_sel  ?	 rb_3_rdata_1_12	:
			  bank_4_sel  ?	 rb_4_rdata_1_12	:
			  bank_5_sel  ?	 rb_5_rdata_1_12	:
			  bank_6_sel  ?	 rb_6_rdata_1_12	:
			  bank_7_sel  ?	 rb_7_rdata_1_12	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_12	:
			  bank_9_sel  ?	 rb_9_rdata_1_12	:
			  bank_10_sel ?	rb_10_rdata_1_12	:
			  bank_11_sel ?	rb_11_rdata_1_12	:
			  bank_12_sel ?	rb_12_rdata_1_12	:
			  bank_13_sel ?	rb_13_rdata_1_12	:
			  bank_14_sel ?	rb_14_rdata_1_12	:
			  bank_15_sel ?	rb_15_rdata_1_12	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_13	= bank_0_sel  ?	 rb_0_rdata_0_13	:
			  bank_1_sel  ?	 rb_1_rdata_0_13	:
			  bank_2_sel  ?	 rb_2_rdata_0_13	:
			  bank_3_sel  ?	 rb_3_rdata_0_13	:
			  bank_4_sel  ?	 rb_4_rdata_0_13	:
			  bank_5_sel  ?	 rb_5_rdata_0_13	:
			  bank_6_sel  ?	 rb_6_rdata_0_13	:
			  bank_7_sel  ?  rb_7_rdata_0_13	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_13	:
			  bank_9_sel  ?	 rb_9_rdata_0_13	:
			  bank_10_sel ?	rb_10_rdata_0_13	:
			  bank_11_sel ?	rb_11_rdata_0_13	:
			  bank_12_sel ?	rb_12_rdata_0_13	:
			  bank_13_sel ?	rb_13_rdata_0_13	:
			  bank_14_sel ?	rb_14_rdata_0_13	:
			  bank_15_sel ?	rb_15_rdata_0_13	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_13	= bank_0_sel  ?	 rb_0_rdata_1_13	:
			  bank_1_sel  ?	 rb_1_rdata_1_13	:
			  bank_2_sel  ?  rb_2_rdata_1_13	:
			  bank_3_sel  ?	 rb_3_rdata_1_13	:
			  bank_4_sel  ?	 rb_4_rdata_1_13	:
			  bank_5_sel  ?	 rb_5_rdata_1_13	:
			  bank_6_sel  ?	 rb_6_rdata_1_13	:
			  bank_7_sel  ?	 rb_7_rdata_1_13	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_13	:
			  bank_9_sel  ?	 rb_9_rdata_1_13	:
			  bank_10_sel ?	rb_10_rdata_1_13	:
			  bank_11_sel ?	rb_11_rdata_1_13	:
			  bank_12_sel ?	rb_12_rdata_1_13	:
			  bank_13_sel ?	rb_13_rdata_1_13	:
			  bank_14_sel ?	rb_14_rdata_1_13	:
			  bank_15_sel ?	rb_15_rdata_1_13	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_14	= bank_0_sel  ?	 rb_0_rdata_0_14	:
			  bank_1_sel  ?	 rb_1_rdata_0_14	:
			  bank_2_sel  ?	 rb_2_rdata_0_14	:
			  bank_3_sel  ?	 rb_3_rdata_0_14	:
			  bank_4_sel  ?	 rb_4_rdata_0_14	:
			  bank_5_sel  ?	 rb_5_rdata_0_14	:
			  bank_6_sel  ?	 rb_6_rdata_0_14	:
			  bank_7_sel  ?  rb_7_rdata_0_14	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_14	:
			  bank_9_sel  ?	 rb_9_rdata_0_14	:
			  bank_10_sel ?	rb_10_rdata_0_14	:
			  bank_11_sel ?	rb_11_rdata_0_14	:
			  bank_12_sel ?	rb_12_rdata_0_14	:
			  bank_13_sel ?	rb_13_rdata_0_14	:
			  bank_14_sel ?	rb_14_rdata_0_14	:
			  bank_15_sel ?	rb_15_rdata_0_14	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_14	= bank_0_sel  ?	 rb_0_rdata_1_14	:
			  bank_1_sel  ?	 rb_1_rdata_1_14	:
			  bank_2_sel  ?  rb_2_rdata_1_14	:
			  bank_3_sel  ?	 rb_3_rdata_1_14	:
			  bank_4_sel  ?	 rb_4_rdata_1_14	:
			  bank_5_sel  ?	 rb_5_rdata_1_14	:
			  bank_6_sel  ?	 rb_6_rdata_1_14	:
			  bank_7_sel  ?	 rb_7_rdata_1_14	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_14	:
			  bank_9_sel  ?	 rb_9_rdata_1_14	:
			  bank_10_sel ?	rb_10_rdata_1_14	:
			  bank_11_sel ?	rb_11_rdata_1_14	:
			  bank_12_sel ?	rb_12_rdata_1_14	:
			  bank_13_sel ?	rb_13_rdata_1_14	:
			  bank_14_sel ?	rb_14_rdata_1_14	:
			  bank_15_sel ?	rb_15_rdata_1_14	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_0_15	= bank_0_sel  ?	 rb_0_rdata_0_15	:
			  bank_1_sel  ?	 rb_1_rdata_0_15	:
			  bank_2_sel  ?	 rb_2_rdata_0_15	:
			  bank_3_sel  ?	 rb_3_rdata_0_15	:
			  bank_4_sel  ?	 rb_4_rdata_0_15	:
			  bank_5_sel  ?	 rb_5_rdata_0_15	:
			  bank_6_sel  ?	 rb_6_rdata_0_15	:
			  bank_7_sel  ?  rb_7_rdata_0_15	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_0_15	:
			  bank_9_sel  ?	 rb_9_rdata_0_15	:
			  bank_10_sel ?	rb_10_rdata_0_15	:
			  bank_11_sel ?	rb_11_rdata_0_15	:
			  bank_12_sel ?	rb_12_rdata_0_15	:
			  bank_13_sel ?	rb_13_rdata_0_15	:
			  bank_14_sel ?	rb_14_rdata_0_15	:
			  bank_15_sel ?	rb_15_rdata_0_15	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

assign rdata_1_15	= bank_0_sel  ?	 rb_0_rdata_1_15	:
			  bank_1_sel  ?	 rb_1_rdata_1_15	:
			  bank_2_sel  ?  rb_2_rdata_1_15	:
			  bank_3_sel  ?	 rb_3_rdata_1_15	:
			  bank_4_sel  ?	 rb_4_rdata_1_15	:
			  bank_5_sel  ?	 rb_5_rdata_1_15	:
			  bank_6_sel  ?	 rb_6_rdata_1_15	:
			  bank_7_sel  ?	 rb_7_rdata_1_15	:
			`ifdef NUMBER_OF_WARPS_IS_16
			  bank_8_sel  ?	 rb_8_rdata_1_15	:
			  bank_9_sel  ?	 rb_9_rdata_1_15	:
			  bank_10_sel ?	rb_10_rdata_1_15	:
			  bank_11_sel ?	rb_11_rdata_1_15	:
			  bank_12_sel ?	rb_12_rdata_1_15	:
			  bank_13_sel ?	rb_13_rdata_1_15	:
			  bank_14_sel ?	rb_14_rdata_1_15	:
			  bank_15_sel ?	rb_15_rdata_1_15	:
			`endif
			`ifdef DATA_WIDTH_IS_64
			  64'h0;
			`else
			  32'h0;
			`endif

`endif






// Instantiate a register bank per warp 


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 0					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank  #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_0	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_0_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_0_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_0_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_0_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_0_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_0_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_0_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_0_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_0_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_0_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_0_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_0_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_0_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_0_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_0_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_0_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_0_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_0_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_0_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_0_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_0_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_0_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_0_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_0_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_0_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_0_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_0_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_0_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_0_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_0_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_0_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_0_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_0_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_0_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_0_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);



///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 1					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank  #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_1	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_1_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_1_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_1_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_1_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_1_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_1_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_1_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_1_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_1_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_1_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_1_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_1_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_1_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_1_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_1_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_1_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_1_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_1_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_1_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_1_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_1_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_1_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_1_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_1_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_1_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_1_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_1_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_1_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_1_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_1_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_1_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_1_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_1_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_1_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_1_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 2					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank  #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_2	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_2_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_2_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_2_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_2_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_2_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_2_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_2_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_2_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_2_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_2_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_2_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_2_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_2_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_2_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_2_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_2_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_2_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_2_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_2_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_2_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_2_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_2_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_2_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_2_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_2_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_2_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_2_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_2_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_2_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_2_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_2_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_2_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_2_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_2_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_2_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);

///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 3					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank  #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_3	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_3_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_3_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_3_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_3_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_3_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_3_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_3_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_3_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_3_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_3_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_3_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_3_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_3_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_3_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_3_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_3_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_3_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_3_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_3_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_3_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_3_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_3_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_3_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_3_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_3_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_3_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_3_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_3_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_3_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_3_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_3_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_3_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_3_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_3_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_3_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);

///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 4					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank  #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_4	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_4_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_4_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_4_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_4_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_4_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_4_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_4_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_4_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_4_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_4_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_4_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_4_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_4_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_4_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_4_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_4_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_4_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_4_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_4_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_4_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_4_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_4_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_4_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_4_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_4_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_4_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_4_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_4_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_4_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_4_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_4_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_4_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_4_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_4_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_4_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);

///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 5					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_5	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_5_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_5_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_5_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_5_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_5_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_5_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_5_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_5_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_5_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_5_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_5_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_5_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_5_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_5_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_5_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_5_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_5_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_5_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_5_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_5_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_5_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_5_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_5_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_5_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_5_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_5_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_5_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_5_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_5_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_5_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_5_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_5_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_5_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_5_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_5_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 6					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4)) 
		RBANK_6	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_6_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_6_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_6_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_6_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_6_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_6_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_6_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_6_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_6_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_6_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_6_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_6_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_6_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_6_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_6_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_6_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_6_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_6_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_6_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_6_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_6_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_6_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_6_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_6_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_6_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_6_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_6_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_6_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_6_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_6_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_6_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_6_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_6_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_6_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_6_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 7					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_7	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_7_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_7_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_7_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_7_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_7_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_7_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_7_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_7_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_7_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_7_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_7_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_7_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_7_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_7_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_7_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_7_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_7_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_7_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_7_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_7_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_7_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_7_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_7_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_7_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_7_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_7_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_7_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_7_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_7_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_7_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_7_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_7_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_7_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_7_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_7_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


`ifdef NUMBER_OF_WARPS_IS_16 // Instanstiate 8 extra banks

///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 8					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4)) 
		RBANK_8	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_8_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_8_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_8_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_8_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_8_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_8_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_8_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_8_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_8_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_8_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_8_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_8_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_8_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_8_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_8_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_8_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_8_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_8_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_8_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_8_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_8_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_8_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_8_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_8_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_8_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_8_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_8_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_8_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_8_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_8_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_8_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_8_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_8_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_8_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_8_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 9					     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4)) 
		RBANK_9	(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_9_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_9_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_9_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_9_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_9_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_9_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_9_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_9_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_9_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_9_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_9_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_9_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_9_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_9_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_9_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_9_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_9_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_9_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_9_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_9_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_9_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_9_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_9_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_9_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_9_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_9_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_9_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_9_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_9_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_9_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_9_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_9_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_9_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_9_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_9_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 10				     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_10(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_10_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_10_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_10_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_10_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_10_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_10_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_10_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_10_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_10_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_10_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_10_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_10_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_10_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_10_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_10_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_10_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_10_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_10_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_10_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_10_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_10_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_10_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_10_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_10_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_10_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_10_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_10_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_10_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_10_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_10_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_10_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_10_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_10_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_10_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_10_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 11				     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4)) 
		RBANK_11(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_11_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_11_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_11_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_11_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_11_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_11_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_11_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_11_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_11_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_11_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_11_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_11_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_11_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_11_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_11_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_11_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_11_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_11_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_11_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_11_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_11_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_11_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_11_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_11_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_11_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_11_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_11_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_11_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_11_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_11_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_11_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_11_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_11_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_11_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_11_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 12				     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_12(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_12_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_12_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_12_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_12_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_12_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_12_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_12_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_12_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_12_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_12_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_12_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_12_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_12_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_12_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_12_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_12_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_12_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_12_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_12_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_12_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_12_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_12_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_12_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_12_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_12_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_12_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_12_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_12_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_12_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_12_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_12_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_12_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_12_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_12_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_12_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);

///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 13				     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_13(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_13_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_13_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_13_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_13_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_13_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_13_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_13_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_13_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_13_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_13_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_13_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_13_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_13_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_13_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_13_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_13_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_13_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_13_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_13_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_13_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_13_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_13_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_13_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_13_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_13_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_13_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_13_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_13_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_13_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_13_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_13_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_13_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_13_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_13_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_13_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 14				     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_14(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_14_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_14_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_14_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_14_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_14_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_14_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_14_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_14_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_14_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_14_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_14_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_14_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_14_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_14_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_14_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_14_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_14_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_14_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_14_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_14_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_14_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_14_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_14_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_14_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_14_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_14_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_14_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_14_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_14_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_14_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_14_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_14_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_14_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_14_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_14_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


///////////////////////////////////////////////////////////////////////////////////////////////////////
//				 		REGISTER BANK 15				     //
///////////////////////////////////////////////////////////////////////////////////////////////////////		
register_bank   #(.NUM_LANES(8), .DATA_WIDTH(32), .NUM_REGS(16), .LOG2_NUM_REGS(4))
		RBANK_15(
		// Input ports common to all lanes
			.clk				(clk), 
			.rst_n				(rst_n),
			.read_en_0			(read_en_0 & {NUM_LANES{bank_15_sel}}),
			.read_en_1			(read_en_1 & {NUM_LANES{bank_15_sel}}), 
			.raddr_0			(raddr_0),
			.raddr_1			(raddr_1), 
			.write_en			(write_en  & {NUM_LANES{bank_15_sel}}), 
		// lane specific wdata port
			.wdata_0			(wdata_0),	// Wdata for Lane 0
			.wdata_1			(wdata_1),	// Wdata for Lane 1
			.wdata_2			(wdata_2),	// Wdata for Lane 2
			.wdata_3			(wdata_3),	// Wdata for Lane 3
			.wdata_4			(wdata_4),	// Wdata for Lane 4
			.wdata_5			(wdata_5),	// Wdata for Lane 5
			.wdata_6			(wdata_6),	// Wdata for Lane 6
			.wdata_7			(wdata_7),	// Wdata for Lane 7
	`ifdef NUM_LANES_IS_16
			.wdata_8			(wdata_8),	// Wdata for Lane 8
			.wdata_9			(wdata_9),	// Wdata for Lane 9
			.wdata_10			(wdata_10),	// Wdata for Lane 10
			.wdata_11			(wdata_11),	// Wdata for Lane 11
			.wdata_12			(wdata_12),	// Wdata for Lane 12
			.wdata_13			(wdata_13),	// Wdata for Lane 13
			.wdata_14			(wdata_14),	// Wdata for Lane 14
			.wdata_15			(wdata_15),	// Wdata for Lane 15
	`endif
		// Output rdata for each lane
			.rdata_0_0			(rb_15_rdata_0_0),	// Lane 0 
			.rdata_1_0			(rb_15_rdata_1_0),	// Lane 0 
			.rdata_0_1			(rb_15_rdata_0_1),	// Lane 1 
			.rdata_1_1			(rb_15_rdata_1_1),	// Lane 1 
			.rdata_0_2			(rb_15_rdata_0_2),	// Lane 2 
			.rdata_1_2			(rb_15_rdata_1_2),	// Lane 2 
			.rdata_0_3			(rb_15_rdata_0_3),	// Lane 3 
			.rdata_1_3			(rb_15_rdata_1_3),	// Lane 3 
			.rdata_0_4			(rb_15_rdata_0_4),	// Lane 4 
			.rdata_1_4			(rb_15_rdata_1_4),	// Lane 4 
			.rdata_0_5			(rb_15_rdata_0_5),	// Lane 5 
			.rdata_1_5			(rb_15_rdata_1_5),	// Lane 5 
			.rdata_0_6			(rb_15_rdata_0_6),	// Lane 6 
			.rdata_1_6			(rb_15_rdata_1_6),	// Lane 6 
			.rdata_0_7			(rb_15_rdata_0_7),	// Lane 7 
			.rdata_1_7			(rb_15_rdata_1_7),	// Lane 7 
	`ifdef NUM_LANES_IS_16
			.rdata_0_8			(rb_15_rdata_0_8),	// Lane 8 
			.rdata_1_8			(rb_15_rdata_1_8),	// Lane 8 
			.rdata_0_9			(rb_15_rdata_0_9),	// Lane 9 
			.rdata_1_9			(rb_15_rdata_1_9),	// Lane 9 
			.rdata_0_10			(rb_15_rdata_0_10),	// Lane 10 
			.rdata_1_10			(rb_15_rdata_1_10),	// Lane 10 
			.rdata_0_11			(rb_15_rdata_0_11),	// Lane 11 
			.rdata_1_11			(rb_15_rdata_1_11),	// Lane 11 
			.rdata_0_12			(rb_15_rdata_0_12),	// Lane 12 
			.rdata_1_12			(rb_15_rdata_1_12),	// Lane 12 
			.rdata_0_13			(rb_15_rdata_0_13),	// Lane 13 
			.rdata_1_13			(rb_15_rdata_1_13),	// Lane 13 
			.rdata_0_14			(rb_15_rdata_0_14),	// Lane 14 
			.rdata_1_14			(rb_15_rdata_1_14),	// Lane 14 
			.rdata_0_15			(rb_15_rdata_0_15),	// Lane 15 
			.rdata_1_15			(rb_15_rdata_1_15),	// Lane 15 
	`endif		
			.waddr				(waddr)
			);


`endif			// If Number of warps is 16







endmodule
			
