`ifdef NUM_LANES_IS_16
     defparam RBANK.NUM_LANES = 16;
`endif	
`ifdef NUMBER_OF_REGISTERS_IS_32
     defparam RBANK.NUM_REGS = 32;
     defparam RBANK.RF_LANE_0.NUM_REGS = 32;
     defparam RBANK.RF_LANE_1.NUM_REGS = 32;
     defparam RBANK.RF_LANE_2.NUM_REGS = 32;
     defparam RBANK.RF_LANE_3.NUM_REGS = 32;
     defparam RBANK.RF_LANE_4.NUM_REGS = 32;
     defparam RBANK.RF_LANE_5.NUM_REGS = 32;
     defparam RBANK.RF_LANE_6.NUM_REGS = 32;
     defparam RBANK.RF_LANE_7.NUM_REGS = 32;
     `ifdef NUM_LANES_IS_16
     defparam RBANK.RF_LANE_8.NUM_REGS = 32;
     defparam RBANK.RF_LANE_9.NUM_REGS = 32;
     defparam RBANK.RF_LANE_10.NUM_REGS = 32;
     defparam RBANK.RF_LANE_11.NUM_REGS = 32;
     defparam RBANK.RF_LANE_12.NUM_REGS = 32;
     defparam RBANK.RF_LANE_13.NUM_REGS = 32;
     defparam RBANK.RF_LANE_14.NUM_REGS = 32;
     defparam RBANK.RF_LANE_15.NUM_REGS = 32;
    `endif
     defparam RBANK.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_0.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_1.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_2.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_3.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_4.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_5.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_6.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_7.LOG2_NUM_REGS = 5;
     `ifdef NUM_LANES_IS_16
     defparam RBANK.RF_LANE_8.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_9.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_10.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_11.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_12.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_13.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_14.LOG2_NUM_REGS = 5;
     defparam RBANK.RF_LANE_15.LOG2_NUM_REGS = 5;
    `endif
`elsif NUMBER_OF_REGISTERS_IS_64 
     defparam RBANK.NUM_REGS = 64;
     defparam RBANK.RF_LANE_0.NUM_REGS = 64;
     defparam RBANK.RF_LANE_1.NUM_REGS = 64;
     defparam RBANK.RF_LANE_2.NUM_REGS = 64;
     defparam RBANK.RF_LANE_3.NUM_REGS = 64;
     defparam RBANK.RF_LANE_4.NUM_REGS = 64;
     defparam RBANK.RF_LANE_5.NUM_REGS = 64;
     defparam RBANK.RF_LANE_6.NUM_REGS = 64;
     defparam RBANK.RF_LANE_7.NUM_REGS = 64;
     `ifdef NUM_LANES_IS_16
     defparam RBANK.RF_LANE_8.NUM_REGS = 64;
     defparam RBANK.RF_LANE_9.NUM_REGS = 64;
     defparam RBANK.RF_LANE_10.NUM_REGS = 64;
     defparam RBANK.RF_LANE_11.NUM_REGS = 64;
     defparam RBANK.RF_LANE_12.NUM_REGS = 64;
     defparam RBANK.RF_LANE_13.NUM_REGS = 64;
     defparam RBANK.RF_LANE_14.NUM_REGS = 64;
     defparam RBANK.RF_LANE_15.NUM_REGS = 64;
    `endif
     defparam RBANK.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_0.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_1.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_2.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_3.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_4.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_5.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_6.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_7.LOG2_NUM_REGS = 6;
     `ifdef NUM_LANES_IS_16
     defparam RBANK.RF_LANE_8.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_9.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_10.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_11.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_12.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_13.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_14.LOG2_NUM_REGS = 6;
     defparam RBANK.RF_LANE_15.LOG2_NUM_REGS = 6;
    `endif
`endif
`ifdef DATA_WIDTH_IS_64 
     defparam RBANK.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_0.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_1.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_2.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_3.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_4.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_5.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_6.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_7.DATA_WIDTH = 64;
     `ifdef NUM_LANES_IS_16
     defparam RBANK.RF_LANE_8.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_9.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_10.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_11.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_12.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_13.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_14.DATA_WIDTH = 64;
     defparam RBANK.RF_LANE_15.DATA_WIDTH = 64;
    `endif
