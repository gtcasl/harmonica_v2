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
reg  [43:0] written_data[0:127];


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

integer i;

initial
begin
	$display("===================================Warp Table Overflow Test===================================\n");
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
	$display("================================== Writing FIFO entries ===================================\n");
	for(i= 0; i<200; i=i+1)
	begin
		write_en = 1'h1;
		read_en = 1'b0;
		write_data= $random();
		#20;
		write_en = 1'h0;
		read_en  = 1'b1;
		#20;
		if(tb.WT.read_data != write_data)
			$error("Error in reading from the FIFOs...\n");
		if(tb.WT.read_valid != 1'b1)
			$error("Error in read valid signal...\n");
	end
	#20
	$finish();
end

always
#10 clk = !clk;

endmodule
