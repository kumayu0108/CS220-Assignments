`include "./A1Q2_eight_bit_comparator.v"

module eight_bit_comparator_top;

    reg [7:0] A;
    reg [7:0] B;

    wire less, greater, equal;

    eight_bit_comparator UUT(A, B, less, greater, equal);

    always@(A or B or less or greater or equal) begin
        $display("time:%d A:%d B:%d less:%d greater:%d equal:%d", $time, A, B, less, greater, equal);
    end

    initial begin
        A = 10; B = 32;
        #1
        $display("\n");
        A = 100; B = 32;
        #1
        $display("\n"); 
        A = 20; B = 52;
        #1
        $display("\n");  
        A = 1; B = 3;
        #1
        $display("\n");  
        A = 10; B = 0;
        #1
        $display("\n");  
        A = 200; B = 31;
        #1
        $display("\n");  
        A = 86; B = 54;
        #1
        $display("\n");  
        A = 1; B = 1;
        #1
        $display("\n");  
        A = 42; B = 32;
        #1
        $display("\n");  
        A = 10; B = 10;
        #1
        $display("\n");  
    end

endmodule