module top;

wire out;
reg clk;

blink uut(clk, out);

reg [25:0] cycle_count;

always @(out) begin
    $display("cycles:%d  out:%d\n", cycle_count, out);
end

initial begin 
    cycle_count = 0;
end

always @(negedge clk) begin
    cycle_count <= cycle_count + 1;
    if(cycle_count == 310000)
        $finish;
end

initial begin
    forever begin
        clk = 0;
        #5
        clk = 1;
        #5
        clk = 0;
    end
end

endmodule