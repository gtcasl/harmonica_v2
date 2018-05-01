module tb();


reg 	clk;
reg	rst_n;
reg 	is_branch;
reg	[71:0] data_in_1;
reg	[71:0] data_in_2;
reg	[71:0] saved_data_in_1;
reg	[71:0] saved_data_in_2;
reg	[71:0] saved_data_in_3;
reg	[71:0] saved_data_in_4;
reg	[71:0] saved_data_in_5;
reg	[71:0] saved_data_in_6;
reg	[71:0] saved_data_in_7;
reg	[71:0] saved_data_in_8;

reg	[31:0]	  new_reconv_PC;
reg	[31:0]	  fetch_PC;
wire	stack_full;
wire	stack_empty;
wire	sm_busy;
wire 	[71:0] data_out;
wire	data_vld;


// stimulus

// registers to hold active random data
reg [7:0] rand_active_mask_1, rand_active_mask_2;
reg [31:0] rand_reconv_PC, rand_reconv_PC_1, rand_reconv_PC_2, rand_reconv_PC_3, rand_reconv_PC_4, rand_next_PC_1, rand_next_PC_2;


initial 
begin
	clk <= 1'b0;
	rst_n <= 1'b0;
	is_branch <= 1'b0;
	data_in_1 <= 72'h0;
	data_in_2 <= 72'h0;
	new_reconv_PC <= 32'h3000;
	fetch_PC <= 32'h4000;
	#6
	rst_n <= 1'h1;
	#1 
	if(CDS.stack_empty)
		$display(" Reset Check : Stack is empty after reset");
	else
		$error(" Stack is not empty on reset");

	$display("-------------------------------------Sequence 1-----------------------------------------");
	for(int k=0; k<10; k++)
	begin
		$display(" Data Arriving : Stack will be filled !");
		@(posedge clk)
		rand_active_mask_1 <= $random();
		rand_reconv_PC     <= $random();
		rand_next_PC_1	   <= $random();
		rand_active_mask_2 <= $random();
		rand_next_PC_2	   <= $random();
		@(posedge clk)
		is_branch <= 1'b1;
		data_in_1 <= {rand_active_mask_1, rand_reconv_PC, rand_next_PC_1};
		data_in_2 <= {rand_active_mask_2, rand_reconv_PC, rand_next_PC_2};
		new_reconv_PC <= rand_reconv_PC;	
		fetch_PC <= $random;
		@(posedge clk);
		is_branch <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		fetch_PC <= rand_reconv_PC;	
		@(posedge clk);
		#1
		if((CDS.data_vld) && (CDS.data_out== data_in_2))
			$display(" Popped Data same as expected data ");
		else
			$error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, data_in_2, CDS.data_out);
		@(posedge clk);	// to read out TOS
		fetch_PC <= rand_reconv_PC;	
		@(posedge clk);
		#1
		if((CDS.data_vld) && (CDS.data_out== data_in_1))
			$display(" Popped Data same as expected data ");
		else
			$error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, data_in_1, CDS.data_out);
		@(posedge clk);
		fetch_PC <= 32'h8001;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
	end
        $display("-------------------------------------Sequence 2-----------------------------------------");
        for(int k=0; k<10; k++)
        begin
                $display(" Data Arriving : Stack will be filled !");
                @(posedge clk)
                rand_active_mask_1 <= $random();
                rand_reconv_PC_1   <= $random();
                rand_next_PC_1     <= $random();
                rand_active_mask_2 <= $random();
                rand_next_PC_2     <= $random();
                @(posedge clk)
                is_branch <= 1'b1;
                data_in_1 <= {rand_active_mask_1, rand_reconv_PC_1, rand_next_PC_1};
                data_in_2 <= {rand_active_mask_2, rand_reconv_PC_1, rand_next_PC_2};
                saved_data_in_1 <= {rand_active_mask_1, rand_reconv_PC_1, rand_next_PC_1};
                saved_data_in_2 <= {rand_active_mask_2, rand_reconv_PC_1, rand_next_PC_2};
                new_reconv_PC <= rand_reconv_PC_1;
                fetch_PC <= $random;
                @(posedge clk);
                is_branch <= 1'b0;
                @(posedge clk);
                @(posedge clk);
                $display(" New branch Data Arriving : Stack will be filled !");
                @(posedge clk)
                rand_active_mask_1 <= $random();
                rand_reconv_PC_2   <= $random();
                rand_next_PC_1     <= $random();
                rand_active_mask_2 <= $random();
                rand_next_PC_2     <= $random();
                @(posedge clk)
                is_branch <= 1'b1;
                data_in_1 <= {rand_active_mask_1, rand_reconv_PC_2, rand_next_PC_1};
                data_in_2 <= {rand_active_mask_2, rand_reconv_PC_2, rand_next_PC_2};
                saved_data_in_3 <= {rand_active_mask_1, rand_reconv_PC_2, rand_next_PC_1};
                saved_data_in_4 <= {rand_active_mask_2, rand_reconv_PC_2, rand_next_PC_2};
                saved_data_in_2 <= {saved_data_in_2[71:32], rand_reconv_PC_2};
                new_reconv_PC <= rand_reconv_PC_2;
                fetch_PC <= $random;
                @(posedge clk);
                is_branch <= 1'b0;
                @(posedge clk);
                @(posedge clk);
                fetch_PC <= rand_reconv_PC_2;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_4))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_4, CDS.data_out);
                @(posedge clk); // to read out TOS
                fetch_PC <= rand_reconv_PC_2;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_3))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_3, CDS.data_out);
                @(posedge clk);
                fetch_PC <= 32'h8001;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                fetch_PC <= rand_reconv_PC_1;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_2))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_2, CDS.data_out);
                @(posedge clk); // to read out TOS
                fetch_PC <= rand_reconv_PC_1;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_1))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_1, CDS.data_out);
                @(posedge clk);
                fetch_PC <= 32'h8001;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
        end

        $display("-------------------------------------Sequence 3-----------------------------------------");
        for(int k=0; k<10; k++)
        begin
                $display(" Data Arriving : Stack will be filled !");
                @(posedge clk)
                rand_active_mask_1 <= $random();
                rand_reconv_PC_1   <= $random();
                rand_next_PC_1     <= $random();
                rand_active_mask_2 <= $random();
                rand_next_PC_2     <= $random();
                @(posedge clk)
                is_branch <= 1'b1;
                data_in_1 <= {rand_active_mask_1, rand_reconv_PC_1, rand_next_PC_1};		// Write to Stack Loc 0
                data_in_2 <= {rand_active_mask_2, rand_reconv_PC_1, rand_next_PC_2};		// Write to Stack Loc 1
                saved_data_in_1 <= {rand_active_mask_1, rand_reconv_PC_1, rand_next_PC_1};
                saved_data_in_2 <= {rand_active_mask_2, rand_reconv_PC_1, rand_next_PC_2};
                new_reconv_PC <= rand_reconv_PC_1;
                fetch_PC <= $random;
                @(posedge clk);
                is_branch <= 1'b0;
                @(posedge clk);
                @(posedge clk);

                $display(" New branch Data Arriving : Stack will be filled !");
                @(posedge clk)
                rand_active_mask_1 <= $random();
                rand_reconv_PC_2   <= $random();
                rand_next_PC_1     <= $random();
                rand_active_mask_2 <= $random();
                rand_next_PC_2     <= $random();
                @(posedge clk)
                is_branch <= 1'b1;
                data_in_1 <= {rand_active_mask_1, rand_reconv_PC_2, rand_next_PC_1};		// Write to Stack Loc 2
                data_in_2 <= {rand_active_mask_2, rand_reconv_PC_2, rand_next_PC_2};		// Write to Stack Loc 3
                saved_data_in_3 <= {rand_active_mask_1, rand_reconv_PC_2, rand_next_PC_1};
                saved_data_in_4 <= {rand_active_mask_2, rand_reconv_PC_2, rand_next_PC_2};
                saved_data_in_2 <= {saved_data_in_2[71:32], rand_reconv_PC_2};
                new_reconv_PC <= rand_reconv_PC_2;
                fetch_PC <= $random;
                @(posedge clk);
                is_branch <= 1'b0;
                @(posedge clk);
                @(posedge clk);

                $display(" New branch Data Arriving : Stack will be filled !");
                @(posedge clk)
                rand_active_mask_1 <= $random();
                rand_reconv_PC_3   <= $random();
                rand_next_PC_1     <= $random();
                rand_active_mask_2 <= $random();
                rand_next_PC_2     <= $random();
                @(posedge clk)
                is_branch <= 1'b1;
                data_in_1 <= {rand_active_mask_1, rand_reconv_PC_3, rand_next_PC_1};		// Write to Stack Loc 4
                data_in_2 <= {rand_active_mask_2, rand_reconv_PC_3, rand_next_PC_2};		// Write to Stack Loc 5
                saved_data_in_5 <= {rand_active_mask_1, rand_reconv_PC_3, rand_next_PC_1};
                saved_data_in_6 <= {rand_active_mask_2, rand_reconv_PC_3, rand_next_PC_2};
                saved_data_in_4 <= {saved_data_in_4[71:32], rand_reconv_PC_3};
                new_reconv_PC <= rand_reconv_PC_3;
                fetch_PC <= $random;
                @(posedge clk);
                is_branch <= 1'b0;
                @(posedge clk);
                @(posedge clk);

                $display(" New branch Data Arriving : Stack will be filled !");
                @(posedge clk)
                rand_active_mask_1 <= $random();
                rand_reconv_PC_4   <= $random();
                rand_next_PC_1     <= $random();
                rand_active_mask_2 <= $random();
                rand_next_PC_2     <= $random();
                @(posedge clk)
                is_branch <= 1'b1;
                data_in_1 <= {rand_active_mask_1, rand_reconv_PC_4, rand_next_PC_1};		// Write to Stack Loc 6
                data_in_2 <= {rand_active_mask_2, rand_reconv_PC_4, rand_next_PC_2};		// Write to Stack Loc 7
                saved_data_in_7 <= {rand_active_mask_1, rand_reconv_PC_4, rand_next_PC_1};
                saved_data_in_8 <= {rand_active_mask_2, rand_reconv_PC_4, rand_next_PC_2};
                saved_data_in_6 <= {saved_data_in_6[71:32], rand_reconv_PC_4};
                new_reconv_PC <= rand_reconv_PC_4;
                fetch_PC <= $random;
                @(posedge clk);
                is_branch <= 1'b0;
                @(posedge clk);
                @(posedge clk);


                fetch_PC <= rand_reconv_PC_4;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_8))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_8, CDS.data_out);
                @(posedge clk); // to read out TOS
                fetch_PC <= $random;
                @(posedge clk);
                @(posedge clk);
                fetch_PC <= rand_reconv_PC_4;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_7))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_7, CDS.data_out);
                @(posedge clk);
                fetch_PC <= 32'h8001;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);

                fetch_PC <= rand_reconv_PC_3;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_6))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_6, CDS.data_out);
                @(posedge clk); // to read out TOS
                fetch_PC <= $random;
                @(posedge clk);
                @(posedge clk);
                fetch_PC <= rand_reconv_PC_3;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_5))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_5, CDS.data_out);
                @(posedge clk);
                fetch_PC <= 32'h8001;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);

                fetch_PC <= rand_reconv_PC_2;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_4))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_4, CDS.data_out);
                @(posedge clk); // to read out TOS
                fetch_PC <= $random;
                @(posedge clk);
                @(posedge clk);
                fetch_PC <= rand_reconv_PC_2;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_3))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_3, CDS.data_out);
                @(posedge clk);
                fetch_PC <= 32'h8001;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);



                fetch_PC <= rand_reconv_PC_1;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_2))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_2, CDS.data_out);
                @(posedge clk); // to read out TOS
                fetch_PC <= $random;
                @(posedge clk);
                @(posedge clk);
                fetch_PC <= rand_reconv_PC_1;
                @(posedge clk);
                #1
                if((CDS.data_vld) && (CDS.data_out== saved_data_in_1))
                        $display(" Popped Data same as expected data ");
                else
                        $error(" Popped data is not same as expected data: Vld %h, Expected Data %h, Actual Data %h", CDS.data_vld, saved_data_in_1, CDS.data_out);
                @(posedge clk);
                fetch_PC <= 32'h8001;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
        end



	$finish();
end

always
#5 clk <= !clk;


control_divergence_stack #(.STACK_DEPTH(8), .LOG2_STACK_DEPTH(3), .STACK_WIDTH(72), .PC_WIDTH(32))
			CDS		(
					clk, 
					rst_n,
					is_branch, 
					data_in_1, 
					data_in_2,
					new_reconv_PC, 
					fetch_PC,
					stack_full, 
					stack_empty, 
					sm_busy,
					data_out, 
					data_vld
					);



endmodule
