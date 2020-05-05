`timescale 1ps / 1ps
`include "../../constants.vh"

module vv_opsTest();
    
    reg clock, reset, relu;
    reg [1:0] control;
    
    
    reg signed [`BITS-1:0] vec_a [`VEC_LEN-1:0];
    reg signed [`BITS-1:0] vec_b [`VEC_LEN-1:0];
    reg signed [`BITS-1:0] out   [`VEC_LEN-1:0];
    reg signed [`BITS-1:0] scalar_out;
    
    vv_ops #(`BITS, `BITS, `VEC_LEN)
    dut (.clock(clock), .reset(reset), .control(control), .vec_a(vec_a), .vec_b(vec_b), .out_vec(out));
    
    vecAdd #(`BITS, `BITS, `VEC_LEN)
    vector_adder (.clock(clock), .reset(reset), .relu(relu), .in_vec(vec_a), .out_sum(scalar_out));
    
    initial begin 
        $dumpfile("dump.vcd"); //Setup file dump (for waveform viewer)
		$dumpvars; //Dump signals to dumpfile
		#1 #1 #1 #1 #1
		{vec_a[0], vec_a[1], vec_a[2], vec_a[3]} =  {`BITS'h1, `BITS'h1, `BITS'h1, `BITS'h1};
		{vec_b[0], vec_b[1], vec_b[2], vec_b[3]} =  {`BITS'h2, `BITS'h3, `BITS'h4, `BITS'h5};
		control = {1'b0, 1'b0};
		clock = 1; reset = 1; relu = 0;
		#10;
		clock = ~clock; #10; // turn off
		clock = ~clock; #10; // turn on
		reset = 0;
		{vec_a[0], vec_a[1], vec_a[2], vec_a[3]} =  {-1, -1, -1, -1};
		clock = ~clock; #10; // turn off
		clock = ~clock; #10; // turn on
		relu = 1;
		control = {1'b0, 1'b1}; #1;
		control = {1'b1, 1'b1}; #1;
		control = {1'b1, 1'b0}; #1;
		clock = ~clock; #10; // turn off
		clock = ~clock; #10; // turn on
		control = {1'b1, 1'b0};
		clock = ~clock; #10; // turn off
		clock = ~clock; #10; // turn on
		control = {1'b1, 1'b1};
		clock = ~clock; #10; // turn off
		clock = ~clock; #10; // turn on
		control = {1'b1, 1'b1};
		control = {1'b0, 1'b1};
		clock = ~clock; #10; // turn off
		clock = ~clock; #10; // turn on
		clock = ~clock; #10; // turn off
		clock = ~clock; #10; // turn on
    end
    
endmodule

