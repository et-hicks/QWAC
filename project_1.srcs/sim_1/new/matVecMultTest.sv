`timescale 10ps / 1ps // huh?
`include "../../constants.vh"
// Working with a simple 4x4 byte array
module matVecMultTest();


	reg signed [`BITS-1:0]     in_matrix [`MAT_R-1:0][`MAT_C-1:0];
	reg signed [`BITS-1:0]     in_vecs   [`TE-1:0][`VEC_LEN-1:0];
	reg signed [`BITS-1:0]     out_vecs  [`TE-1:0][`MAT_R-1:0];
	reg        [`CNT_BITS-1:0] cnt;
	reg clock, reset;

	matVecMult #(`TE, `VEC_LEN, `MAT_R, `BITS, `BITS)
	dut (.clock(clock), .reset(reset), .in_vecs(in_vecs), .mat(in_matrix), .out_vecs(out_vecs));
	
	counter cnt_dut (.clock(clock), .reset(reset), .count(cnt));


	initial begin
		$dumpfile("dump.vcd"); //Setup file dump (for waveform viewer)
		$dumpvars; //Dump signals to dumpfile

		{in_matrix[0][0], in_matrix[0][1], in_matrix[0][2], in_matrix[0][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[1][0], in_matrix[1][1], in_matrix[1][2], in_matrix[1][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[2][0], in_matrix[2][1], in_matrix[2][2], in_matrix[2][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[3][0], in_matrix[3][1], in_matrix[3][2], in_matrix[3][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		
		{in_matrix[4][0], in_matrix[4][1], in_matrix[4][2], in_matrix[4][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[5][0], in_matrix[5][1], in_matrix[5][2], in_matrix[5][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[6][0], in_matrix[6][1], in_matrix[6][2], in_matrix[6][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[7][0], in_matrix[7][1], in_matrix[7][2], in_matrix[7][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_vecs[0][0], in_vecs[0][1], in_vecs[0][2], in_vecs[0][3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_vecs[1][0], in_vecs[1][1], in_vecs[1][2], in_vecs[1][3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		#1;

		$display("\t\t\tThe input matrix is as follows\n");
		$display("in_matrix[0] = %d%d%d%d\n",in_matrix[0][0], in_matrix[0][1], in_matrix[0][2], in_matrix[0][3]);
		$display("in_matrix[1] = %d%d%d%d\n",in_matrix[1][0], in_matrix[1][1], in_matrix[1][2], in_matrix[1][3]);
		$display("in_matrix[2] = %d%d%d%d\n",in_matrix[2][0], in_matrix[2][1], in_matrix[2][2], in_matrix[2][3]);
		$display("in_matrix[3] = %d%d%d%d\n",in_matrix[3][0], in_matrix[3][1], in_matrix[3][2], in_matrix[3][3]);

		$display("\n\n\t\tThe input vector is as follows\n");
		$display("in_vec = %d%d%d%d\n",in_vecs[0][0], in_vecs[0][1], in_vecs[0][2], in_vecs[0][3]); #1
		// $finish;
		$display("\n\n\nJust seeing what works and what doesn't\n\n\n");
		clock = 1; reset = 1;
		#1; // clock and reset take effect
		reset = 0;
		// THERE IS A BETTER WAY
		clock = ~clock; #1; // turn off
		{in_vecs[0][0], in_vecs[0][1], in_vecs[0][2], in_vecs[0][3]} =  {`BITS'h1, `BITS'h2, `BITS'h3, `BITS'h4};
		$display("clock count is %d", cnt);
		clock = ~clock; #1; // turn on
		{in_vecs[1][0], in_vecs[1][1], in_vecs[1][2], in_vecs[1][3]} =  {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		$display("clock count is %d", cnt);
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		{in_matrix[0][0], in_matrix[0][1], in_matrix[0][2], in_matrix[0][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		{in_matrix[1][0], in_matrix[1][1], in_matrix[1][2], in_matrix[1][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[2][0], in_matrix[2][1], in_matrix[2][2], in_matrix[2][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		{in_matrix[3][0], in_matrix[3][1], in_matrix[3][2], in_matrix[3][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		
		{in_matrix[4][0], in_matrix[4][1], in_matrix[4][2], in_matrix[4][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		{in_matrix[5][0], in_matrix[5][1], in_matrix[5][2], in_matrix[5][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[6][0], in_matrix[6][1], in_matrix[6][2], in_matrix[6][3]} = {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		{in_matrix[7][0], in_matrix[7][1], in_matrix[7][2], in_matrix[7][3]} = {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		$display("clock count is %d", cnt);
		$display("Finished with some testing");
		// Am expecting this to fail the first dozen or so times
		$display("out_vec = %d%d%d%d\n",out_vecs[0][0], out_vecs[0][1], out_vecs[0][2], out_vecs[0][3]); #1;
		$finish();;
	end

endmodule