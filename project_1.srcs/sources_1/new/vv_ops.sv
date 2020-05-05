// Made to wrap a bunch of vector-vector operations together. 
// TODO: test this a lil

`include "../../constants.vh"

module vv_ops
    #(parameter IN_BITS = `BITS, OUT_BITS = `BITS, VEC_LEN = `VEC_LEN)
    (input clock, reset,
     input         [1:0]          control,
     input  signed [IN_BITS-1:0]  vec_a   [VEC_LEN-1:0],
     input  signed [IN_BITS-1:0]  vec_b   [VEC_LEN-1:0],
     output signed [OUT_BITS:0]   out_vec [VEC_LEN-1:0]
     );
     
     wire signed [OUT_BITS-1:0] vv_mulled  [VEC_LEN-1:0];
     wire signed [OUT_BITS-1:0] vv_added   [VEC_LEN-1:0];
     wire signed [OUT_BITS-1:0] a_subbed_b [VEC_LEN-1:0];
     wire signed [OUT_BITS-1:0] b_subbed_a [VEC_LEN-1:0];
     
     reg signed  [OUT_BITS-1:0] vv_holder  [VEC_LEN-1:0];
     
     genvar i;
     generate 
        for (i = 0; i < VEC_LEN; i = i + 1) begin
            assign vv_mulled[i]  = vec_a[i] * vec_b[i];
            assign vv_added[i]   = vec_a[i] + vec_b[i];
            assign a_subbed_b[i] = vec_a[i] - vec_b[i];
            assign b_subbed_a[i] = vec_b[i] - vec_a[i];
        end
     endgenerate
     
     // Well, this now has a timing thing I think. I will have to see how everything comes together
     // Also, this is untested
     always @(control) begin
         case (control)
            2'b00   : begin 
                            vv_holder = vv_mulled; 
                      end
            2'b01   : begin 
                            vv_holder = vv_mulled; 
                      end
            2'b10   : begin 
                            vv_holder = vv_mulled; 
                      end
            2'b11   : begin 
                            vv_holder = vv_mulled; 
                      end
            default   : begin 
                            vv_holder = vec_a;
                      end
         endcase
     end
     assign out_vec = vv_holder;
endmodule
