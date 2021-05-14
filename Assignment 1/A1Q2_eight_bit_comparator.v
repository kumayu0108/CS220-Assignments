`include "./A1Q2_one_bit_comparator.v"

module eight_bit_comparator(A, B, less, greater, equal);

    input [7:0] A;
    input [7:0] B;

    wire [6:0] ls;
    wire [6:0] gt;
    wire [6:0] eq;

    output less;
    output greater;
    output equal;
    wire less;
    wire greater;
    wire equal;

    // Units under Tests
    one_bit_comparator F1(A[7], B[7], 1'b0, 1'b0, 1'b1, ls[6], gt[6], eq[6]);
    one_bit_comparator F2(A[6], B[6], ls[6], gt[6], eq[6], ls[5], gt[5], eq[5]);
    one_bit_comparator F3(A[5], B[5], ls[5], gt[5], eq[5], ls[4], gt[4], eq[4]);
    one_bit_comparator F4(A[4], B[4], ls[4], gt[4], eq[4], ls[3], gt[3], eq[3]);
    one_bit_comparator F5(A[3], B[3], ls[3], gt[3], eq[3], ls[2], gt[2], eq[2]);
    one_bit_comparator F6(A[2], B[2], ls[2], gt[2], eq[2], ls[1], gt[1], eq[1]);
    one_bit_comparator F7(A[1], B[1], ls[1], gt[1], eq[1], ls[0], gt[0], eq[0]);
    one_bit_comparator F8(A[0], B[0], ls[0], gt[0], eq[0], less, greater, equal);
    
endmodule