`endif
// Required macros
`define RDATA tb.RBANK.rdata_
`define REG(port_idx, lane_idx) `RDATA``port_idx``_``lane_idx`` 
task check_value;
	input port_num;
	input lane_num;
	`ifdef DATA_WIDTH_IS_32
	input [31:0] reg_value;
	input [31:0] expected_reg_value;
	`else 
	input [63:0] reg_value;
	input [63:0] expected_reg_value;
	`endif 
begin
	if(reg_value!=expected_reg_value)
		$error("Error in register read through port number %h of Lane %h, Expected value is %h and Actual value is %h \n", port_num, lane_num, expected_reg_value, reg_value);
end
endtask
task check_port_0_all_lanes;
	`ifdef DATA_WIDTH_IS_32
	input [31:0] wdata_0;
	input [31:0] wdata_1;
	input [31:0] wdata_2;
	input [31:0] wdata_3;
	input [31:0] wdata_4;
	input [31:0] wdata_5;
	input [31:0] wdata_6;
	input [31:0] wdata_7;
	`else
	input [63:0] wdata_0;
	input [63:0] wdata_1;
	input [63:0] wdata_2;
	input [63:0] wdata_3;
	input [63:0] wdata_4;
	input [63:0] wdata_5;
	input [63:0] wdata_6;
	input [63:0] wdata_7;
	`endif
// For Debug purposes only:	$display("Check Values on Port 0 of all lanes \n");
begin
			check_value(0,0, `REG(0,0), wdata_0);
			check_value(0,1, `REG(0,1), wdata_1);
			check_value(0,2, `REG(0,2), wdata_2);
			check_value(0,3, `REG(0,3), wdata_3);
			check_value(0,4, `REG(0,4), wdata_4);
			check_value(0,5, `REG(0,5), wdata_5);
			check_value(0,6, `REG(0,6), wdata_6);
			check_value(0,7, `REG(0,7), wdata_7);
