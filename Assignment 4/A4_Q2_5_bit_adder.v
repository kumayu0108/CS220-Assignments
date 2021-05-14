module five_bit_adder(in_x, in_y, dir, dist, out_x, out_y, out_carry);

    input [3:0] in_x;
    input [3:0] in_y;
    input [1:0] dir;
	input [1:0] dist;

	output [4:0] out_x; 
    output [4:0] out_y; 
    output out_carry;
	wire [4:0] out_x; 
    wire [4:0] out_y; 
    wire out_carry;

    // 00 - east, 01 - west, 10 - north, 11 - south

    wire [3:0] intermediate_carry_x;
    wire [3:0] intermediate_carry_y;

    wire x1;
    wire x2;
    wire y1;
    wire y2;
    // we have to change x when dir=east or west, which both have dir[1] = 0, vice versa for y

    assign x1 = dist[0] & ~dir[1];
    assign x2 = dist[1] & ~dir[1];

    assign y1 = dist[0] & dir[1];
    assign y2 = dist[1] & dir[1];
	
    wire opcode; // operation code - sub(1) and add(0)
    assign opcode = dir[0]; // since we have to sub when dir=west(01) or south(11) and vice versa
 
	one_bit_adder X0 (in_x[0], x1, opcode, opcode, out_x[0], intermediate_carry_x[0]);
	one_bit_adder X1 (in_x[1], x2, intermediate_carry_x[0], opcode, out_x[1], intermediate_carry_x[1]);
    one_bit_adder X2 (in_x[2], 1'b0, intermediate_carry_x[1], opcode, out_x[2], intermediate_carry_x[2]);
    one_bit_adder X3 (in_x[3], 1'b0, intermediate_carry_x[2], opcode, out_x[3], intermediate_carry_x[3]);
    one_bit_adder X4 (1'b0, 1'b0, intermediate_carry_x[3], opcode, out_x[4], out_carry);

    one_bit_adder Y0 (in_y[0], y1, opcode, opcode, out_y[0], intermediate_carry_y[0]);
	one_bit_adder Y1 (in_y[1], y2, intermediate_carry_y[0], opcode, out_y[1], intermediate_carry_y[1]);
    one_bit_adder Y2 (in_y[2], 1'b0, intermediate_carry_y[1], opcode, out_y[2], intermediate_carry_y[2]);
    one_bit_adder Y3 (in_y[3], 1'b0, intermediate_carry_y[2], opcode, out_y[3], intermediate_carry_y[3]);
    one_bit_adder Y4 (1'b0, 1'b0, intermediate_carry_y[3], opcode, out_y[4], out_carry);

endmodule