module encoder_8_3(inp, op);

    input [7:0] inp;
    output [2:0] op;
    wire [2:0] op;

    assign op[2] = inp[7] | inp[6] | inp[5] | inp[4]; 
    assign op[1] = inp[7] | inp[6] | inp[3] | inp[2];
    assign op[0] = inp[7] | inp[5] | inp[3] | inp[1];

endmodule