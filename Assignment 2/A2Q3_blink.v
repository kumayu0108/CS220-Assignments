module blink(clk,out);

input clk;
wire clk;

output out;
reg out;

reg [25:0] cycle_count;

always @(negedge clk) begin
    cycle_count <= cycle_count + 1;
    if(cycle_count == 24999) begin
        out <= #2 ~out;
        cycle_count <= 0;
    end
end

initial begin
    out = 0;
    cycle_count = 0;
end

endmodule


