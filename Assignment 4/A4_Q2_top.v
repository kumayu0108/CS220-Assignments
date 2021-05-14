module top;

    reg clock;
    wire [3:0] x;
    wire [3:0] y;
    reg [1:0] dir;
    reg [1:0] dist;

    grid uut (clock, dir, dist, x, y);
    
    // 00 - east, 01 - west, 10 - north, 11 - south

    initial begin 
        #3
        dir = 2'b 10;
        dist = 2'b 10;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 00;
        dist = 2'b 10;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 10;
        dist = 2'b 01;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 01;
        dist = 2'b 01;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 00;
        dist = 2'b 11;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 00;
        dist = 2'b 11;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 00;
        dist = 2'b 11;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 11;
        dist = 2'b 10;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 00;
        dist = 2'b 11;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #10
        dir = 2'b 01;
        dist = 2'b 11;
        $display("time:%d  x = %d y = %d direction = %d steps = %d\n",$time, x, y, dir, dist);

        #2
        $finish;
    end

    initial begin
        forever begin
            clock=0;
            #5
            clock=1;
            #5
            clock=0;
        end
    end

endmodule