end
endtask
task check_port_1_all_lanes;
	`ifdef DATA_WIDTH_IS_32
	input [31:0] wdata_0;
	input [31:0] wdata_1;
	input [31:0] wdata_2;
	input [31:0] wdata_3;
	input [31:0] wdata_4;
	input [31:0] wdata_5;
	input [31:0] wdata_6;
	input [31:0] wdata_7;
	`else
	input [63:0] wdata_0;
	input [63:0] wdata_1;
	input [63:0] wdata_2;
	input [63:0] wdata_3;
	input [63:0] wdata_4;
	input [63:0] wdata_5;
	input [63:0] wdata_6;
	input [63:0] wdata_7;
	`endif

// For Debug purposes only:	$display("Check Values on Port 1 of all lanes \n");
begin
			check_value(1,0, `REG(1,0), wdata_0);
			check_value(1,1, `REG(1,1), wdata_1);
			check_value(1,2, `REG(1,2), wdata_2);
			check_value(1,3, `REG(1,3), wdata_3);
			check_value(1,4, `REG(1,4), wdata_4);
			check_value(1,5, `REG(1,5), wdata_5);
			check_value(1,6, `REG(1,6), wdata_6);
			check_value(1,7, `REG(1,7), wdata_7);
end
endtask
`ifdef NUM_LANES_IS_16
task check_port_0_all_16_lanes;
	`ifdef DATA_WIDTH_IS_32
	input [31:0] wdata_0;
	input [31:0] wdata_1;
	input [31:0] wdata_2;
	input [31:0] wdata_3;
	input [31:0] wdata_4;
	input [31:0] wdata_5;
	input [31:0] wdata_6;
	input [31:0] wdata_7;
	input [31:0] wdata_8;
	input [31:0] wdata_9;
	input [31:0] wdata_10;
	input [31:0] wdata_11;
	input [31:0] wdata_12;
	input [31:0] wdata_13;
	input [31:0] wdata_14;
	input [31:0] wdata_15;
	`else
	input [63:0] wdata_0;
	input [63:0] wdata_1;
	input [63:0] wdata_2;
	input [63:0] wdata_3;
	input [63:0] wdata_4;
	input [63:0] wdata_5;
	input [63:0] wdata_6;
	input [63:0] wdata_7;
	input [63:0] wdata_8;
	input [63:0] wdata_9;
	input [63:0] wdata_10;
	input [63:0] wdata_11;
	input [63:0] wdata_12;
	input [63:0] wdata_13;
	input [63:0] wdata_14;
	input [63:0] wdata_15;
	`endif
// For Debug purposes only:	$display("Check Values on Port 0 of all lanes \n");
begin
			check_value(0,0, `REG(0,0), wdata_0);
			check_value(0,1, `REG(0,1), wdata_1);
			check_value(0,2, `REG(0,2), wdata_2);
			check_value(0,3, `REG(0,3), wdata_3);
			check_value(0,4, `REG(0,4), wdata_4);
			check_value(0,5, `REG(0,5), wdata_5);
			check_value(0,6, `REG(0,6), wdata_6);
			check_value(0,7, `REG(0,7), wdata_7);
			check_value(0,8, `REG(0,8), wdata_8);
			check_value(0,9, `REG(0,9), wdata_9);
			check_value(0,10, `REG(0,10), wdata_10);
			check_value(0,11, `REG(0,11), wdata_11);
			check_value(0,12, `REG(0,12), wdata_12);
			check_value(0,13, `REG(0,13), wdata_13);
			check_value(0,14, `REG(0,14), wdata_14);
			check_value(0,15, `REG(0,15), wdata_15);
end
endtask
task check_port_1_all_16_lanes;
	`ifdef DATA_WIDTH_IS_32
	input [31:0] wdata_0;
	input [31:0] wdata_1;
	input [31:0] wdata_2;
	input [31:0] wdata_3;
	input [31:0] wdata_4;
	input [31:0] wdata_5;
	input [31:0] wdata_6;
	input [31:0] wdata_7;
	input [31:0] wdata_8;
	input [31:0] wdata_9;
	input [31:0] wdata_10;
	input [31:0] wdata_11;
	input [31:0] wdata_12;
	input [31:0] wdata_13;
	input [31:0] wdata_14;
	input [31:0] wdata_15;
	`else
	input [63:0] wdata_0;
	input [63:0] wdata_1;
	input [63:0] wdata_2;
	input [63:0] wdata_3;
	input [63:0] wdata_4;
	input [63:0] wdata_5;
	input [63:0] wdata_6;
	input [63:0] wdata_7;
	input [63:0] wdata_8;
	input [63:0] wdata_9;
	input [63:0] wdata_10;
	input [63:0] wdata_11;
	input [63:0] wdata_12;
	input [63:0] wdata_13;
	input [63:0] wdata_14;
	input [63:0] wdata_15;
	`endif

// For Debug purposes only:	$display("Check Values on Port 0 of all lanes \n");
begin
			check_value(1,0, `REG(1,0), wdata_0);
			check_value(1,1, `REG(1,1), wdata_1);
			check_value(1,2, `REG(1,2), wdata_2);
			check_value(1,3, `REG(1,3), wdata_3);
			check_value(1,4, `REG(1,4), wdata_4);
			check_value(1,5, `REG(1,5), wdata_5);
			check_value(1,6, `REG(1,6), wdata_6);
			check_value(1,7, `REG(1,7), wdata_7);
			check_value(1,8, `REG(1,8), wdata_8);
			check_value(1,9, `REG(1,9), wdata_9);
			check_value(1,10, `REG(1,10), wdata_10);
			check_value(1,11, `REG(1,11), wdata_11);
			check_value(1,12, `REG(1,12), wdata_12);
			check_value(1,13, `REG(1,13), wdata_13);
			check_value(1,14, `REG(1,14), wdata_14);
			check_value(1,15, `REG(1,15), wdata_15);
end
endtask
`endif
