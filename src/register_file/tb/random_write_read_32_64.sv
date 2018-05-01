module tb();

reg 	  clock;
reg 	  reset_n;
reg [1:0] read_en;
reg       write_en;
reg [4:0] raddr_0;
reg [4:0] raddr_1;
reg [4:0] waddr;
reg [63:0]wdata;
reg [4:0]waddr_next;

wire [63:0] rdata_0;
wire [63:0] rdata_1;

// Instantiate the register file

register_file	RF_32	(
			.clk(clock),
			.reset_n(reset_n),
			.read_en(read_en),
			.write_en(write_en),
			.raddr_0(raddr_0),
			.raddr_1(raddr_1),
			.waddr(waddr),
			.wdata(wdata),
			.rdata_0(rdata_0),
			.rdata_1(rdata_1)
			);

`include "register_cfg.v"
initial 
begin
	clock   = 1'b0;
	reset_n = 1'b0;
	raddr_0 = 5'h0;
	raddr_1 = 5'h0;
	waddr   = 5'h0;
	waddr_next  = 5'h0;
	wdata   = 64'h0;
	write_en= 1'b0;
	read_en = 2'h0;
end

always 
  #5 clock = !clock;


initial 
begin
	$display("======================= Writing to each register and reading back test ======================\n");
#10 
	reset_n <= 1'b1; // Withdraw reset
     for(int k =1; k<=32; k++) // Loop for every register
     begin
		waddr_next = waddr + 1'b1;
		$display("Testing for Register %d, Addr: %h\n", (k-1), waddr);
	for(int i=0; i<64; i++)
	begin
			write_en = 1'b1; // Write to register
			wdata    = $random();
		@(posedge clock);
		@(negedge clock);
			write_en = 1'b0; // withdraw write enable
			read_en  = 2'b01; // Read from raddr 0  
			raddr_0	 = waddr; // read back
		#2
		if(tb.RF_32.rdata_0 != wdata)
			$error("Read through Port 0 not successful\n Expected Value of rdata_0 is %h, Actual Value is %h\n", wdata, tb.RF_32.rdata_0);
		@(negedge clock);
			read_en  = 2'b10; // Read from raddr 0 and 1 both  
			raddr_1	 = waddr; // read back
		#2
		if(tb.RF_32.rdata_1 != wdata)
			$error("Read through Port 1 not successful\n Expected Value of rdata_1 is %h, Actual Value is %h\n", wdata, tb.RF_32.rdata_1);

		@(negedge clock);
			read_en  = 2'b11; // Read from raddr 0 and 1 both  
			raddr_0	 = waddr; // read back
			raddr_1	 = waddr; // read back
		#2
		if((tb.RF_32.rdata_0 != wdata) || (tb.RF_32.rdata_1 != wdata))
			$error("Read through Port 0 and 1 not successful\n Expected Value of rdata_0 is %h, Actual Value is %h\n  Expected Value of rdata_1 is %h, Actual Value is %h\n", wdata, tb.RF_32.rdata_0,  wdata, tb.RF_32.rdata_1);
	end
	for(int i=0; i<64; i++)
	begin
			write_en = 1'b1; // Write to register
			wdata    = $random();
		@(posedge clock);
		@(negedge clock);
			write_en = 1'b0; // withdraw write enable
			read_en  = 2'b01; // Read from raddr 0  
			raddr_0	 = waddr; // read back
		#2
		if(tb.RF_32.rdata_0 != wdata)
			$error("Read through Port 0 not successful\n Expected Value of rdata_0 is %h, Actual Value is %h\n", wdata, tb.RF_32.rdata_0);
		@(negedge clock);
			read_en  = 2'b10; // Read from raddr 0 and 1 both  
			raddr_1	 = waddr; // read back
		#2
		if(tb.RF_32.rdata_1 != wdata)
			$error("Read through Port 1 not successful\n Expected Value of rdata_1 is %h, Actual Value is %h\n", wdata, tb.RF_32.rdata_1);
		@(negedge clock);
			read_en  = 2'b11; // Read from raddr 2 
			raddr_0	 = waddr; // read back
			raddr_1	 = waddr; // read back
		#2
		if((tb.RF_32.rdata_0 != wdata) || (tb.RF_32.rdata_1 != wdata))
			$error("Read through Port 0 and 1 not successful\n Expected Value of rdata_0 is %h, Actual Value is %h\n  Expected Value of rdata_1 is %h, Actual Value is %h\n", wdata, tb.RF_32.rdata_0,  wdata, tb.RF_32.rdata_1);
	end
		waddr = waddr_next;
     end // register loop end
#10
$finish;

end

endmodule
