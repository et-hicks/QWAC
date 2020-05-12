`include "../../constants.vh"

/*
this is mostly for the purpose of a fully functioning chip
at the moment, this is not really used because of a shortage of time
*/
module on_chip_mem
    #(parameter NUM_OF_MATS = 1,
                NUM_OF_VECS = 1,
                NUM_OF_OUTS = 1,
                VEC_LEN = 4,
                MAT_R = 8,
                TE = 1,
                IN_BITS = 8,
                OUT_BITS = 32,
                OUT_MEM_ADDRESS_BITS = $clog2(NUM_OF_OUTS * MAT_R * OUT_BITS),
                IN_MEM_ADDRESS_BITS = $clog2(NUM_OF_VECS * VEC_LEN * IN_BITS),
                MAT_MEM_ADDRESS_BITS = $clog2(NUM_OF_MATS * VEC_LEN * MAT_R * OUT_BITS))
    (
    // One bit inputs
    input  clock, reset, read, write,
    
    // multi bit inputs
    input  signed [IN_BITS-1:0] in_vector_sent_in   [TE-1:0][VEC_LEN-1:0],
    input  signed [OUT_BITS-1:0] mat_sent_in        [VEC_LEN-1:0][MAT_R-1:0],
    input  signed [OUT_BITS-1:0] out_vec_sent_in   [TE-1:0][MAT_R-1:0],
    
    // multi-bit outputs
    output signed [IN_BITS-1:0]  in_vector_sent_out [TE-1:0][VEC_LEN-1:0],
    output signed [OUT_BITS-1:0] out_mat_sent_out   [VEC_LEN-1:0][MAT_R-1:0],
    output signed [OUT_BITS-1:0] out_vec_sent_out  [TE-1:0][VEC_LEN-1:0],
    
    // Memory address inputs
    input        [IN_MEM_ADDRESS_BITS-1:0]  in_vec_location_in,
    input        [OUT_MEM_ADDRESS_BITS-1:0] out_vec_location_in,
    input        [MAT_MEM_ADDRESS_BITS-1:0] mat_location_in
    );
    
    reg signed [IN_BITS-1:0]  in_vector_storage  [NUM_OF_VECS-1:0][TE-1:0][VEC_LEN-1:0];
    reg signed [OUT_BITS-1:0] out_vector_storage [NUM_OF_OUTS-1:0][TE-1:0][MAT_R-1:0];
    reg signed [OUT_BITS-1:0] mat_storage        [NUM_OF_MATS-1:0][MAT_R-1:0][VEC_LEN-1:0];

// Doesnt work
    reg signed [IN_BITS-1:0]  temp_in_vec   [TE-1:0][VEC_LEN-1:0];
    reg signed [OUT_BITS-1:0] temp_out_vec  [TE-1:0][VEC_LEN-1:0];
    reg signed [OUT_BITS-1:0] temp_out_mat  [MAT_R-1:0][VEC_LEN-1:0];
    
    always @(posedge clock) begin 

        case({read, write})
            2'b01: begin
                    in_vector_storage[in_vec_location_in]   <= in_vector_sent_in;
                    out_vector_storage[out_vec_location_in] <= out_vec_sent_in;
                    mat_storage[mat_location_in]            <= mat_sent_in;
                   end                
            2'b10: begin
                    temp_in_vec  <= in_vector_storage[in_vec_location_in];
                    temp_out_vec <= out_vector_storage[out_vec_location_in];
                    temp_out_mat <= mat_storage[mat_location_in];
                   end
            2'b11: begin
                    // In both a read/write, we have to read first
                    temp_in_vec  <= in_vector_storage[in_vec_location_in];
                    temp_out_vec <= out_vector_storage[out_vec_location_in];
                    temp_out_mat <= mat_storage[mat_location_in];     
                    
                    // And then write to the file
                    in_vector_storage[in_vec_location_in]   <= in_vector_sent_in;
                    out_vector_storage[out_vec_location_in] <= out_vec_sent_in;
                    mat_storage[mat_location_in]            <= mat_sent_in;               
                   end
        endcase
    end
    
    assign in_vector_sent_out = temp_in_vec;
    assign out_vec_sent_out = temp_out_vec;
    assign out_mat_sent_out= temp_out_mat;
endmodule
