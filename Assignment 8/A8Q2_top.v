module top;

    reg clk;
    wire done;

    main uut(clk, done);

    always @(posedge clk) begin
        #1;
        if (done == 1) begin
            $finish;
        end
    end

    initial begin
        forever begin
            clk = 0;
            #5;
            clk = 1;
            #5;
            clk = 0;
        end
    end

endmodule