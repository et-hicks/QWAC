module counter
    #(parameter COUNT_BITS = 10)
    (
    input clock,
    input reset,
    output [COUNT_BITS-1:0] count
    );
    reg [COUNT_BITS-1:0] cnt;
    
    always @(posedge clock or negedge reset) begin
        if (reset) begin
            cnt <= 0;
        end else begin
            cnt = cnt + 1;
        end
    end
    
    assign count = cnt;
endmodule