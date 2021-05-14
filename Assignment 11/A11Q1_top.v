`include "./A11Q1_Booth_Multiply.v"

module top;

    reg clk;
    reg initiate;
    reg signed [31:0] A [0:9];
    reg signed [31:0] B [0:9];
    reg signed [31:0] multiplier;
    reg signed [31:0] multiplicand;

    wire done;
    reg [4:0] i;
    wire [6:0] count_add;
    wire [6:0] count_sub;
    wire signed [63:0] product;
    
    Booth uut(clk, initiate, multiplicand, multiplier, product, count_add, count_sub, done);

    always @(negedge clk) begin
        if (done == 1) begin
            $display("PRODUCT: %d MULTIPLICAND : %d MULTIPLIER : %d  COUNT_ADD : %d COUNT_SUB : %d", product, multiplicand, multiplier, count_add, count_sub);
            initiate <= 1;
            multiplicand <= A[i];
            multiplier <= B[i];
            i <= i+1;
            if (i == 10) $finish;
        end
        else begin
            initiate <= 0;
        end
    end

    
    initial begin
        i = 0;
        A[0] = 23; B[0] = -20;
        A[1] = 561; B[1] = 2;
        A[2] = -14; B[2] = 277;
        A[3] = 1; B[3] = 2;
        A[4] = 1002; B[4] = 7456;
        A[5] = 257; B[5] = -825;
        A[6] = 78; B[6] = 25;
        A[7] = 12578; B[7] = 1;
        A[8] = -57; B[8] = 27;
        A[9] = 2471; B[9] = 2;
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