module grid (clock, dir, dist, x, y);

    input clock;
    input [1:0] dir; 
    input [1:0] dist; 

    output [3:0] x;
    output [3:0] y;
    reg [3:0] x;
    reg [3:0] y;

    wire [4:0] x_final;
    wire [4:0] y_final;
    wire c_out;
    

    five_bit_adder uut (x, y, dir, dist, x_final, y_final, c_out);

    initial begin
        x = 4'b0000;
        y = 4'b0000;
    end
    
    // if 4th bit is 1, either we have gone more than 15 or less than 0
    always @(posedge clock) begin

        // East
        if (dir == 2'b00) begin
            if (x_final[4] == 0) 
                x <= x_final[3:0];
            else 
                x <= 4'b1111;
        end

        // West
        else if (dir == 2'b01) begin
            if (x_final[4] == 0) 
                x <= x_final[3:0];
            else 
                x <= 4'b0000;
        end

        // North
        else if (dir == 2'b10) begin
            if (y_final[4] == 0) 
                y <= y_final[3:0];
            else 
                y <= 4'b1111;
        end

        // South
        else if (dir == 2'b11) begin
            if (y_final[4] == 0) 
                y <= y_final[3:0];
            else 
                y <= 4'b0000;
        end

    end

endmodule