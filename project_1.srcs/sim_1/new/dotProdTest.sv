`include "../../constants.vh"
// From what I can tell, dot product does indeed work
// YAYYYY
module dotProdTest();
    reg signed [`BITS-1:0]  in_matrix[`MAT_C-1:0];
	reg signed [`BITS-1:0]  in_vec [`VEC_LEN-1:0];
	reg signed [`BITS-1:0] out_vec;
	reg clock, reset;
	
	dotProdEng #(`BITS, `BITS, `VEC_LEN)
	dut (.clock(clock), .reset(reset), .vec(in_vec), .mat_vec(in_matrix), .dotted(out_vec));
	
	initial begin
	   $dumpfile("dump.vcd"); //Setup file dump (for waveform viewer)
	   $dumpvars; //Dump signals to dumpfile
	   
	   {in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
	   {in_matrix[0], in_matrix[1], in_matrix[2], in_matrix[3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
	   #1;
	   
	   $display("\t\t\tThe input matrix is as follows\n");
	   $display("in_matrix[0] = %d%d%d%d\n",in_matrix[0], in_matrix[1], in_matrix[2], in_matrix[3]);
	   
	   $display("\n\n\t\tThe input vector is as follows\n");
	   $display("in_vec = %d%d%d%d\n",in_vec[0], in_vec[1], in_vec[2], in_vec[3]); #1
	   // $finish;
	   $display("\n\n\nJust seeing what works and what doesn't\n\n\n");
	
	   clock = 1; reset = 1;
		#1; // clock and reset take effect
		reset = 0;
		// THERE IS A BETTER WAY
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		$display("clock is currently: %d", clock);
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h0, `BITS'h0, `BITS'h0, `BITS'h0};
		clock = ~clock; #1; // turn off
		$display("clock is currently: %d", clock);
		clock = ~clock; #1; // turn on
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'ha, `BITS'ha, `BITS'ha, `BITS'ha};
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h0, `BITS'h0, `BITS'h0, `BITS'h0};
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{in_matrix[0], in_matrix[1], in_matrix[2], in_matrix[3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h0, `BITS'h0, `BITS'h0, `BITS'h0};
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		{in_matrix[0], in_matrix[1], in_matrix[2], in_matrix[3]} =  {`BITS'h2, `BITS'h2, `BITS'h2, `BITS'h2};
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		$display("Finished with some testing");
		// Am expecting this to fail the first dozen or so times
		$display("out_vec = %d%d%d%d\n",out_vec[0], out_vec[1], out_vec[2], out_vec[3]); #1;
	   $finish();
	end
endmodule