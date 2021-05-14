`include "./A11Q2_divide.v"

module top;

reg clk;
reg inp;
reg [4:0] i;
reg [4:0] dnd_len;
reg [4:0] dsr_len;
reg [31:0] dnd; // dividend
reg [31:0] dsr;  // divisor
reg [31:0] dnd_array [0:9];
reg [31:0] dsr_array [0:9];
reg [4:0] dnd_array_len [0:9];
reg [4:0] dsr_array_len [0:9];


wire done;
wire [31:0] quo;
wire [31:0] count_add;
wire [31:0] count_sub;
wire signed [31:0] rmdr;  // remainder

divider D(clk, inp, dnd, dsr, dnd_len, dsr_len, quo, rmdr, count_add, count_sub, done);


always @(negedge clk) begin
        if(done == 1) begin
          $display("DND:%d DSR:%d QUO:%d RMDR:%d COUNT_ADD:%d COUNT_SUB:%d", dnd, dsr, quo, rmdr, count_add, count_sub);
           dnd <= dnd_array[i];
           dsr <= dsr_array[i];
           dnd_len <= dnd_array_len[i];
           dsr_len <= dsr_array_len[i];
           i <= i+1;
           inp <= 1;

           if(i == 11) $finish;

        end

        else begin
            inp <= 0;
        end
end


initial begin

i = 0;
inp = 1; 
dnd_array[0] = 7 ; dsr_array[0] = 2 ; dnd_array_len[0] = 3 ; dsr_array_len[0] = 2 ; 
dnd_array[1] = 13 ; dsr_array[1] = 8 ; dnd_array_len[1] = 4 ; dsr_array_len[1] = 4 ; 
dnd_array[2] = 32423 ; dsr_array[2] = 6 ; dnd_array_len[2] = 16 ; dsr_array_len[2] = 3 ; 
dnd_array[3] = 10 ; dsr_array[3] = 3 ; dnd_array_len[3] = 4 ; dsr_array_len[3] = 2 ; 
dnd_array[4] = 13 ; dsr_array[4] = 10 ; dnd_array_len[4] = 4 ; dsr_array_len[4] = 4 ; 
dnd_array[5] = 31 ; dsr_array[5] = 145 ; dnd_array_len[5] = 5 ; dsr_array_len[5] = 8 ; 
dnd_array[6] = 200 ; dsr_array[6] = 21 ; dnd_array_len[6] = 8 ; dsr_array_len[6] = 5 ; 
dnd_array[7] = 3453435 ; dsr_array[7] = 2 ; dnd_array_len[7] = 25 ; dsr_array_len[7] = 4 ; 
dnd_array[8] = 0 ; dsr_array[8] = 7 ; dnd_array_len[8] = 1 ; dsr_array_len[8] = 3 ; 
dnd_array[9] = 1 ; dsr_array[9] = 6 ; dnd_array_len[9] = 1 ; dsr_array_len[9] = 2 ; 

end


initial begin
    forever begin
    clk=1;
    #5
    clk=0;
    #5;
    clk=1;
    end 
end

    initial begin
    #1000
    $finish;
    end



endmodule
