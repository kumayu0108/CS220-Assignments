module top;

    reg clock;
    reg in;

    wire out;

    fsm uut (in, clock, out);

    initial begin
        #3;
        in = 0;     //3
        #10;
        in = 1;     //13
        #10;
        in = 0;     //23
        #10;        
        in = 1;     //33
        #10;
        in = 1;     //43
        #10;
        in = 1;     //53
        #10;
        in = 1;     //63
        #10;
        in = 1;     //73
        #10;
        in = 1;     //83
        #10;
        in = 1;     //93
        #10;
        in = 1;     //103
    end

    always @(posedge clock) begin
        $display("time:%d, in:%d, out:%d", $time, in, out);
    end

    initial begin
        forever begin
            clock = 0;
            #5;
            clock = 1;
            #5;
            clock = 0;
        end
    end

    initial begin
        #100;
        $finish;    
    end

endmodule