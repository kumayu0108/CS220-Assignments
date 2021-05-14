module inface(opcode, read1, read2, write, write_data, out1, out2, clk, done);
    input [2:0]opcode;
    input [4:0]read1;
    input [4:0]read2;
    input [4:0]write;
    input [15:0]write_data;
    input clk;

    output [15:0]out1;
    output [15:0]out2;
    output done;

    reg [15:0]out1;
    reg [15:0]out2;

    reg [5:0]counter;
    reg signed [15:0]registers[31:0];
    reg [15:0]temp1;
    reg [15:0]temp2;
    reg done;

    reg continue; 
    wire signed [15:0]sum;

    sixteen_bit_addr ADD(temp1, temp2, opcode[1], sum);

    initial begin
        registers[0] = 16'd0;
        registers[1] = 16'd0;
        registers[2] = 16'd0;
        registers[3] = 16'd0;
        registers[4] = 16'd0;
        registers[5] = 16'd0;
        registers[6] = 16'd0;
        registers[7] = 16'd0;
        registers[8] = 16'd0;
        registers[9] = 16'd0;
        registers[10] = 16'd0;
        registers[11] = 16'd0;
        registers[12] = 16'd0;
        registers[13] = 16'd0;
        registers[14] = 16'd0;
        registers[15] = 16'd0;
        registers[16] = 16'd0;
        registers[17] = 16'd0;
        registers[18] = 16'd0;
        registers[19] = 16'd0;
        registers[20] = 16'd0;
        registers[21] = 16'd0;
        registers[22] = 16'd0;
        registers[23] = 16'd0;
        registers[24] = 16'd0;
        registers[25] = 16'd0;
        registers[26] = 16'd0;
        registers[27] = 16'd0;
        registers[28] = 16'd0;
        registers[29] = 16'd0;
        registers[30] = 16'd0;
        registers[31] = 16'd0;              

        counter = 0;

        done = 1;
    end
    
    always @(posedge clk) begin
        if(continue == 1)begin
            if (counter == 0) begin
                counter <= counter + 1;
                case (opcode)
                    3'b000:begin
                        registers[write] <= write_data;
                    end
                    3'b001:begin
                        out1 <= registers[read1];
                    end
                    3'b010:begin
                        out1 <= registers[read1];
                        out2 <= registers[read2];
                    end
                    3'b011:begin
                        out1 <= registers[read1];
                        registers[write] <= write_data;
                    end
                    3'b100:begin
                        out1 <= registers[read1];
                        out2 <= registers[read2];
                        registers[write] <= write_data;
                    end
                    3'b101:begin
                        temp1 <= registers[read1];
                        temp2 <= registers[read2];
                    end
                    3'b110:begin
                        temp1 <= registers[read1];
                        temp2 <= registers[read2];
                    end
                    3'b111:begin
                        temp1 <= (registers[read1] << write_data);
                    end
                endcase
            end
            else if ( (opcode == 3'b101 || opcode == 3'b110) && counter == 19) begin
                counter <= 0;
                done <= 1;
                continue <= 0;
                registers[write] <= sum;
                out1 <= sum;
            end
            else if (opcode == 3'b111 && counter == 19) begin
                counter <= 0;
                done <= 1;
                continue <= 0;
                registers[write] <= temp1;
                out1 <= temp1;
            end
            else if ((opcode == 3'b000 || opcode ==3'b001 || opcode == 3'b010 || opcode == 3'b011 || opcode ==3'b100) && counter == 1) begin
                counter <= 0;
                done <= 1;
                continue <= 0;
            end
        end
    end
    
    always @(posedge clk) begin
        if(done == 1)done <= #8 0;
        if(counter != 0)counter <= counter + 1;
    end

    always @(opcode, read1, read2, write, write_data) begin
        //$display("Instruction Received at %d", $time);
        counter <= 0;
        done <= 0;
        continue <= 1;
    end

endmodule