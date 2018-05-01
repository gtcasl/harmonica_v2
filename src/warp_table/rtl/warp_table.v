// Owner: Poulami Das
// Module: Warp_table
// This block contains the FIFO mechanism that holds unscheduled warps
// and schedules them one by one
//
//
//

// WT_WIDTH 
// 1  bit for valid
// 1  bit for ready
// 3  bits for LOG2_NUM_WARPS (when 8 warps)
// 32 bits for PC/ address space 
// 8  bits for mask (number of lanes)



module warp_table	#(parameter WT_WIDTH=45, FIFO_DEPTH=128, LOG2_FIFO_DEPTH=7)
			(
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


// FIXME: fifo signals exposed or no?
input	clk;
input	rst_n;
input	read_en;
input	write_en;
input 	[WT_WIDTH-2:0] write_data;
output 	[WT_WIDTH-2:0] read_data;
output	read_valid;
output 	fifo_empty;
output 	fifo_vacant;
output 	fifo_full;

reg	read_valid;
reg	[WT_WIDTH-2:0] read_data;

// Internals
reg [LOG2_FIFO_DEPTH-1:0] head_ptr;
reg [LOG2_FIFO_DEPTH-1:0] tail_ptr;
reg [LOG2_FIFO_DEPTH-1:0] head_ptr_next;
reg [LOG2_FIFO_DEPTH-1:0] tail_ptr_next;

// Actual FIFO has 1 extra bit for the Valid bit
reg [WT_WIDTH-1:0] FIFO[0:FIFO_DEPTH-1];


//	for simplicity and lesser LOC just invalidate the entire table on
//	reset 
//	FPGA synthesis may not allow multiple processes driving the same
//	signal
//	genvar i;
//	generate 
//	for(i=0; i<FIFO_DEPTH; i=i+1) begin: fifo
//		always @(posedge clk)	begin
//			if(~rst_n) 
//				begin	
//					FIFO[i][WT_WIDTH-1] <= 1'h0; 
//				end
//		end
//	end
//	endgenerate

// rest of the FIFO logic comes in here
//


always @(posedge clk)
begin
	if(rst_n) // when not in reset condition
	begin
		if(write_en & fifo_empty)		// Write functionality
		begin
			if(!read_en)
				begin
				FIFO[head_ptr] <= {1'b1, write_data};
				head_ptr <= head_ptr_next;
				end
			else if(tail_ptr!=head_ptr)	
				begin
				FIFO[head_ptr] <= {1'b1, write_data};
				head_ptr <= head_ptr_next;
				end
		end
		if(read_en) // on a read
		begin
			if(write_en && (tail_ptr == head_ptr))
				begin
				{read_valid, read_data} <= {1'b1, write_data}; // forward the incoming read
			// Bypass happening: No need to incr TP	tail_ptr <= tail_ptr_next;
				end
			else if (!fifo_vacant) // Not reading from an empty FIFO
				begin
					{read_valid, read_data} <= FIFO[tail_ptr];
					FIFO[tail_ptr][WT_WIDTH-1]	<= 1'b0; // invalidate this entry
					tail_ptr <= tail_ptr_next;
				end
			else 
				read_valid <= 1'b0;
		end
	end
	else		// when under reset
	begin
		`ifndef FIFO_DEPTH_IS_256
		head_ptr <= 7'h0;
		tail_ptr <= 7'h0;
		// reset values
		FIFO[0][WT_WIDTH-1] <= 1'h0; 
		FIFO[1][WT_WIDTH-1] <= 1'h0; 
		FIFO[2][WT_WIDTH-1] <= 1'h0; 
		FIFO[3][WT_WIDTH-1] <= 1'h0; 
		FIFO[4][WT_WIDTH-1] <= 1'h0; 
		FIFO[5][WT_WIDTH-1] <= 1'h0; 
		FIFO[6][WT_WIDTH-1] <= 1'h0; 
		FIFO[7][WT_WIDTH-1] <= 1'h0; 
		FIFO[8][WT_WIDTH-1] <= 1'h0; 
		FIFO[9][WT_WIDTH-1] <= 1'h0; 
		FIFO[10][WT_WIDTH-1] <= 1'h0; 
		FIFO[11][WT_WIDTH-1] <= 1'h0; 
		FIFO[12][WT_WIDTH-1] <= 1'h0; 
		FIFO[13][WT_WIDTH-1] <= 1'h0; 
		FIFO[14][WT_WIDTH-1] <= 1'h0; 
		FIFO[15][WT_WIDTH-1] <= 1'h0; 
		FIFO[16][WT_WIDTH-1] <= 1'h0; 
		FIFO[17][WT_WIDTH-1] <= 1'h0; 
		FIFO[18][WT_WIDTH-1] <= 1'h0; 
		FIFO[19][WT_WIDTH-1] <= 1'h0; 
		FIFO[20][WT_WIDTH-1] <= 1'h0; 
		FIFO[21][WT_WIDTH-1] <= 1'h0; 
		FIFO[22][WT_WIDTH-1] <= 1'h0; 
		FIFO[23][WT_WIDTH-1] <= 1'h0; 
		FIFO[24][WT_WIDTH-1] <= 1'h0; 
		FIFO[25][WT_WIDTH-1] <= 1'h0; 
		FIFO[26][WT_WIDTH-1] <= 1'h0; 
		FIFO[27][WT_WIDTH-1] <= 1'h0; 
		FIFO[28][WT_WIDTH-1] <= 1'h0; 
		FIFO[29][WT_WIDTH-1] <= 1'h0; 
		FIFO[30][WT_WIDTH-1] <= 1'h0; 
		FIFO[31][WT_WIDTH-1] <= 1'h0; 
		FIFO[32][WT_WIDTH-1] <= 1'h0; 
		FIFO[33][WT_WIDTH-1] <= 1'h0; 
		FIFO[34][WT_WIDTH-1] <= 1'h0; 
		FIFO[35][WT_WIDTH-1] <= 1'h0; 
		FIFO[36][WT_WIDTH-1] <= 1'h0; 
		FIFO[37][WT_WIDTH-1] <= 1'h0; 
		FIFO[38][WT_WIDTH-1] <= 1'h0; 
		FIFO[39][WT_WIDTH-1] <= 1'h0; 
		FIFO[40][WT_WIDTH-1] <= 1'h0; 
		FIFO[41][WT_WIDTH-1] <= 1'h0; 
		FIFO[42][WT_WIDTH-1] <= 1'h0; 
		FIFO[43][WT_WIDTH-1] <= 1'h0; 
		FIFO[44][WT_WIDTH-1] <= 1'h0; 
		FIFO[45][WT_WIDTH-1] <= 1'h0; 
		FIFO[46][WT_WIDTH-1] <= 1'h0; 
		FIFO[47][WT_WIDTH-1] <= 1'h0; 
		FIFO[48][WT_WIDTH-1] <= 1'h0; 
		FIFO[49][WT_WIDTH-1] <= 1'h0; 
		FIFO[50][WT_WIDTH-1] <= 1'h0; 
		FIFO[51][WT_WIDTH-1] <= 1'h0; 
		FIFO[52][WT_WIDTH-1] <= 1'h0; 
		FIFO[53][WT_WIDTH-1] <= 1'h0; 
		FIFO[54][WT_WIDTH-1] <= 1'h0; 
		FIFO[55][WT_WIDTH-1] <= 1'h0; 
		FIFO[56][WT_WIDTH-1] <= 1'h0; 
		FIFO[57][WT_WIDTH-1] <= 1'h0; 
		FIFO[58][WT_WIDTH-1] <= 1'h0; 
		FIFO[59][WT_WIDTH-1] <= 1'h0; 
		FIFO[60][WT_WIDTH-1] <= 1'h0; 
		FIFO[61][WT_WIDTH-1] <= 1'h0; 
		FIFO[62][WT_WIDTH-1] <= 1'h0; 
		FIFO[63][WT_WIDTH-1] <= 1'h0; 
		FIFO[64][WT_WIDTH-1] <= 1'h0; 
		FIFO[65][WT_WIDTH-1] <= 1'h0; 
		FIFO[66][WT_WIDTH-1] <= 1'h0; 
		FIFO[67][WT_WIDTH-1] <= 1'h0; 
		FIFO[68][WT_WIDTH-1] <= 1'h0; 
		FIFO[69][WT_WIDTH-1] <= 1'h0; 
		FIFO[70][WT_WIDTH-1] <= 1'h0; 
		FIFO[71][WT_WIDTH-1] <= 1'h0; 
		FIFO[72][WT_WIDTH-1] <= 1'h0; 
		FIFO[73][WT_WIDTH-1] <= 1'h0; 
		FIFO[74][WT_WIDTH-1] <= 1'h0; 
		FIFO[75][WT_WIDTH-1] <= 1'h0; 
		FIFO[76][WT_WIDTH-1] <= 1'h0; 
		FIFO[77][WT_WIDTH-1] <= 1'h0; 
		FIFO[78][WT_WIDTH-1] <= 1'h0; 
		FIFO[79][WT_WIDTH-1] <= 1'h0; 
		FIFO[80][WT_WIDTH-1] <= 1'h0; 
		FIFO[81][WT_WIDTH-1] <= 1'h0; 
		FIFO[82][WT_WIDTH-1] <= 1'h0; 
		FIFO[83][WT_WIDTH-1] <= 1'h0; 
		FIFO[84][WT_WIDTH-1] <= 1'h0; 
		FIFO[85][WT_WIDTH-1] <= 1'h0; 
		FIFO[86][WT_WIDTH-1] <= 1'h0; 
		FIFO[87][WT_WIDTH-1] <= 1'h0; 
		FIFO[88][WT_WIDTH-1] <= 1'h0; 
		FIFO[89][WT_WIDTH-1] <= 1'h0; 
		FIFO[90][WT_WIDTH-1] <= 1'h0; 
		FIFO[91][WT_WIDTH-1] <= 1'h0; 
		FIFO[92][WT_WIDTH-1] <= 1'h0; 
		FIFO[93][WT_WIDTH-1] <= 1'h0; 
		FIFO[94][WT_WIDTH-1] <= 1'h0; 
		FIFO[95][WT_WIDTH-1] <= 1'h0; 
		FIFO[96][WT_WIDTH-1] <= 1'h0; 
		FIFO[97][WT_WIDTH-1] <= 1'h0; 
		FIFO[98][WT_WIDTH-1] <= 1'h0; 
		FIFO[99][WT_WIDTH-1] <= 1'h0; 
		FIFO[100][WT_WIDTH-1] <= 1'h0; 
		FIFO[101][WT_WIDTH-1] <= 1'h0; 
		FIFO[102][WT_WIDTH-1] <= 1'h0; 
		FIFO[103][WT_WIDTH-1] <= 1'h0; 
		FIFO[104][WT_WIDTH-1] <= 1'h0; 
		FIFO[105][WT_WIDTH-1] <= 1'h0; 
		FIFO[106][WT_WIDTH-1] <= 1'h0; 
		FIFO[107][WT_WIDTH-1] <= 1'h0; 
		FIFO[108][WT_WIDTH-1] <= 1'h0; 
		FIFO[109][WT_WIDTH-1] <= 1'h0; 
		FIFO[110][WT_WIDTH-1] <= 1'h0; 
		FIFO[111][WT_WIDTH-1] <= 1'h0; 
		FIFO[112][WT_WIDTH-1] <= 1'h0; 
		FIFO[113][WT_WIDTH-1] <= 1'h0; 
		FIFO[114][WT_WIDTH-1] <= 1'h0; 
		FIFO[115][WT_WIDTH-1] <= 1'h0; 
		FIFO[116][WT_WIDTH-1] <= 1'h0; 
		FIFO[117][WT_WIDTH-1] <= 1'h0; 
		FIFO[118][WT_WIDTH-1] <= 1'h0; 
		FIFO[119][WT_WIDTH-1] <= 1'h0; 
		FIFO[120][WT_WIDTH-1] <= 1'h0; 
		FIFO[121][WT_WIDTH-1] <= 1'h0; 
		FIFO[122][WT_WIDTH-1] <= 1'h0; 
		FIFO[123][WT_WIDTH-1] <= 1'h0; 
		FIFO[124][WT_WIDTH-1] <= 1'h0; 
		FIFO[125][WT_WIDTH-1] <= 1'h0; 
		FIFO[126][WT_WIDTH-1] <= 1'h0; 
		FIFO[127][WT_WIDTH-1] <= 1'h0; 
		`else 
		head_ptr <= 8'h0;
		tail_ptr <= 8'h0;
		FIFO[0][WT_WIDTH-1] <= 1'h0; 
		FIFO[1][WT_WIDTH-1] <= 1'h0; 
		FIFO[2][WT_WIDTH-1] <= 1'h0; 
		FIFO[3][WT_WIDTH-1] <= 1'h0; 
		FIFO[4][WT_WIDTH-1] <= 1'h0; 
		FIFO[5][WT_WIDTH-1] <= 1'h0; 
		FIFO[6][WT_WIDTH-1] <= 1'h0; 
		FIFO[7][WT_WIDTH-1] <= 1'h0; 
		FIFO[8][WT_WIDTH-1] <= 1'h0; 
		FIFO[9][WT_WIDTH-1] <= 1'h0; 
		FIFO[10][WT_WIDTH-1] <= 1'h0; 
		FIFO[11][WT_WIDTH-1] <= 1'h0; 
		FIFO[12][WT_WIDTH-1] <= 1'h0; 
		FIFO[13][WT_WIDTH-1] <= 1'h0; 
		FIFO[14][WT_WIDTH-1] <= 1'h0; 
		FIFO[15][WT_WIDTH-1] <= 1'h0; 
		FIFO[16][WT_WIDTH-1] <= 1'h0; 
		FIFO[17][WT_WIDTH-1] <= 1'h0; 
		FIFO[18][WT_WIDTH-1] <= 1'h0; 
		FIFO[19][WT_WIDTH-1] <= 1'h0; 
		FIFO[20][WT_WIDTH-1] <= 1'h0; 
		FIFO[21][WT_WIDTH-1] <= 1'h0; 
		FIFO[22][WT_WIDTH-1] <= 1'h0; 
		FIFO[23][WT_WIDTH-1] <= 1'h0; 
		FIFO[24][WT_WIDTH-1] <= 1'h0; 
		FIFO[25][WT_WIDTH-1] <= 1'h0; 
		FIFO[26][WT_WIDTH-1] <= 1'h0; 
		FIFO[27][WT_WIDTH-1] <= 1'h0; 
		FIFO[28][WT_WIDTH-1] <= 1'h0; 
		FIFO[29][WT_WIDTH-1] <= 1'h0; 
		FIFO[30][WT_WIDTH-1] <= 1'h0; 
		FIFO[31][WT_WIDTH-1] <= 1'h0; 
		FIFO[32][WT_WIDTH-1] <= 1'h0; 
		FIFO[33][WT_WIDTH-1] <= 1'h0; 
		FIFO[34][WT_WIDTH-1] <= 1'h0; 
		FIFO[35][WT_WIDTH-1] <= 1'h0; 
		FIFO[36][WT_WIDTH-1] <= 1'h0; 
		FIFO[37][WT_WIDTH-1] <= 1'h0; 
		FIFO[38][WT_WIDTH-1] <= 1'h0; 
		FIFO[39][WT_WIDTH-1] <= 1'h0; 
		FIFO[40][WT_WIDTH-1] <= 1'h0; 
		FIFO[41][WT_WIDTH-1] <= 1'h0; 
		FIFO[42][WT_WIDTH-1] <= 1'h0; 
		FIFO[43][WT_WIDTH-1] <= 1'h0; 
		FIFO[44][WT_WIDTH-1] <= 1'h0; 
		FIFO[45][WT_WIDTH-1] <= 1'h0; 
		FIFO[46][WT_WIDTH-1] <= 1'h0; 
		FIFO[47][WT_WIDTH-1] <= 1'h0; 
		FIFO[48][WT_WIDTH-1] <= 1'h0; 
		FIFO[49][WT_WIDTH-1] <= 1'h0; 
		FIFO[50][WT_WIDTH-1] <= 1'h0; 
		FIFO[51][WT_WIDTH-1] <= 1'h0; 
		FIFO[52][WT_WIDTH-1] <= 1'h0; 
		FIFO[53][WT_WIDTH-1] <= 1'h0; 
		FIFO[54][WT_WIDTH-1] <= 1'h0; 
		FIFO[55][WT_WIDTH-1] <= 1'h0; 
		FIFO[56][WT_WIDTH-1] <= 1'h0; 
		FIFO[57][WT_WIDTH-1] <= 1'h0; 
		FIFO[58][WT_WIDTH-1] <= 1'h0; 
		FIFO[59][WT_WIDTH-1] <= 1'h0; 
		FIFO[60][WT_WIDTH-1] <= 1'h0; 
		FIFO[61][WT_WIDTH-1] <= 1'h0; 
		FIFO[62][WT_WIDTH-1] <= 1'h0; 
		FIFO[63][WT_WIDTH-1] <= 1'h0; 
		FIFO[64][WT_WIDTH-1] <= 1'h0; 
		FIFO[65][WT_WIDTH-1] <= 1'h0; 
		FIFO[66][WT_WIDTH-1] <= 1'h0; 
		FIFO[67][WT_WIDTH-1] <= 1'h0; 
		FIFO[68][WT_WIDTH-1] <= 1'h0; 
		FIFO[69][WT_WIDTH-1] <= 1'h0; 
		FIFO[70][WT_WIDTH-1] <= 1'h0; 
		FIFO[71][WT_WIDTH-1] <= 1'h0; 
		FIFO[72][WT_WIDTH-1] <= 1'h0; 
		FIFO[73][WT_WIDTH-1] <= 1'h0; 
		FIFO[74][WT_WIDTH-1] <= 1'h0; 
		FIFO[75][WT_WIDTH-1] <= 1'h0; 
		FIFO[76][WT_WIDTH-1] <= 1'h0; 
		FIFO[77][WT_WIDTH-1] <= 1'h0; 
		FIFO[78][WT_WIDTH-1] <= 1'h0; 
		FIFO[79][WT_WIDTH-1] <= 1'h0; 
		FIFO[80][WT_WIDTH-1] <= 1'h0; 
		FIFO[81][WT_WIDTH-1] <= 1'h0; 
		FIFO[82][WT_WIDTH-1] <= 1'h0; 
		FIFO[83][WT_WIDTH-1] <= 1'h0; 
		FIFO[84][WT_WIDTH-1] <= 1'h0; 
		FIFO[85][WT_WIDTH-1] <= 1'h0; 
		FIFO[86][WT_WIDTH-1] <= 1'h0; 
		FIFO[87][WT_WIDTH-1] <= 1'h0; 
		FIFO[88][WT_WIDTH-1] <= 1'h0; 
		FIFO[89][WT_WIDTH-1] <= 1'h0; 
		FIFO[90][WT_WIDTH-1] <= 1'h0; 
		FIFO[91][WT_WIDTH-1] <= 1'h0; 
		FIFO[92][WT_WIDTH-1] <= 1'h0; 
		FIFO[93][WT_WIDTH-1] <= 1'h0; 
		FIFO[94][WT_WIDTH-1] <= 1'h0; 
		FIFO[95][WT_WIDTH-1] <= 1'h0; 
		FIFO[96][WT_WIDTH-1] <= 1'h0; 
		FIFO[97][WT_WIDTH-1] <= 1'h0; 
		FIFO[98][WT_WIDTH-1] <= 1'h0; 
		FIFO[99][WT_WIDTH-1] <= 1'h0; 
		FIFO[100][WT_WIDTH-1] <= 1'h0; 
		FIFO[101][WT_WIDTH-1] <= 1'h0; 
		FIFO[102][WT_WIDTH-1] <= 1'h0; 
		FIFO[103][WT_WIDTH-1] <= 1'h0; 
		FIFO[104][WT_WIDTH-1] <= 1'h0; 
		FIFO[105][WT_WIDTH-1] <= 1'h0; 
		FIFO[106][WT_WIDTH-1] <= 1'h0; 
		FIFO[107][WT_WIDTH-1] <= 1'h0; 
		FIFO[108][WT_WIDTH-1] <= 1'h0; 
		FIFO[109][WT_WIDTH-1] <= 1'h0; 
		FIFO[110][WT_WIDTH-1] <= 1'h0; 
		FIFO[111][WT_WIDTH-1] <= 1'h0; 
		FIFO[112][WT_WIDTH-1] <= 1'h0; 
		FIFO[113][WT_WIDTH-1] <= 1'h0; 
		FIFO[114][WT_WIDTH-1] <= 1'h0; 
		FIFO[115][WT_WIDTH-1] <= 1'h0; 
		FIFO[116][WT_WIDTH-1] <= 1'h0; 
		FIFO[117][WT_WIDTH-1] <= 1'h0; 
		FIFO[118][WT_WIDTH-1] <= 1'h0; 
		FIFO[119][WT_WIDTH-1] <= 1'h0; 
		FIFO[120][WT_WIDTH-1] <= 1'h0; 
		FIFO[121][WT_WIDTH-1] <= 1'h0; 
		FIFO[122][WT_WIDTH-1] <= 1'h0; 
		FIFO[123][WT_WIDTH-1] <= 1'h0; 
		FIFO[124][WT_WIDTH-1] <= 1'h0; 
		FIFO[125][WT_WIDTH-1] <= 1'h0; 
		FIFO[126][WT_WIDTH-1] <= 1'h0; 
		FIFO[127][WT_WIDTH-1] <= 1'h0; 
		FIFO[128][WT_WIDTH-1] <= 1'h0; 
		FIFO[129][WT_WIDTH-1] <= 1'h0; 
		FIFO[130][WT_WIDTH-1] <= 1'h0; 
		FIFO[131][WT_WIDTH-1] <= 1'h0; 
		FIFO[132][WT_WIDTH-1] <= 1'h0; 
		FIFO[133][WT_WIDTH-1] <= 1'h0; 
		FIFO[134][WT_WIDTH-1] <= 1'h0; 
		FIFO[135][WT_WIDTH-1] <= 1'h0; 
		FIFO[136][WT_WIDTH-1] <= 1'h0; 
		FIFO[137][WT_WIDTH-1] <= 1'h0; 
		FIFO[138][WT_WIDTH-1] <= 1'h0; 
		FIFO[139][WT_WIDTH-1] <= 1'h0; 
		FIFO[140][WT_WIDTH-1] <= 1'h0; 
		FIFO[141][WT_WIDTH-1] <= 1'h0; 
		FIFO[142][WT_WIDTH-1] <= 1'h0; 
		FIFO[143][WT_WIDTH-1] <= 1'h0; 
		FIFO[144][WT_WIDTH-1] <= 1'h0; 
		FIFO[145][WT_WIDTH-1] <= 1'h0; 
		FIFO[146][WT_WIDTH-1] <= 1'h0; 
		FIFO[147][WT_WIDTH-1] <= 1'h0; 
		FIFO[148][WT_WIDTH-1] <= 1'h0; 
		FIFO[149][WT_WIDTH-1] <= 1'h0; 
		FIFO[150][WT_WIDTH-1] <= 1'h0; 
		FIFO[151][WT_WIDTH-1] <= 1'h0; 
		FIFO[152][WT_WIDTH-1] <= 1'h0; 
		FIFO[153][WT_WIDTH-1] <= 1'h0; 
		FIFO[154][WT_WIDTH-1] <= 1'h0; 
		FIFO[155][WT_WIDTH-1] <= 1'h0; 
		FIFO[156][WT_WIDTH-1] <= 1'h0; 
		FIFO[157][WT_WIDTH-1] <= 1'h0; 
		FIFO[158][WT_WIDTH-1] <= 1'h0; 
		FIFO[159][WT_WIDTH-1] <= 1'h0; 
		FIFO[160][WT_WIDTH-1] <= 1'h0; 
		FIFO[161][WT_WIDTH-1] <= 1'h0; 
		FIFO[162][WT_WIDTH-1] <= 1'h0; 
		FIFO[163][WT_WIDTH-1] <= 1'h0; 
		FIFO[164][WT_WIDTH-1] <= 1'h0; 
		FIFO[165][WT_WIDTH-1] <= 1'h0; 
		FIFO[166][WT_WIDTH-1] <= 1'h0; 
		FIFO[167][WT_WIDTH-1] <= 1'h0; 
		FIFO[168][WT_WIDTH-1] <= 1'h0; 
		FIFO[169][WT_WIDTH-1] <= 1'h0; 
		FIFO[170][WT_WIDTH-1] <= 1'h0; 
		FIFO[171][WT_WIDTH-1] <= 1'h0; 
		FIFO[172][WT_WIDTH-1] <= 1'h0; 
		FIFO[173][WT_WIDTH-1] <= 1'h0; 
		FIFO[174][WT_WIDTH-1] <= 1'h0; 
		FIFO[175][WT_WIDTH-1] <= 1'h0; 
		FIFO[176][WT_WIDTH-1] <= 1'h0; 
		FIFO[177][WT_WIDTH-1] <= 1'h0; 
		FIFO[178][WT_WIDTH-1] <= 1'h0; 
		FIFO[179][WT_WIDTH-1] <= 1'h0; 
		FIFO[180][WT_WIDTH-1] <= 1'h0; 
		FIFO[181][WT_WIDTH-1] <= 1'h0; 
		FIFO[182][WT_WIDTH-1] <= 1'h0; 
		FIFO[183][WT_WIDTH-1] <= 1'h0; 
		FIFO[184][WT_WIDTH-1] <= 1'h0; 
		FIFO[185][WT_WIDTH-1] <= 1'h0; 
		FIFO[186][WT_WIDTH-1] <= 1'h0; 
		FIFO[187][WT_WIDTH-1] <= 1'h0; 
		FIFO[188][WT_WIDTH-1] <= 1'h0; 
		FIFO[189][WT_WIDTH-1] <= 1'h0; 
		FIFO[190][WT_WIDTH-1] <= 1'h0; 
		FIFO[191][WT_WIDTH-1] <= 1'h0; 
		FIFO[192][WT_WIDTH-1] <= 1'h0; 
		FIFO[193][WT_WIDTH-1] <= 1'h0; 
		FIFO[194][WT_WIDTH-1] <= 1'h0; 
		FIFO[195][WT_WIDTH-1] <= 1'h0; 
		FIFO[196][WT_WIDTH-1] <= 1'h0; 
		FIFO[197][WT_WIDTH-1] <= 1'h0; 
		FIFO[198][WT_WIDTH-1] <= 1'h0; 
		FIFO[199][WT_WIDTH-1] <= 1'h0; 
		FIFO[200][WT_WIDTH-1] <= 1'h0; 
		FIFO[201][WT_WIDTH-1] <= 1'h0; 
		FIFO[202][WT_WIDTH-1] <= 1'h0; 
		FIFO[203][WT_WIDTH-1] <= 1'h0; 
		FIFO[204][WT_WIDTH-1] <= 1'h0; 
		FIFO[205][WT_WIDTH-1] <= 1'h0; 
		FIFO[206][WT_WIDTH-1] <= 1'h0; 
		FIFO[207][WT_WIDTH-1] <= 1'h0; 
		FIFO[208][WT_WIDTH-1] <= 1'h0; 
		FIFO[209][WT_WIDTH-1] <= 1'h0; 
		FIFO[210][WT_WIDTH-1] <= 1'h0; 
		FIFO[211][WT_WIDTH-1] <= 1'h0; 
		FIFO[212][WT_WIDTH-1] <= 1'h0; 
		FIFO[213][WT_WIDTH-1] <= 1'h0; 
		FIFO[214][WT_WIDTH-1] <= 1'h0; 
		FIFO[215][WT_WIDTH-1] <= 1'h0; 
		FIFO[216][WT_WIDTH-1] <= 1'h0; 
		FIFO[217][WT_WIDTH-1] <= 1'h0; 
		FIFO[218][WT_WIDTH-1] <= 1'h0; 
		FIFO[219][WT_WIDTH-1] <= 1'h0; 
		FIFO[220][WT_WIDTH-1] <= 1'h0; 
		FIFO[221][WT_WIDTH-1] <= 1'h0; 
		FIFO[222][WT_WIDTH-1] <= 1'h0; 
		FIFO[223][WT_WIDTH-1] <= 1'h0; 
		FIFO[224][WT_WIDTH-1] <= 1'h0; 
		FIFO[225][WT_WIDTH-1] <= 1'h0; 
		FIFO[226][WT_WIDTH-1] <= 1'h0; 
		FIFO[227][WT_WIDTH-1] <= 1'h0; 
		FIFO[228][WT_WIDTH-1] <= 1'h0; 
		FIFO[229][WT_WIDTH-1] <= 1'h0; 
		FIFO[230][WT_WIDTH-1] <= 1'h0; 
		FIFO[231][WT_WIDTH-1] <= 1'h0; 
		FIFO[232][WT_WIDTH-1] <= 1'h0; 
		FIFO[233][WT_WIDTH-1] <= 1'h0; 
		FIFO[234][WT_WIDTH-1] <= 1'h0; 
		FIFO[235][WT_WIDTH-1] <= 1'h0; 
		FIFO[236][WT_WIDTH-1] <= 1'h0; 
		FIFO[237][WT_WIDTH-1] <= 1'h0; 
		FIFO[238][WT_WIDTH-1] <= 1'h0; 
		FIFO[239][WT_WIDTH-1] <= 1'h0; 
		FIFO[240][WT_WIDTH-1] <= 1'h0; 
		FIFO[241][WT_WIDTH-1] <= 1'h0; 
		FIFO[242][WT_WIDTH-1] <= 1'h0; 
		FIFO[243][WT_WIDTH-1] <= 1'h0; 
		FIFO[244][WT_WIDTH-1] <= 1'h0; 
		FIFO[245][WT_WIDTH-1] <= 1'h0; 
		FIFO[246][WT_WIDTH-1] <= 1'h0; 
		FIFO[247][WT_WIDTH-1] <= 1'h0; 
		FIFO[248][WT_WIDTH-1] <= 1'h0; 
		FIFO[249][WT_WIDTH-1] <= 1'h0; 
		FIFO[250][WT_WIDTH-1] <= 1'h0; 
		FIFO[251][WT_WIDTH-1] <= 1'h0; 
		FIFO[252][WT_WIDTH-1] <= 1'h0; 
		FIFO[253][WT_WIDTH-1] <= 1'h0; 
		FIFO[254][WT_WIDTH-1] <= 1'h0; 
		FIFO[255][WT_WIDTH-1] <= 1'h0; 
		`endif
	end
end

always@(tail_ptr)
	tail_ptr_next <= tail_ptr+1'b1;
always@(head_ptr)
	head_ptr_next <= head_ptr+1'b1;
assign fifo_full = ((head_ptr == tail_ptr) && FIFO[tail_ptr][WT_WIDTH-1]) ? 1'b1: 1'b0;
assign fifo_empty = !fifo_full;
assign fifo_vacant = ((head_ptr == tail_ptr) & (!FIFO[tail_ptr][WT_WIDTH-1])) ? 1'b1: 1'b0;

endmodule
