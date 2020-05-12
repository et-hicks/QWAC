module four_wires_to_bus(
		input wire in_0,
		input wire in_1,
		input wire in_2,
		input wire in_3,
		
		output [3:0] bus
	);
	
	assign bus = {in_3, in_2, in_1, in_0}; // making sure the biggest bit is where is supposed to be
	
endmodule