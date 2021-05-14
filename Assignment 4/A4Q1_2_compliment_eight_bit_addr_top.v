`include "./A4Q1_eight_bit_addr.v"

module eight_bit_adder_top;

   reg signed [7:0] A;
   reg signed [7:0] B;
   reg opcode;

   wire signed [7:0] Sum;
   wire Carry;
   wire Overflow;

   eight_bit_addr ADDER (A, B, opcode, Sum, Carry, Overflow);

   always @ (A or B or opcode) begin
       $monitor("time=%d: A = %d,  B = %d, Opcode = %d, Output = %d\ntime=%d: A = %b,  B = %b, Opcode = %d, Output = %b, Carry = %d, Overflow = %d\n", $time, A, B, opcode, Sum, $time, A, B, opcode, Sum, Carry, Overflow);
    //    $monitor("time=%d: A = %b,  B = %b, Opcode = %d, Output = %b, Carry = %d, Overflow = %d\n", $time, A, B, opcode, Sum, Carry, Overflow);
   end

   initial begin
       #15;                     
       $finish; 
   end


   // Test Cases.
   initial begin
      A = 8'b01100100; B = 8'b01100100; opcode = 1;
      #1; 
      $display("\n");
      A = 8'b01111000; B = 8'b01111000; opcode = 0;
      #1; 
      $display("\n");
      A = 8'b00010100; B = 8'b01100100; opcode = 1;
      #1; 
      $display("\n");
      A = 8'b11100111; B = 8'b01111111; opcode = 0;
      #1; 
      $display("\n");
      A = 8'b01010000; B = 8'b00101000; opcode = 0;
      #1; 
      $display("\n");
      A = 8'b00001010; B = 8'b01100100; opcode = 1;
      #1; 
      $display("\n");
      A = 8'b00100001; B = 8'b00010100; opcode = 0;
      #1; 
      $display("\n");
      A = 8'b00101011; B = 8'b00011110; opcode = 0;
      #1; 
      $display("\n");
      A = 8'b00101000; B = 8'b00010100; opcode = 1;
      #1; 
      $display("\n");
      A = 8'b00110110; B = 8'b00001010; opcode = 1;
      #1; 
   end

endmodule