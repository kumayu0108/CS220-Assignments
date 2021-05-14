`include "./A1Q1_eight_bit_adder.v"

module eight_bit_adder_top;

   reg [7:0] A;
   reg [7:0] B;
   reg Cin;

   wire [7:0] Sum;
   wire Carry;

   eight_bit_adder ADDER (A, B, Cin, Sum, Carry);

   always @ (A or B or Cin or Sum or Carry) begin
       $display("time=%d: %d + %d + %d = %d, carry = %d\n",$time,A,B,Cin,Sum,Carry);
   end

   initial begin
       #15;                     
       $finish; 
   end

   // Test Cases.
   initial begin
      A = 100; B = 100; Cin = 1;
      #1; 
      $display("\n");
      A = 200; B = 200; Cin = 0;
      #1; 
      $display("\n");
      A = 20; B = 200; Cin = 0;
      #1; 
      $display("\n");
      A = 25; B = 190; Cin = 0;
      #1; 
      $display("\n");
      A = 80; B = 40; Cin = 0;
      #1; 
      $display("\n");
      A = 10; B = 100; Cin = 1;
      #1; 
      $display("\n");
      A = 33; B = 20; Cin = 0;
      #1; 
      $display("\n");
      A = 43; B = 30; Cin = 0;
      #1; 
      $display("\n");
      A = 40; B = 20; Cin = 1;
      #1; 
      $display("\n");
      A = 54; B = 10; Cin = 1;
      #1; 
   end

endmodule