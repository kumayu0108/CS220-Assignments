module one_bit_comparator (a, b, prev_less, prev_greater, prev_equal, curr_less, curr_greater, curr_equal);

   input a;
   input b;
   input prev_equal;    // output of equality test for previous bit
   input prev_greater;  // output of greater than test for previous bit
   input prev_less;     // output of less than test for previous bit

   output wire curr_equal, curr_greater, curr_less;     // output for current bits

    assign curr_less = prev_less | (~a & b & prev_equal);
    assign curr_greater = prev_greater | (a & ~b & prev_equal);
    assign curr_equal = ~curr_less & ~curr_greater; 

endmodule