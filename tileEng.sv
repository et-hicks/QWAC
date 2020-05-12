// Give this a matrix and vector and it will multiply them together, returning the resutling vector. 
// Final vector length is, according to LinAlg, as long as the columns of the input matrix

`include "constants.vh"
`include "dotProdEng.sv"
// It appears that this is working, I think
module tileEng
	#(parameter VEC_LEN = 4, MAT_R = 4, IN_BITS = 4, OUT_BITS = 4, MAT_C = VEC_LEN)

	 (input clock, reset,
	  input  signed [IN_BITS-1:0]  in_vec[VEC_LEN-1:0],
	  input  signed [OUT_BITS-1:0] mat[MAT_R-1:0][MAT_C-1:0],
	  output signed [OUT_BITS-1:0] out_vec[MAT_R-1:0]
	 );
	 // Do I need a -1 on MAT_R?
	 wire signed [OUT_BITS-1:0] dotProds [MAT_R-1:0];
	 wire signed [OUT_BITS-1:0] matVec [VEC_LEN-1:0];


	 genvar row;
	 generate
	 	for (row = 0; row < MAT_R; row = row + 1) begin : making_the_dots
			dotProdEng #(IN_BITS, OUT_BITS, VEC_LEN) dotting (.clock(clock), .reset(reset), .vec(in_vec), .mat_vec(mat[row]), .dotted(dotProds[row]));
		end
	endgenerate

	assign out_vec = dotProds; // small changes and the like
endmodule