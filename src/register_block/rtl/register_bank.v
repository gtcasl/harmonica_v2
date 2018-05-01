// Owner: Poulami Das
// Module Name: register_bank
// Description: The module instantiates a register file per lane


module register_bank  #(parameter NUM_LANES=8, DATA_WIDTH=32, NUM_REGS=16, LOG2_NUM_REGS=4)
			(
		// Input ports common to all lanes
			clk, 
			rst_n,
			read_en_0,
			read_en_1, 
			raddr_0,
			raddr_1, 
			write_en, 
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
			waddr
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
// Instantiate register iles per lane


//////////////////////////////////////////////////////////////////////
//				LANE 0				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_0(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[0], read_en_0[0]}),
			.write_en(write_en[0]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_0),
			.rdata_0(rdata_0_0),
			.rdata_1(rdata_1_0)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 1				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
			  .NUM_REGS(16),
			  .LOG2_NUM_REGS(4))
		RF_LANE_1(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[1], read_en_0[1]}),
			.write_en(write_en[1]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_1),
			.rdata_0(rdata_0_1),
			.rdata_1(rdata_1_1)
			);



//////////////////////////////////////////////////////////////////////
//				LANE 2				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_2(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[2], read_en_0[2]}),
			.write_en(write_en[2]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_2),
			.rdata_0(rdata_0_2),
			.rdata_1(rdata_1_2)
			);


//////////////////////////////////////////////////////////////////////
//				LANE 3				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_3(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[3], read_en_0[3]}),
			.write_en(write_en[3]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_3),
			.rdata_0(rdata_0_3),
			.rdata_1(rdata_1_3)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 4				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_4(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[4], read_en_0[4]}),
			.write_en(write_en[4]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_4),
			.rdata_0(rdata_0_4),
			.rdata_1(rdata_1_4)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 5				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_5 (
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[5], read_en_0[5]}),
			.write_en(write_en[5]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_5),
			.rdata_0(rdata_0_5),
			.rdata_1(rdata_1_5)
			);


//////////////////////////////////////////////////////////////////////
//				LANE 6				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_6(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[6], read_en_0[6]}),
			.write_en(write_en[6]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_6),
			.rdata_0(rdata_0_6),
			.rdata_1(rdata_1_6)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 7				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_7(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[7], read_en_0[7]}),
			.write_en(write_en[7]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_7),
			.rdata_0(rdata_0_7),
			.rdata_1(rdata_1_7)
			);


`ifdef NUM_LANES_IS_16
//////////////////////////////////////////////////////////////////////
//				LANE 8				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_8(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[8], read_en_0[8]}),
			.write_en(write_en[8]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_8),
			.rdata_0(rdata_0_8),
			.rdata_1(rdata_1_8)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 9				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_9(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[9], read_en_0[9]}),
			.write_en(write_en[9]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_9),
			.rdata_0(rdata_0_9),
			.rdata_1(rdata_1_9)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 10				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_10(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[10], read_en_0[10]}),
			.write_en(write_en[10]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_10),
			.rdata_0(rdata_0_10),
			.rdata_1(rdata_1_10)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 11				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_11(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[11], read_en_0[11]}),
			.write_en(write_en[11]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_11),
			.rdata_0(rdata_0_11),
			.rdata_1(rdata_1_11)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 12				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_12(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[12], read_en_0[12]}),
			.write_en(write_en[12]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_12),
			.rdata_0(rdata_0_12),
			.rdata_1(rdata_1_12)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 13				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_13(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[13], read_en_0[13]}),
			.write_en(write_en[13]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_13),
			.rdata_0(rdata_0_13),
			.rdata_1(rdata_1_13)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 14				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_14(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[14], read_en_0[14]}),
			.write_en(write_en[14]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_14),
			.rdata_0(rdata_0_14),
			.rdata_1(rdata_1_14)
			);

//////////////////////////////////////////////////////////////////////
//				LANE 15				    //
//////////////////////////////////////////////////////////////////////

register_file 		#(.DATA_WIDTH(32), 
                          .NUM_REGS(16),
                          .LOG2_NUM_REGS(4))
		RF_LANE_15(
			.clk(clk),
			.reset_n(rst_n),
			.read_en({read_en_1[15], read_en_0[15]}),
			.write_en(write_en[15]),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata_15),
			.rdata_0(rdata_0_15),
			.rdata_1(rdata_1_15)
			);
`endif
endmodule			
