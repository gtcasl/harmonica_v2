module tb();

// Required connectivity variables
reg clk;
reg rst_n;
reg [7:0] read_en_0;
reg [7:0] read_en_1;
reg [7:0] write_en;
reg [4:0] raddr_0;
reg [4:0] raddr_1;
reg [4:0] waddr;
reg [4:0] waddr_next;
reg [63:0] wdata_0;
reg [63:0] wdata_1;
reg [63:0] wdata_2;
reg [63:0] wdata_3;
reg [63:0] wdata_4;
reg [63:0] wdata_5;
reg [63:0] wdata_6;
reg [63:0] wdata_7;

wire [63:0] rdata_0_0;
wire [63:0] rdata_1_0;
wire [63:0] rdata_0_1;
wire [63:0] rdata_1_1;
wire [63:0] rdata_0_2;
wire [63:0] rdata_1_2;
wire [63:0] rdata_0_3;
wire [63:0] rdata_1_3;
wire [63:0] rdata_0_4;
wire [63:0] rdata_1_4;
wire [63:0] rdata_0_5;
wire [63:0] rdata_1_5;
wire [63:0] rdata_0_6;
wire [63:0] rdata_1_6;
wire [63:0] rdata_0_7;
wire [63:0] rdata_1_7;

// Instantiate the Register Bank 

register_bank	RBANK	(
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
			.rdata_1_7	(rdata_1_7)
			);
`include "register_bank_cfg.v"


// Stimulus

// Clock and reset

initial 
begin
  clk <= 1'b0;
  rst_n <= 1'b0;
end			

always 
 #5 clk <= !clk;

// Controlling reads and writes

initial 
begin
	raddr_0 	= 5'h0;
	raddr_1 	= 5'h0;
	waddr   	= 5'h0;
	waddr_next   	= 5'h0;
	write_en	= 8'h0;
	read_en_0	= 8'h0;
	read_en_1	= 8'h0;
	wdata_0		= 64'h0;
	wdata_1		= 64'h0;
	wdata_2		= 64'h0;
	wdata_3		= 64'h0;
	wdata_4		= 64'h0;
	wdata_5		= 64'h0;
	wdata_6		= 64'h0;
	wdata_7		= 64'h0;
end

initial 
begin
@(posedge clk);		// Reset happens here
@(negedge clk);		// Apply inputs here
rst_n <= 1'b1; 
     for(int k =1; k<=32; k++) // Loop for every register
     begin
		waddr_next = waddr + 1'b1;
		$display("Testing for Register %d, Addr: %h\n", (k-1), waddr);
		for(int i=0; i<100; i++)   // 100 writes per register
		begin
			write_en   = 8'hFF;  // Write to registers of all 8 lanes 
			wdata_0    = $random(); 
			wdata_1    = $random(); 
			wdata_2    = $random(); 
			wdata_3    = $random(); 
			wdata_4    = $random(); 
			wdata_5    = $random(); 
			wdata_6    = $random(); 
			wdata_7    = $random(); 
			@(posedge clk);	// Write happens
			@(negedge clk);	// Hold Control signals
			write_en   = 8'h00; 	// Withdraw write
			read_en_0  = 8'hFF;    // Read from port 0 for all lanes
			raddr_0	   = waddr;
		// Read through Port 0
			#2
			check_port_0_all_lanes(wdata_0, wdata_1, wdata_2, wdata_3, wdata_4, wdata_5, wdata_6, wdata_7);
			@(negedge clk);	// Hold Control signals
			write_en   = 8'h00; 	// Withdraw write
			read_en_0  = 8'h00;    // Withdraw read from port 0 for all lanes
			read_en_1  = 8'hFF;    // Read from port 1 for all lanes
			raddr_1	   = waddr;
		// Read through Port 1
			#2
			check_port_1_all_lanes(wdata_0, wdata_1, wdata_2, wdata_3, wdata_4, wdata_5, wdata_6, wdata_7);
		// Read through Port 0 and 1 both 
			@(negedge clk);	// Hold Control signals
			write_en   = 8'h00; 	// Withdraw write
			read_en_0  = 8'hFF;    // Withdraw read from port 0 for all lanes
			read_en_1  = 8'hFF;    // Read from port 1 for all lanes
			raddr_0	   = waddr;
			raddr_1	   = waddr;
			#2
		// Port 0 checks 
			check_port_0_all_lanes(wdata_0, wdata_1, wdata_2, wdata_3, wdata_4, wdata_5, wdata_6, wdata_7);
		// Port 1 checks 
			check_port_1_all_lanes(wdata_0, wdata_1, wdata_2, wdata_3, wdata_4, wdata_5, wdata_6, wdata_7);
		end // Number of writes
			waddr = waddr_next; // go to next register
	end // Number of registers
#100

$finish();
end // initial begin

			



endmodule
