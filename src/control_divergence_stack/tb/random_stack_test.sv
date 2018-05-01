module tb();

reg clk;
reg rst_n;
reg [71:0] data_in;
reg push;
reg pop;
reg push_back;
reg read_tos;

reg [72:0] saved_data_1;
reg [72:0] saved_data_2;
reg [72:0] saved_data_3;
reg [72:0] saved_data_4;


wire [71:0]   data_out;
wire	      data_vld;
wire	      stack_full;	      
wire	      stack_empty;	      

initial 
begin
	$display("===================== Reset Check ==========================");	
	clk <= 1'h0;
	rst_n <= 1'b0;
	data_in <= 72'h0;
	push  <= 1'h0;
	pop   <= 1'h0;
	push_back <= 1'h0;
	read_tos <= 1'b0;
	@(posedge clk);
	#1; // Wait before reading
	$display("-------------------- Reset happens here ----------------");
	if(STACK.stack_empty)
		$display("-------------------- Stack is empty on reset ----------------");
	else
		$display("Stack is not empty on reset !!!");
	rst_n <= 1'b1;	// Reset removal
	$display("===================== Push followed by Pop test ==========================");	
	@(posedge clk);
	for(int k=1; k<=10; k++)
	begin
	// Push new data
	push <= 1'b1;
	pop  <= 1'b0;
	data_in <= $random();
	@(posedge clk);	// Push happens here 
		$display("-------------------- Pushed Data to stack %h ----------------", data_in);
	push <= 1'b0;
	pop  <= 1'b1;
	@(posedge clk);	// Pop happens here 
	#1 // Wait before reading
	if(STACK.data_out == data_in && STACK.data_vld)
		$display("-------------------- Popped Valid Data from stack %h ----------------", data_in);
	else
		$error("-------------------- Popped Inalid Data from stack: Vld signal: %h, Actual Data: %h, Expected Data: %h ----------------", STACK.data_vld, STACK.data_out, data_in);
	end
	pop <= 1'b0;
	// Multiple push and pops, pushback too
	for(int k=1; k<=10; k++)
	begin
		push_back <= 1'b0;
		@(posedge clk)		// Nothing happens on this clock
		// Push new data
		push <= 1'b1;
		pop  <= 1'b0;
		data_in <= $random();
//		saved_data_1 <= data_in; 
		@(posedge clk)		// First push happens
		// Push new data
		push <= 1'b1;
		pop  <= 1'b0;
		data_in <= $random();
		saved_data_1 <= data_in; 
		@(posedge clk)		// Second push happens
		// Push new data
		push <= 1'b1;
		pop  <= 1'b0;
		data_in <= $random();
		saved_data_2 <= data_in; 
		@(posedge clk)		// Third push happens
		// Push new data
		push_back <= 1'b1;
		push <= 1'b0;
		pop  <= 1'b0;
		data_in <= $random();
		saved_data_3 <= data_in; 
		@(posedge clk)		// push_back happens
		push_back <= 1'b0;
		push <= 1'b0;
		pop  <= 1'b1;
		@(posedge clk);	        // Pop 1 happens here 
		saved_data_4 <= data_in; 
		#1 // Wait before reading
		if(STACK.data_out == saved_data_3 && STACK.data_vld)
			$display("-------------------- Popped Valid Data from stack %h ----------------", data_in);
		else
			$error("-------------------- Popped Invalid Data from stack: Vld signal: %h, Actual Data: %h, Expected Data: %h ----------------", STACK.data_vld, STACK.data_out, saved_data_3);
		@(posedge clk);	        // Pop 2 happens here 
		#1 // Wait before reading
		if(STACK.data_out == saved_data_2 && STACK.data_vld)
			$display("-------------------- Popped Valid Data from stack %h ----------------", data_in);
		else
			$error("-------------------- Popped Invalid Data from stack: Vld signal: %h, Actual Data: %h, Expected Data: %h ----------------", STACK.data_vld, STACK.data_out, saved_data_2);
		@(posedge clk);	        // Pop 3 happens here 
		#1 // Wait before reading
		if(STACK.data_out == saved_data_4 && STACK.data_vld)
			$display("-------------------- Popped Valid Data from stack %h ----------------", data_in);
		else
			$error("-------------------- Popped Invalid Data from stack: Vld signal: %h, Actual Data: %h, Expected Data: %h ----------------", STACK.data_vld, STACK.data_out, saved_data_4);
		
		pop <= 1'b0;
	end
		// Write new test sequence
	$display("-------------------- Push and Pop both together test ----------------");
	pop <= 1'h0;
	push <= 1'h0;
	push_back <= 1'b0;
	@(posedge clk);	        // Nothing happens here
	
	push <= 1'h1;
	data_in <= $random();
	@(posedge clk);	        // Push happens here
	push <= 1'h1;
	pop  <= 1'h1;
	saved_data_1 <= data_in;
	data_in <= $random();
	@(posedge clk);	        // Push and Pop both happens here
	#1 // Wait before reading
	if(STACK.data_vld && STACK.data_out == saved_data_1)
			$display("-------------------- Popped Valid Data from stack %h ----------------", data_in);
		else
			$error("-------------------- Popped Invalid Data from stack: Vld signal: %h, Actual Data: %h, Expected Data: %h ----------------", STACK.data_vld, STACK.data_out, saved_data_1);
	

		
#50
$finish();
end

always
 #5 clk <= !clk;


// Instantiate the stack

stack STACK 
		(
		clk, 
		rst_n, 
		data_in, 
		push,
		pop, 
		push_back, 
		read_tos,
		data_vld,
		data_out,
		stack_full, 
		stack_empty
		);



endmodule

