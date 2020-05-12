module four_to_one_bus (
		input wire  [7:0] bus,
		output wire bus_0,
		output wire bus_1,
		output wire bus_2,
		output wire bus_3,
		output wire bus_4,
		output wire bus_5,
		output wire bus_6,
		output wire bus_7
		);
		
		assign bus_0 = bus[0];
		assign bus_1 = bus[1];
		assign bus_2 = bus[2];
		assign bus_3 = bus[3];
		assign bus_4 = bus[4];
		assign bus_5 = bus[5];
		assign bus_6 = bus[6];
		assign bus_7 = bus[7];
		
endmodule