`define OUTPUT_REG 4
`define MAX_PC 11

module main(clk, done);
    input clk;

    output done;
    reg done;

    reg signed [7:0]register[0:31];
    reg signed [7:0]data_memory[2:0];

    reg [31:0]instr[10:0];
    reg [31:0]curr_instr;
    reg [7:0]i;
    reg [2:0]state;
    reg [7:0]immediate;
    reg [7:0]jump_addr;

	reg [5:0]opcode;
    reg [5:0]func;

    reg [4:0]srcreg1;
	reg [4:0]srcreg2;
	reg [4:0]destreg;
    reg [4:0]shift;

    reg INVALID;

    reg [7:0]src_data1;
    reg [7:0]src_data2;

    reg slt_result;
    reg [7:0]temp_add;
    reg [7:0]nxt_addr;
    reg [7:0]lw_addr;
    reg [7:0]lw_data;

    initial begin
		INVALID <= 0;
        i <= 0;
        state <= 0;
		register[0] <= 0;
		register[1] <= 0;
		register[2] <= 0;
		register[3] <= 0;
		register[4] <= 0;
		register[5] <= 0;
		register[6] <= 0;
		register[7] <= 0;
		register[8] <= 0;
		register[9] <= 0;
		register[10] <= 0;
		register[11] <= 0;
		register[12] <= 0;
		register[13] <= 0;
		register[14] <= 0;
		register[15] <= 0;
		register[16] <= 0;
		register[17] <= 0;
		register[18] <= 0;
		register[19] <= 0;
		register[20] <= 0;
		register[21] <= 0;
		register[22] <= 0;
		register[23] <= 0;
		register[24] <= 0;
		register[25] <= 0;
		register[26] <= 0;
		register[27] <= 0;
		register[28] <= 0;
		register[29] <= 0;
		register[30] <= 0;
		register[31] <= 0;

        data_memory[0] <= -20;
        data_memory[1] <= 10;
        data_memory[2] <= 2;
        
        //lw $1, 0($0) // opcode: 0x23
        instr[0] <= {6'h23, 5'd0, 5'd1, 16'd0};
		
		// lw $2, 1($0)
    	instr[1] <= {6'h23, 5'd0, 5'd2, 16'd1};

		// lw $3, 2($0)
		instr[2] <= {6'h23, 5'd0, 5'd3, 16'd2};

		// addiu $4, $0, 0 // opcode: 0x9
		instr[3] <= {6'h9, 5'd4, 5'd0, 16'd0};

		// addiu $5, $1, 0
		instr[4] <= {6'h9, 5'd5, 5'd1, 16'd0};

		// slt $6, $5, $2 // opcode: 0x0, func: 0x2a
		instr[5] <= {6'h0, 5'd5, 5'd2, 5'd6, 5'd0, 6'h2a};

		// beq $6, $0, exit // opcode: 0x4, encode exit as 5
		instr[6] <= {6'h4, 5'd6, 5'd0, 16'd5};

        // addu $4, $4, $5 // opcode: 0x0, func: 0x21
        instr[7] <= {6'h0, 5'd4, 5'd5, 5'd4, 5'd0, 6'h21};

        // addu $5, $5, $3
		instr[8] <= {6'h0, 5'd5, 5'd3, 5'd5, 5'd0, 6'h21};
		
		// slt $6, $5, $2
    	instr[9] <= {6'h0, 5'd5, 5'd2, 5'd6, 5'd0, 6'h2a};

		// bne $6, $0, loop // opcode: 0x5, encode loop as -3
		instr[10] <= {6'h5, 5'd6, 5'd0, -16'd3};

    end

    always @(posedge clk) begin
        case (state)
            0 : begin
                curr_instr <= instr[i];
                state <= state + 1;
            end
            1 : begin
                opcode <= curr_instr[31:26];
                case (curr_instr[31:26])
                    6'h0 : begin
                        srcreg1 <= curr_instr[25:21];
                        srcreg2 <= curr_instr[20:16];
                        destreg <= curr_instr[15:11];
                        shift <= curr_instr[10:6];
                        func <= curr_instr[5:0];
                    end
                    6'h3 : begin
                        jump_addr = curr_instr[7:0];
                        destreg <= 31;
                    end
                    6'h4 : begin
                        srcreg1 <= curr_instr[25:21];
                        srcreg2 <= curr_instr[20:16];
                        immediate <= curr_instr[7:0];
                    end
                    6'h5 : begin
                        srcreg1 <= curr_instr[25:21];
                        srcreg2 <= curr_instr[20:16];
                        immediate <= curr_instr[7:0];
                    end
                    6'h9 : begin
                        destreg <= curr_instr[25:21];
                        srcreg1 <= curr_instr[20:16];
                        immediate <= curr_instr[7:0];
                    end
                    6'h23: begin
                        srcreg1 <= curr_instr[25:21];
                        destreg <= curr_instr[20:16];
                        immediate <= curr_instr[7:0];
                    end
                endcase
                state <= state + 1;
            end
            2 : begin
                case (opcode)
                    6'h0 : begin
                        src_data1 <= register[srcreg1];
                        src_data2 <= register[srcreg2];
                    end
                    6'h3 : nxt_addr <= i + 1;
                    6'h4 : begin
                        src_data1 <= register[srcreg1];
                        src_data2 <= register[srcreg2];
                    end
                    6'h5 : begin
                        src_data1 <= register[srcreg1];
                        src_data2 <= register[srcreg2];
                    end
                    6'h9 : begin
                        src_data1 <= register[srcreg1];
                    end
                    6'h23: begin
                        src_data1 <= register[srcreg1];
                    end
                endcase
                state <= state + 1;
            end
            3 : begin
                INVALID = 0;
                case (opcode)
                    6'h0 : begin
                        case (func)
                            6'h2a : begin
                                slt_result <= ($signed(src_data1) < $signed(src_data2));
                                i <= i + 1;
                            end
                            6'h21 : begin
                                temp_add <= src_data1 + src_data2;
                                i <= i + 1;
                            end
                            6'h8  : i <= src_data1;
                            default : INVALID <= 1;
                        endcase
                    end
                    6'h3 : begin
                        i <= jump_addr;
                    end
                    6'h4 : begin
                        if(src_data1 == src_data2) i <= i + immediate;
                        else i <= i + 1;
                    end 
                    6'h5 : begin
                        if(src_data1 != src_data2) i <= i + immediate;
                        else i <= i + 1;
                    end
                    6'h9 : begin
                        temp_add <= src_data1 + immediate;
                        i <= i + 1;
                    end
                    6'h23: begin
                        lw_addr <= immediate + src_data1;
                        i <= i + 1;
                    end
                    default : INVALID <= 1;
                endcase
                state <= state + 1;
            end
            4 : begin
                if(opcode == 6'h23)begin
                    lw_data <= data_memory[lw_addr];
                end
                state <= state + 1; 
            end
            5 : begin
                if(INVALID != 1)begin
                    case (opcode)
                        6'h0 : begin
                            case (func)
                                6'h2a : register[destreg] <= slt_result;
                                6'h21 : register[destreg] <= temp_add;
                            endcase
                        end
                        6'h3 : begin
                            register[destreg] <= nxt_addr;
                        end
                        6'h9 : begin
                            register[destreg] <= temp_add;
                        end
                        6'h23: begin
                            register[destreg] <= lw_data;
                        end
                    endcase
                end
                if(i < `MAX_PC) state <= 0;
                else state <= state + 1;

            end
            6 : begin
                $display("time : %d, Output : %d", $time, register[`OUTPUT_REG]);
                done <= 1;
            end
        endcase
    end

endmodule
