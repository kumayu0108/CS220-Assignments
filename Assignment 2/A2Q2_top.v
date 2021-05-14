module eight_bit_adder_top;

   reg [7:0] in;
   wire [2:0] out;

   priority_encoder3to8 uut (in, out);

   always @ (in or out) begin
       $display("time=%d: in = %b, out = %b\n",$time,in,out);
   end

   initial begin
       #15; 
       $finish; 
   end

   initial begin
      in = 8'b00000100; 
      #1; 
      $display("\n");
      in = 8'b00010100; 
      #1; 
      $display("\n");
      in = 8'b10010000; 
      #1; 
      $display("\n");
      in = 8'b01010010; 
      #1; 
      $display("\n");
      in = 8'b10110100; 
      #1; 
      $display("\n");
      in = 8'b01010100; 
      #1; 
      $display("\n");
      in = 8'b11111111; 
      #1; 
      $display("\n");
      in = 8'b11111110; 
      #1; 
      $display("\n");
      in = 8'b00000100; 
      #1; 
      $display("\n");
      in = 8'b11100000; 
      #1; 
      $display("\n");
   end

endmodule