module top;

    reg clock;
    reg[1:0] inp;
    // wire [3:0] curr = 4'b0000;
    wire [3:0] nxt;

    // assign curr = nxt;

    fsm uut (clock, inp, nxt);

    initial begin
        forever begin
            clock = 0;
            #5;
            clock = 1;
            #5;
            clock = 0;
        end
    end

    always @(posedge clock) begin
        $display("Time : %d, input : %b, current : %d", $time, inp, nxt);
    end

    initial begin
        #3;
        inp = 2'b00;     //3
        #10;
        inp = 2'b11;     //13
        #10;
        inp = 2'b01;     //23
        #10;        
        inp = 2'b11;     //33
        #10;
        inp = 2'b00;     //43
        #10;
        inp = 2'b11;     //53
        #10;
        inp = 2'b10;     //63
        #10;
        inp = 2'b00;     //73
        #10;
        inp = 2'b01;     //83
        #10;
        inp = 2'b10;     //93
        #10;
        inp = 2'b10;     //103
        #10;
        $finish;
    end

endmodule