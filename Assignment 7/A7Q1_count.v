module count(instr[31:0], clk, countR[5:0], countI[5:0], countJ[5:0], count3[5:0], count4[5:0], count5[5:0], count6[5:0]);

input [31:0] instr;
input clk;

output reg [5:0] countR = 0;
output reg [5:0] countI = 0;
output reg [5:0] countJ = 0;
output reg [5:0] count3 = 0;
output reg [5:0] count4 = 0;
output reg [5:0] count5 = 0;
output reg [5:0] count6 = 0;

/* 
R Instructions (ALU)
sll (0x0), srl (0x2), sra (0x3), sllv (0x4), srlv (0x6), 
srav (0x7), jr (0x8), jalr (0x9), mfhi (0x10), mthi (0x11), 
mflo (0x12), mtlo (0x13), mult (0x18), multu (0x19), div (0x1a), 
divu(0x1b), add (0x20), addu (0x21), sub (0x22), subu (0x23), 
and (0x24), xor (0x26), nor (0x27), or (0x25), slt (0x2a), sltu (0x2b) 
*/

/* 
I instructions
Arithmetic instructions: signed immediate operand (addi, addiu, slti) or unsigned immediate operand (sltiu)
– Logical instructions: unsigned immediate operand (andi, ori, xori, lui)
– Branch instructions: PC-relative signed jump offset (beq, bne, blez, bltz, bgtz, bgez)
– Load and store instructions: signed displacement from the base register 
*/

/* 
J Instructions
j or jal 
*/

always @(posedge clk)begin
    #2
    if (instr[31:26] == 0) begin 
        countR <= countR + 1;
        
        // rd -> 15 to 11
        if(instr[15:11] == 3 )
            count3 <= count3 + 1;

        if(instr[15:11] == 4 )
            count4 <= count4 + 1;

        if(instr[15:11] == 5 )
            count5 <= count5 + 1;

        if(instr[15:11] == 6 )
            count6 <= count6 + 1;
    end

    else if(instr[31:26] != 2 && instr[31:26] != 3) begin
        countI <= countI + 1;

        if(instr[20:16] == 3 )
            count3 <= count3 + 1;

        if(instr[20:16] == 4 )
            count4 <= count4 + 1;

        if(instr[20:16] == 5 )
            count5 <= count5 + 1;

        if(instr[20:16] == 6 )
            count6 <= count6 + 1;
    end

    else 
        countJ <= countJ + 1;

end 

endmodule