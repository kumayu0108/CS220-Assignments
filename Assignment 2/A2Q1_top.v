module top;
    reg [2:0] a;
    reg [2:0] tmp = 3'b001;
    wire [7:0] b;
    wire [2:0] final;

    decoder_3_8 F1 (a, b);
    encoder_8_3 F2 (b, final);

    always @(a) begin
        $monitor("time: %d, a: %b, b: %b, final: %b", $time, a, b, final);
    end

    initial begin
        a = 3'b000;
        #1;
        a = 3'b001;
        #1;
        a = 3'b010;
        #1;
        a = 3'b011;
        #1;
        a = 3'b100;
        #1;
        a = 3'b101;
        #1;
        a = 3'b110;
        #1;
        a = 3'b111;
        #1;
    end
endmodule