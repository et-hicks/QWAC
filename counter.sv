module counter
    #(parameter COUNT_BITS = 10)
    (
    input clock,
    input reset,
    input done,
    output [COUNT_BITS-1:0] count
    );
    reg [COUNT_BITS-1:0] cnt;
    
    always @(posedge clock or negedge reset) begin
        case ({done, reset})
            2'b00: begin
                        cnt <= cnt + 1;
                   end
            2'b01: begin
                        cnt <= 0;
                   end
            2'b10: begin
                        cnt <= cnt;
                   end
            2'b11: begin
                        cnt <= 0;
                   end
        endcase
    end
    
    assign count = cnt;
endmodule