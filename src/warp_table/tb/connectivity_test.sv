module tb();


reg clk;
reg rst_n;
reg read_en;
reg write_en;
reg [43:0] write_data; // write data

wire [43:0] read_data;
wire 	    fifo_empty;
wire 	    fifo_vacant;
wire 	    fifo_full;
wire	    read_valid;

warp_table	WT	(
			clk, 
			rst_n, 
			read_en,
			write_en,
			read_data,
			read_valid,
			write_data,
			fifo_empty,
			fifo_vacant,
			fifo_full
			);


initial
begin
	$display("===================================Warp Table sanity check test===================================\n");
	clk = 1'b0;
	rst_n = 1'b0;
	#20
	// Drive safe values
	rst_n = 1'b0;
	read_en = 1'b0;
	write_en = 1'b0;
	write_data = 43'h0;
	#20
	rst_n = 1'b1;
	read_en	= 1'h1;	
	if(tb.WT.read_valid == 1'b1)
		$error("Incorrect read\n");
	#20
	read_en	= 1'h0;	
	write_en = 1'h1;
	write_data= $random();
	#20
	write_en = 1'h1;
	write_data= $random();
	#20
	read_en	= 1'h1;	
	write_en = 1'h0;
	#20	
	if(tb.WT.read_valid == 1'b0)
		$error("Incorrect read\n");
	#20 
	if(tb.WT.read_valid == 1'b0)
		$error("Incorrect read\n");
	#20 // should give an invalid read
	if(tb.WT.read_valid == 1'b1)
		$error("Incorrect read\n");
	#20
	$finish();
end

always
#10 clk = !clk;

endmodule
