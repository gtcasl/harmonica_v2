// Required macros
`define RDATA tb.RBLOCK.rdata_
`define REG(port_idx, lane_idx) `RDATA``port_idx``_``lane_idx`` 

task check_value;
	input warp_num; 
	input port_num;
	input lane_num;
	input reg_value;
	input expected_reg_value;
begin
	if(reg_value!=expected_reg_value)
        begin
		$error("Check Failed for Warp %d\n", warp_num);
		$error("Error in register read through port number %d of Lane %d, Expected value is %h and Actual value is %h \n", port_num, lane_num, expected_reg_value, reg_value);
	end
end
endtask
task check_port_0_all_lanes;
	input warp_num;
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
			check_value(warp_num, 0,0, `REG(0,0), wdata_0);
			check_value(warp_num, 0,1, `REG(0,1), wdata_1);
			check_value(warp_num, 0,2, `REG(0,2), wdata_2);
			check_value(warp_num, 0,3, `REG(0,3), wdata_3);
			check_value(warp_num, 0,4, `REG(0,4), wdata_4);
			check_value(warp_num, 0,5, `REG(0,5), wdata_5);
			check_value(warp_num, 0,6, `REG(0,6), wdata_6);
			check_value(warp_num, 0,7, `REG(0,7), wdata_7);
end
endtask
task check_port_1_all_lanes;
	input warp_num;
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
			check_value(warp_num, 1,0, `REG(1,0), wdata_0);
			check_value(warp_num, 1,1, `REG(1,1), wdata_1);
			check_value(warp_num, 1,2, `REG(1,2), wdata_2);
			check_value(warp_num, 1,3, `REG(1,3), wdata_3);
			check_value(warp_num, 1,4, `REG(1,4), wdata_4);
			check_value(warp_num, 1,5, `REG(1,5), wdata_5);
			check_value(warp_num, 1,6, `REG(1,6), wdata_6);
			check_value(warp_num, 1,7, `REG(1,7), wdata_7);
end
endtask
`ifdef NUM_LANES_IS_16
task check_port_0_all_16_lanes;
	input warp_num;
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
			check_value(warp_num, 0,0, `REG(0,0), wdata_0);
			check_value(warp_num, 0,1, `REG(0,1), wdata_1);
			check_value(warp_num, 0,2, `REG(0,2), wdata_2);
			check_value(warp_num, 0,3, `REG(0,3), wdata_3);
			check_value(warp_num, 0,4, `REG(0,4), wdata_4);
			check_value(warp_num, 0,5, `REG(0,5), wdata_5);
			check_value(warp_num, 0,6, `REG(0,6), wdata_6);
			check_value(warp_num, 0,7, `REG(0,7), wdata_7);
			check_value(warp_num, 0,8, `REG(0,8), wdata_8);
			check_value(warp_num, 0,9, `REG(0,9), wdata_9);
			check_value(warp_num, 0,10, `REG(0,10), wdata_10);
			check_value(warp_num, 0,11, `REG(0,11), wdata_11);
			check_value(warp_num, 0,12, `REG(0,12), wdata_12);
			check_value(warp_num, 0,13, `REG(0,13), wdata_13);
			check_value(warp_num, 0,14, `REG(0,14), wdata_14);
			check_value(warp_num, 0,15, `REG(0,15), wdata_15);
end
endtask
task check_port_1_all_16_lanes;
	input warp_num;
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
			check_value(warp_num, 1,0, `REG(1,0), wdata_0);
			check_value(warp_num, 1,1, `REG(1,1), wdata_1);
			check_value(warp_num, 1,2, `REG(1,2), wdata_2);
			check_value(warp_num, 1,3, `REG(1,3), wdata_3);
			check_value(warp_num, 1,4, `REG(1,4), wdata_4);
			check_value(warp_num, 1,5, `REG(1,5), wdata_5);
			check_value(warp_num, 1,6, `REG(1,6), wdata_6);
			check_value(warp_num, 1,7, `REG(1,7), wdata_7);
			check_value(warp_num, 1,8, `REG(1,8), wdata_8);
			check_value(warp_num, 1,9, `REG(1,9), wdata_9);
			check_value(warp_num, 1,10, `REG(1,10), wdata_10);
			check_value(warp_num, 1,11, `REG(1,11), wdata_11);
			check_value(warp_num, 1,12, `REG(1,12), wdata_12);
			check_value(warp_num, 1,13, `REG(1,13), wdata_13);
			check_value(warp_num, 1,14, `REG(1,14), wdata_14);
			check_value(warp_num, 1,15, `REG(1,15), wdata_15);
end
endtask
`endif
