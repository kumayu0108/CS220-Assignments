module top;
    reg clock;
    wire [3:0] out;

    rotate F1 (clock, out);
    reg [19:0] cycle_count;
    
    initial begin
        forever begin
            clock = 0;
            #5; 
            clock = 1;
            #5
            clock = 0; 
        end
    end

    initial begin 
        cycle_count = 0;
    end

    always @(posedge clock) begin
        cycle_count <= cycle_count + 1;
        if (cycle_count == 310000)
            $finish;
    end

    always @(out) begin
        $display("cycles:%d, output:%b, ", cycle_count, out);
    end

endmodule