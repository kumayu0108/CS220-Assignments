module rotate(clock, op);
    input clock;
    
    output [3:0] op;

    reg [3:0] op;
    reg [19:0] cycle_count1;

    initial begin
        op = 4'b1000;
        cycle_count1 = 0;
    end

    always @(posedge clock) begin
        cycle_count1 <= cycle_count1 + 1;
        if (cycle_count1 == 24999) begin
            op[3] <= op[2];
            op[2] <= op[1];
            op[1] <= op[0];
            op[0] <= op[3];
            cycle_count1 <= 0;
        end
    end
endmodule