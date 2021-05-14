module fsm(clk, inp, nxt);
    input clk;
    input[1:0] inp;
    
    reg[3:0] curr = 4'b0000;

    output[3:0] nxt;
    reg[3:0] nxt;

    reg [3:0] MROM[12:0];
    reg [3:0] DROM_3[3:0];  //DROM for state 3.
    reg [3:0] DROM_10[3:0]; //DROM for state 10.

    initial begin
        DROM_3[0] = 4'b0100;
        DROM_3[1] = 4'b0101;
        DROM_3[2] = 4'b0110;
        DROM_3[3] = 4'b0110;
        DROM_10[0] = 4'b1011;
        DROM_10[1] = 4'b1100;
        DROM_10[2] = 4'b1100;
        DROM_10[3] = 4'b1100;
        MROM[0] = 3'b000;
        MROM[1] = 3'b000;
        MROM[2] = 3'b000;
        MROM[3] = 3'b001;
        MROM[4] = 3'b100;
        MROM[5] = 3'b100;
        MROM[6] = 3'b000;
        MROM[7] = 3'b000;
        MROM[8] = 3'b000;
        MROM[9] = 3'b000;
        MROM[10] = 3'b010;
        MROM[11] = 3'b011;
        MROM[12] = 3'b011;
    end

    always @(posedge clk) begin
        case(MROM[curr])
            3'b000 : curr <= curr + 1;
            3'b001 : curr <= DROM_3[inp];
            3'b010 : curr <= DROM_10[inp];
            3'b011 : curr <= 4'b0000;
            3'b100 : curr <= 4'b0111;
        endcase
    end
    
    always @(curr) begin
        nxt <= #2 curr;
    end
endmodule