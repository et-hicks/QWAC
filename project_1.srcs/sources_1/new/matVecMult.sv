//`timescale 1ns / 1ps
`include "../../constants.vh"

module matVecMult
    #(parameter TILE_ENG = 2,
                VEC_LEN = 4, 
                MAT_R = 4, 
                IN_BITS = 4, 
                OUT_BITS = 4, 
                MAT_C = VEC_LEN,
                NUM_VECS = TILE_ENG)
    (
    input clock, reset,
	input  signed [IN_BITS-1:0]  in_vecs     [TILE_ENG-1:0][VEC_LEN-1:0],
	input  signed [OUT_BITS-1:0] mat         [MAT_R-1:0][MAT_C-1:0],
	output signed [OUT_BITS-1:0] out_vecs    [TILE_ENG-1:0][MAT_R-1:0]
    );
    
    genvar te;
    generate
        for (te = 0; te < TILE_ENG; te = te + 1) begin: final_creation_of_stuff_for_tileEng
            tileEng #(VEC_LEN, MAT_R, IN_BITS, OUT_BITS)
            TE (.clock(clock), .reset(reset), .in_vec(in_vecs[te]), .mat(mat), .out_vec(out_vecs[te]));
        end
    endgenerate
endmodule
