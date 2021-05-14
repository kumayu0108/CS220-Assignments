`include "./A4Q1_one_bit_addr.v"

module eight_bit_addr(a, b, opcode, sum, carry, overflow);

    input [7:0] a;
    input [7:0] b;
    input opcode;

    output [7:0] sum;
    output carry;
    output overflow;
    
    wire [7:0] sum;
    wire carry;
    wire overflow;
    wire [6:0] intermediate_carry;

    one_bit_addr F0(a[0], b[0], opcode, opcode, sum[0], intermediate_carry[0]);
    one_bit_addr F1(a[1], b[1], intermediate_carry[0], opcode, sum[1], intermediate_carry[1]);
    one_bit_addr F2(a[2], b[2], intermediate_carry[1], opcode, sum[2], intermediate_carry[2]);
    one_bit_addr F3(a[3], b[3], intermediate_carry[2], opcode, sum[3], intermediate_carry[3]);
    one_bit_addr F4(a[4], b[4], intermediate_carry[3], opcode, sum[4], intermediate_carry[4]);
    one_bit_addr F5(a[5], b[5], intermediate_carry[4], opcode, sum[5], intermediate_carry[5]);
    one_bit_addr F6(a[6], b[6], intermediate_carry[5], opcode, sum[6], intermediate_carry[6]);
    one_bit_addr F7(a[7], b[7], intermediate_carry[6], opcode, sum[7], carry);
    
    assign overflow = intermediate_carry[6]^carry;

    // always @(overflow) begin
    //     $display("time : %d, 7th bit carry : %d,  carry : %d\n\n", $time, intermediate_carry[6], carry);
    // end

endmodule