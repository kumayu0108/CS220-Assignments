module Booth(clk, initiate, multiplicand, multiplier, prod, count_add, count_sub, done);

    input clk;
    input initiate;
    input signed [31:0] multiplicand;
    input signed [31:0] multiplier;
    
    output reg done;   
    output reg [6:0] count_add;
    output reg [6:0] count_sub;
    output reg signed [63:0] prod;

    reg [6:0] count;
    reg multiplier_new;
    reg signed [31:0] multiplicand_copy;
    reg signed [31:0] multiplier_copy;

    always @(posedge clk ) begin
        
        if (initiate == 1) begin
            done <= 0;
            count <= 0;
            count_sub <= 6'b 0;
            count_add <= 6'b 0;
            multiplier_new <= 1'b 0;
            multiplier_copy <= multiplier;
            multiplicand_copy <= multiplicand;
            prod <= 64'b 0;
        end

        else if (done == 0) begin

            if ({multiplier_copy[0], multiplier_new} == 2'b0_1) begin
                prod <= prod + multiplicand_copy;
                count_add <= count_add + 1;
                if (multiplier_copy == 32'b 0) begin
                    done <= 1;
                end
            end  

            else if ({multiplier_copy[0], multiplier_new} == 2'b1_0) begin
                prod <= prod - multiplicand_copy;
                count_sub <= count_sub + 1;
                if (multiplier_copy == 32'h ffffffff) begin
                    done <= 1;
                end
            end  

            multiplier_new = multiplier_copy[0];
            multiplier_copy = multiplier_copy >> 1; 
            multiplicand_copy = multiplicand_copy << 1;
            count <= count + 1;

            if (count == 32) done <= 1;
           
        end
    end

    initial done <= 1;    

    
endmodule