// Gotta test everything

`timescale 10ps / 1ps // huh?
`include "../../constants.vh"
module vecAddTest();

	reg signed [`BITS-1:0]  in_vec [`VEC_LEN-1:0];
	reg signed [`BITS-1:0] out_vec;
	reg clock, reset, relu;
	
	vecAdd #(`BITS, `BITS, `VEC_LEN)
	dut (.clock(clock), .reset(reset), .in_vec(in_vec), .out_sum(out_vec), .relu(relu));
	
	
	initial begin
	   $dumpfile("dump.vcd"); //Setup file dump (for waveform viewer)
	   $dumpvars; //Dump signals to dumpfile
	   
	   {in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
	   #1;
	   $display("\n\n\t\tThe input vector is as follows\n");
	   $display("in_vec = %d%d%d%d\n",in_vec[0], in_vec[1], in_vec[2], in_vec[3]); #1;
	   
	   clock = 1; reset = 1; relu = 0;
		#1; // clock and reset take effect
		reset = 0;
		// THERE IS A BETTER WAY
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h0, `BITS'h0, `BITS'h0, `BITS'h0};
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		{in_vec[0], in_vec[1], in_vec[2], in_vec[3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h2};
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on
		clock = ~clock; #1; // turn off
		clock = ~clock; #1; // turn on	   
	end
endmodule
