module decoder_3_8 (inp, op);
    input [2:0] inp;
    output [7:0] op;
    wire [7:0] op;

    assign op[0] = ~inp[2] & ~inp[1] & ~inp[0];
    assign op[1] = ~inp[2] & ~inp[1] & inp[0];
    assign op[2] = ~inp[2] & inp[1] & ~inp[0];
    assign op[3] = ~inp[2] & inp[1] & inp[0];
    assign op[4] = inp[2] & ~inp[1] & ~inp[0];
    assign op[5] = inp[2] & ~inp[1] & inp[0];
    assign op[6] = inp[2] & inp[1] & ~inp[0];
    assign op[7] = inp[2] & inp[1] & inp[0];
    
endmodule