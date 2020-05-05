`timescale 10ns / 1ns


module tileEng
	#(parameter VEC_LEN = 4, MAT_R = 4, IN_BITS = 8, OUT_BITS = 32, MAT_C = VEC_LEN)

	 (input clock, rst,
	  input  signed [IN_BITS-1:0]  in_vec[VEC_LEN-1:0],
	  input  signed [OUT_BITS-1:0] mat[MAT_R-1:0][MAT_C-1:0],
	  output signed [OUT_BITS-1:0] out_vec[VEC_LEN-1:0]
	 );
	 // Do I need a -1 on MAT_R?
	 wire signed [OUT_BITS-1:0] dotProds [VEC_LEN-1:0];
	 wire signed [OUT_BITS-1:0] matVec [VEC_LEN-1:0];


	 genvar row;
	 genvar col;
	 generate
	 	for (row = 0; row < MAT_R; row = row + 1) begin
			for (col = 0; col < MAT_C; col = col + 1) begin
				assign matVec[col] = mat[row][col];
			end
			dotProdEng #(IN_BITS, OUT_BITS, VEC_LEN)
			dotting
			(.clock(clock), .reset(rst), .vec(in_vec), .mat_vec(matVec), .dotted(dotProds[row]));
		end
	endgenerate

	assign out_vec = dotProds; // small changes and the like
endmodule