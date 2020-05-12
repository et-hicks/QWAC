/*
time shortage means that there is a lot to be wanted to be done here.

Instead of a complex chip, this will just be a mostly unfunctioing matVec multiplyer 
*/


//help?

// final add for the most part
`include "constants.vh"
`include "matVecMult.sv"

module QWAC(
    input clock, reset,
    input [3:0] SW,
    output [7:0] LEDS
    );
    
    // Parameters for QWAC are found in the constants.vh file
    // This is, Im aware, very bad practice. 
    reg signed [`BITS-1:0]     in_mat [`MAT_R-1:0][`MAT_C-1:0];
	reg signed [`BITS-1:0]     in_v   [`TE-1:0][`VEC_LEN-1:0];
	reg signed [`BITS-1:0]     out_vecs  [`TE-1:0][`MAT_R-1:0];
	reg        [`CNT_BITS-1:0] counter;
	reg                        done;
	
	reg signed [`BITS-1:0]     in_matrix [`MAT_R-1:0][`MAT_C-1:0];
	reg signed [`BITS-1:0]     in_matrix2 [`MAT_R-1:0][`MAT_C-1:0];
	reg signed [`BITS-1:0]     in_vecs   [`TE-1:0][`VEC_LEN-1:0];
    reg signed [`BITS-1:0]     in_vecs2   [`TE-1:0][`VEC_LEN-1:0];
    
    counter cnt (.clock(clock), .done(done), .reset(reset), .count(counter));
    
    matVecMult mVM (.clock(clock), .reset(reset), .in_vecs(in_v), .mat(in_mat), .out_vecs(out_vecs));
    
    // There is, no doubt, a better way to do this. 
    // But since I never got around to programming the UART, the FIFO, and the c code to send the data
    // This is the best I could come up with.
    // I am still able to count clock cycles and am still able to get an idea how fast this is, up to 
    initial begin
                {in_matrix[0][0], in_matrix[0][1], in_matrix[0][2], in_matrix[0][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_matrix[1][0], in_matrix[1][1], in_matrix[1][2], in_matrix[1][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_matrix[2][0], in_matrix[2][1], in_matrix[2][2], in_matrix[2][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_matrix[3][0], in_matrix[3][1], in_matrix[3][2], in_matrix[3][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_matrix[4][0], in_matrix[4][1], in_matrix[4][2], in_matrix[4][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_matrix[5][0], in_matrix[5][1], in_matrix[5][2], in_matrix[5][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_matrix[6][0], in_matrix[6][1], in_matrix[6][2], in_matrix[6][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_matrix[7][0], in_matrix[7][1], in_matrix[7][2], in_matrix[7][3]} <= {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_vecs[0][0], in_vecs[0][1], in_vecs[0][2], in_vecs[0][3]} <=  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_vecs[1][0], in_vecs[1][1], in_vecs[1][2], in_vecs[1][3]} <=  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        
		        {in_vecs2[0][0], in_vecs2[0][1], in_vecs2[0][2], in_vecs2[0][3]} <=  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		        {in_vecs2[1][0], in_vecs2[1][1], in_vecs2[1][2], in_vecs2[1][3]} <=  {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		        
		        {in_matrix2[0][0], in_matrix2[0][1], in_matrix2[0][2], in_matrix2[0][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
                {in_matrix2[1][0], in_matrix2[1][1], in_matrix2[1][2], in_matrix2[1][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
                {in_matrix2[2][0], in_matrix2[2][1], in_matrix2[2][2], in_matrix2[2][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
                {in_matrix2[3][0], in_matrix2[3][1], in_matrix2[3][2], in_matrix2[3][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1}; 
                {in_matrix2[4][0], in_matrix2[4][1], in_matrix2[4][2], in_matrix2[4][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
                {in_matrix2[5][0], in_matrix2[5][1], in_matrix2[5][2], in_matrix2[5][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
                {in_matrix2[6][0], in_matrix2[6][1], in_matrix2[6][2], in_matrix2[6][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
                {in_matrix2[7][0], in_matrix2[7][1], in_matrix2[7][2], in_matrix2[7][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		
    end
    
    always @(posedge clock or negedge reset) begin
        if (reset) begin 
            counter <= 0;
            done <= 0;
        end 
        
        case (SW)
            4'b0000: begin
                        in_mat <= in_matrix;
                        in_v <= in_vecs;
                        done <= 1'b0;
                     end
            4'b0001: begin
                        in_mat <= in_matrix2;
                        in_v <= in_vecs;
                        done <= 1'b0;
                     end
            4'b0010: begin
                        in_mat <= in_matrix;
                        in_v <= in_vecs2;
                        done <= 1'b0;
                     end
            4'b0011: begin
                        in_mat <= in_matrix2;
                        in_v <= in_vecs2;
                        done <= 1'b0;
                     end
        endcase     
    
        
    end
    
    always @(out_vecs[0][0]) begin
        done = 1'b1;
    end
    
    assign LEDS = {done, counter[9:0]};   
    
endmodule

