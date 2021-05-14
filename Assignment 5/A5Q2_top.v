module top;

reg [2:0] a, b, c, d;
wire [1:0] minidx;

returnmin uut(a, b, c, d, minidx);

always @(a, b, c, d, minidx) begin
   $display("time:%d  a = %d b = %d c = %d d = %d, minidx : %d\n", $time, a, b, c, d, minidx);
end

initial begin 
        a <= 000;
        b <= 001;
        c <= 010;
        d <= 011;
        #1
        a <= 010;
        b <= 001;
        c <= 010;
        d <= 011;
        #1
        a <= 010;
        b <= 011;
        c <= 010;
        d <= 011;
        #1
        a <= 100;
        b <= 001;
        c <= 110;
        d <= 011;
        #1
        a <= 100;
        b <= 101;
        c <= 101;
        d <= 101;
        #1
        a <= 100;
        b <= 001;
        c <= 110;
        d <= 111;
        #1
        a <= 111;
        b <= 111;
        c <= 110;
        d <= 010;
        #1
        a <= 111;
        b <= 100;
        c <= 101;
        d <= 010;
        #1
        a <= 010;
        b <= 011;
        c <= 000;
        d <= 010;
        #1
        a <= 101;
        b <= 001;
        c <= 110;
        d <= 111;
        #1
        $finish; 
    end

endmodule