module read(clock, input_row, input_valid, output_row, output_valid);

    reg [31:0] r [15:0]; 
    input clock; 
    input [4:0] input_row;
    input input_valid; 

    output [31:0] output_row;
    reg [31:0] output_row;

    output output_valid; 
    reg output_valid; 

    reg [5:0] open_row;  

    reg [1:0] count; 

    always @(posedge clock) begin
    if (input_valid == 1 && count == 0) begin
        if (open_row == 16) begin
          count <= count + 1; 
          output_valid <= 0;          
        end
          
        else if (open_row != input_row && count == 0) begin
          count <= count + 1; 
          output_valid <= 0; 
        end

        else if (open_row == input_row) begin
          output_valid = 0;
          output_valid <= 1;
          open_row <= input_row; 
          output_row <= r[input_row];
        end
    end
    else if (input_valid == 0) begin
        output_valid <= 0;
        if (open_row == 16 && count == 1) begin
          count <= 0; 
          output_valid <= 1;
          open_row <= input_row; 
          output_row <= r[input_row]; 
        end

        else if (open_row != input_row && count == 1) begin
          count <= count + 1; 
          output_valid <= 0; 
        end

        else if (open_row != input_row && count == 2) begin
          count <= 0; 
          output_valid <= 1;
          open_row <= input_row; 
          output_row <= r[input_row]; 
        end
    end
    end

    initial begin
        r[0] <= 0;
        r[1] <= 1;
        r[2] <= 2;
        r[3] <= 3;
        r[4] <= 4;
        r[5] <= 5;
        r[6] <= 6;
        r[7] <= 7;
        r[8] <= 8;
        r[9] <= 9;
        r[10] <= 10;
        r[11] <= 11;
        r[12] <= 12;
        r[13] <= 13;
        r[14] <= 14;
        r[15] <= 15;
        open_row <= 16; 
        output_valid <= 0; 
        count <= 0;
    end

endmodule