`define OUTPUT_REG 5

module res(clk,result_data,check);

	input clk;
	output reg [7:0]result_data;
	output check;
	
	reg [2:0]present_state;
	reg [31:0]instruction;
	reg [7:0]immediate;
	reg [5:0]opcode;
	reg [5:0]ins_function;
	reg [7:0]result;

	reg [31:0]ins_memory[0:6];
	
	reg [7:0]register[0:31];

	reg [4:0]srcreg1;
	reg [4:0]srcreg2;
	reg [4:0]destreg;

	reg [7:0]src_data1;
	reg [7:0]src_data2;

	reg [2:0]PC;
	reg [2:0]MAX_PC;

	
	reg INVALID;
	reg check=0;

	always @(posedge clk) begin
		case (present_state)
			0 : begin
			instruction <= ins_memory[PC];
			PC <= PC + 1;
			present_state <= 3'b001;
		  end

		  1 : begin
			opcode[5:0] <= instruction[31:26];
			srcreg1 <= instruction[25:21];
			present_state <= 3'b010;

			if(instruction[31:26] == 6'b000000)begin
				srcreg2 <= instruction[20:16];
				destreg <= instruction[15:11];
				ins_function <= instruction[5:0];
			end
			else  begin
			    destreg <= instruction[20:16];
			    immediate <= instruction[7:0];
			end
						
		  end

		  2 : begin
			src_data1 <= register[srcreg1];
			src_data2 <= register[srcreg2];
			present_state <= 3'b011;
		  end

		  3 : begin
			INVALID = 0; 
			if(opcode[5:0] == 6'b000000)begin
				if(ins_function == 6'b100001)
					result <= src_data1 + src_data2;
				else if(ins_function == 6'b100011)
					result <= src_data1 - src_data2;
				else 
					INVALID <= 1;
			end
			else if(opcode[5:0] == 6'b001001)
				result <= src_data1 + immediate;
			else 
				INVALID <= 1;
			present_state <= 3'b100;
		  end

		  4 : begin
			if(INVALID == 1'b0 && destreg != 5'b00000) 
				register[destreg] <= result;
			if(PC < MAX_PC) 
				present_state <= 3'b000;
			else 
				present_state <= 3'b101;
		  end

		  5 : begin
			result_data <= register[`OUTPUT_REG];
			check <= 1; 
		  end
		  
		endcase
	end

	initial begin
		INVALID <= 0;
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

		// addiu $1, $0, 45   // opcode: 0x9
		ins_memory[0] <= {6'b001001, 5'b00000, 5'b00001, 8'b00000000, 8'b00101101};
		
		// addiu $2, $0, -20
    	ins_memory[1] <= {6'b001001, 5'b00000, 5'b00010, 8'b11111111, 8'b11101100};

		// addiu $3, $0, -60
		ins_memory[2] <= {6'b001001, 5'b00000, 5'b00011, 8'b11111111, 8'b11000100};

		// addiu $4, $0, 30
		ins_memory[3] <= {6'b001001, 5'b00000, 5'b00100, 8'b00000000, 8'b00011110};

		// addu  $5, $1, $2  // opcode: 0x0, function: 0x21
		ins_memory[4] <= {6'b000000, 5'b00001, 5'b00010, 5'b00101, 5'b00000, 6'b100001};

		// addu  $6, $3, $4
		ins_memory[5] <= {6'b000000, 5'b00011, 5'b00100, 5'b00110, 5'b00000, 6'b100001};

		// subu  $5, $5, $6
		ins_memory[6] <= {6'b000000, 5'b00101, 5'b00110, 5'b00101, 5'b00000, 6'b100011};


		PC <= 3'b000;
		MAX_PC <= 3'b111;
		present_state <= 3'b000;
	end
endmodule
