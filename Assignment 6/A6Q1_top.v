module top;

    reg clk;

    reg [2:0]opcode[100:0];
    reg [4:0]read1[100:0];
    reg [4:0]read2[100:0];
    reg [4:0]write[100:0];
    reg [15:0]write_data[100:0];
    reg [7:0]i = 0;

    wire signed [15:0]out1;
    wire signed [15:0]out2;
    wire done;

    initial begin
        forever begin
            clk = 0;
            #5;
            clk = 1;
            #5;
            clk = 0;
        end
    end

    inface uut(opcode[i], read1[i], read2[i], write[i], write_data[i], out1, out2, clk, done);

    always @(posedge clk) begin
        if (done == 1) begin
            case(opcode[i])
                3'b001:$display("time:%d, Address : %d, Value = %d", $time, read1[i], out1);
                3'b010:$display("time:%d, Address1 : %d, Value1 = %d, Address2 : %d, Value2 = %d", $time, read1[i], out1, read2[i], out2);
                3'b011:$display("time:%d, Address : %d, Value = %d", $time, read1[i], out1);
                3'b100:$display("time:%d, Address1 : %d, Value1 = %d, Address2 : %d, Value2 = %d", $time, read1[i], out1, read2[i], out2);
                3'b101:$display("time:%d, Address Written : %d, Value : ", $time, write[i], out1);
                3'b110:$display("time:%d, Address Written : %d, Value : ", $time, write[i], out1);
                3'b111:$display("time:%d, Address Written : %d, Value : ", $time, write[i], out1);
            endcase
            i <= i + 1;
        end
        if(i == 9)$finish;
    end

    initial begin
        #3;
        opcode[0] = 3'b000; write[0] = 1; write_data[0] = 17;
        opcode[1] = 3'b011; read1[1] = 1; write[1] = 2; write_data[1] = -9;
        opcode[2] = 3'b100; read1[2] = 1; read2[2] = 2; write[2] = 3; write_data[2] = 65;
        opcode[3] = 3'b010; read1[3] = 2; read2[3] = 3;
        opcode[4] = 3'b111; read1[4] = 3; write[4] = 5; write_data[4] = 3;
        opcode[5] = 3'b101; read1[5] = 1; read2[5] = 2; write[5] = 4;
        opcode[6] = 3'b111; read1[6] = 4; write[6] = 4; write_data[6] = 9;
        opcode[7] = 3'b110; read1[7] = 5; read2[7] = 4; write[7] = 6;
        opcode[8] = 3'b001; read1[8] = 6;
    end

    initial begin
        #10000;
        $finish;
    end
endmodule