module top;

reg [31:0] instruction;
reg clk;

reg [31:0]instr[7:0];
reg  [5:0]iter = 0;

wire [5:0] countR;
wire [5:0] countI;
wire [5:0] countJ;
wire [5:0] count3;
wire [5:0] count4;
wire [5:0] count5;
wire [5:0] count6;

count uut(instruction, clk, countR, countI, countJ, count3, count4, count5, count6);

always @(posedge clk) begin
    instruction = instr[iter];
    iter <= iter + 1;
    if(iter == 8) begin
        $display("countR:%d \ncountI:%d \ncountJ:%d \ncount3:%d \ncount4:%d \ncount5:%d \ncount6:%d", countR, countI, countJ, count3, count4, count5, count6);
        $finish;
    end
end

initial begin

        // addi $4, $0, 0x3456   // opcode: 0x8
		instr[0] <= {6'b001000, 5'b00000, 5'b00100, 4'b0011, 4'b0100, 4'b0101, 4'b0110};
		
		// addi $5, $0, 0xffff 
    	instr[1] <= {6'b001000, 5'b00000, 5'b00101, 4'b1111, 4'b1111, 4'b1111, 4'b1111};

		// add  $6, $5, $4 // opcode: 0x0, function: 0x20
		instr[2] <= {6'b000000, 5'b00101, 5'b00100, 5'b00110, 5'b00000, 6'b100000};

		// addi $3, $0, 0x7
		instr[3] <= {6'b001000, 5'b00000, 5'b00011, 4'b0000, 4'b000, 4'b0000, 4'b0111};

		// sllv $6, $6, $3  // opcode: 0x0, function: 0x4
		instr[4] <= {6'b000000, 5'b00110, 5'b00011, 5'b00110, 5'b00000, 6'b000100};

		// srl  $3, $3, 0x1 // opcode: 0x0, function: 0x2
		instr[5] <= {6'b000000, 5'b00000, 5'b00011, 5'b00011, 5'b00001, 6'b000010};

		// lw   $5, 0x9abc($4) // opcode: 0x23
		instr[6] <= {6'b100011, 5'b00100, 5'b00101, 4'b1001, 4'b1010, 4'b1011, 4'b1100};

        // j    0x123456 // opcode: 0x2
        instr[7] <= {6'b000010, 2'b00, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110};

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