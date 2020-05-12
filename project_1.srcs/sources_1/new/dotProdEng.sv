// Give this two vectors and it will multiply them together and add the vector up aka a dot product

// From what I can tell, dot product does indeed work
// YAYYYY
`include "../../constants.vh"

module dotProdEng
	#(parameter IN_BITS = `BITS, OUT_BITS = `BITS, VEC_LEN = `VEC_LEN, MAT_C = VEC_LEN)

	 (input clock, reset,
	  input  signed [IN_BITS-1:0]  vec     [VEC_LEN-1:0],
	  input  signed [OUT_BITS-1:0] mat_vec [MAT_C-1:0],
	  output signed [OUT_BITS-1:0] dotted
	 );


	 reg signed [OUT_BITS-1:0] mulled [VEC_LEN-1:0];
	 reg signed [OUT_BITS-1:0] summed;

	// Pipeline #1: multiplying everything then storing it into a vector register
		genvar row;
		generate
  			for (row = 0; row < VEC_LEN; row = row + 1) begin : making_more_stuff
  			// Super, Super mayber kinda sorta consider taking this out
  			// I want to avoid a datarace at all costs
          always @(posedge clock) begin
  				    mulled[row] <= vec[row] * mat_vec[row];
			    end
        end
		endgenerate

  // The following is from https://stackoverflow.com/questions/21263968/reduce-array-to-sum-of-elements
  // A stack overflow post that talks about verilog summation through the array
  genvar i;
  // Untested with signed wire. Prolly a cause for concern
  wire signed [OUT_BITS-1:0] temp_summation_array [VEC_LEN-2 : 0]; //container for all sumation steps
  generate
    assign temp_summation_array[0] = mulled[0] + mulled[1];
    for(i=0; i<VEC_LEN-2; i=i+1) begin : making_even_more_stuff_part_NEXT
      assign temp_summation_array[i+1] = temp_summation_array[i] + mulled[i+2];
    end
  endgenerate
  assign dotted = (reset) ? 0 : temp_summation_array[VEC_LEN-2];
endmodule