module one_bit_adder(a, b, cin, opcode, sum, carry);

    input a, b, cin, opcode;
    output sum, carry;
    wire sum;
    wire carry;

    assign sum = a^(b^opcode)^cin; 
    assign carry = ((a&(b^opcode)) | ((b^opcode)&cin) | (a&cin));

endmodule