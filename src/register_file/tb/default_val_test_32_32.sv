module tb();

reg clock;
reg reset_n;
// Instantiate the register file

// Configuration with 32 Registers 
register_file	      RF_32  (
			.clk(clock),
			.reset_n(reset_n),
			.read_en(2'h0),
			.write_en(1'b0),
			.raddr_0(5'h0),
			.raddr_1(5'h0),
			.waddr(5'h0),
			.wdata(32'h0),
			.rdata_0(),
			.rdata_1()
			);

`include "register_cfg.v"

initial 
begin
	clock =1'b0;
	reset_n = 1'b0;
end

always 
  #5 clock = !clock;


initial 
begin
#100
	$display("========================Testing the default value of all registers: Num of Registers is 32 ======================\n");
	for(int i = 0;i<=31; i++)
	begin
		if(tb.RF_32.RF[i]==32'h0)
			$display("Default value of Register %d is correct", i);		
		else
			$error("Default value of Register %d is incorrect", i);	
	end
	$display("========================Testing the default value of all registers Done: Test Passed ======================\n");

$finish;

end

endmodule
