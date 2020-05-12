// Give this a vector in data, and it will add all the componants up combinationally
// code taken from https://stackoverflow.com/questions/21263968/reduce-array-to-sum-of-elements

`include "constants.vh"
module vecAdd
        #(parameter IN_BITS = `BITS, OUT_BITS = `BITS, VEC_LEN = `VEC_LEN)
        (
        input clock, reset, relu,
        input signed  [IN_BITS-1:0]  in_vec  [VEC_LEN-1:0],
        output signed [OUT_BITS-1:0] out_sum
    );
    
  genvar i;
  // Untested with signed wire
  wire signed [OUT_BITS-1:0] temp_summation_array [VEC_LEN-2 : 0]; //container for all sumation steps
  wire [OUT_BITS-1:0] re_lu;
  generate
    assign temp_summation_array[0] = in_vec[0] + in_vec[1];
    for(i=0; i<VEC_LEN-2; i=i+1) begin : adding_throughout
      assign temp_summation_array[i+1] = temp_summation_array[i] + in_vec[i+2];
    end
  endgenerate
  // Untested with relu
  // TODO: test relu
  assign re_lu = (relu) ? ((temp_summation_array[VEC_LEN-2] > 0) ? temp_summation_array[VEC_LEN-2] : 0) 
                        : temp_summation_array[VEC_LEN-2];
  assign out_sum = (reset) ? 0 :
                                (relu) ? re_lu : temp_summation_array[VEC_LEN-2];
endmodule
