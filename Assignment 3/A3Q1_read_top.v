module top;

    reg clock;
    reg [25:0] cycle_count; 
    reg [4:0] input_row; 
    wire [31:0] output_row;
    reg input_valid;

    wire output_valid;

    read uut(clock, input_row, input_valid, output_row, output_valid); 

    always @(posedge output_valid) begin
        if(output_valid == 1) begin
          $display("time:%d, cycle_count:%d, input_row:%d, output_row:%d", $time, cycle_count, input_row, output_row);
        end
    end

    initial begin
        forever begin
            clock = 0;
            #5;
            clock = 1;
            #5;
            clock = 0;
        end
    end


    always @(posedge clock) begin
        cycle_count <= cycle_count + 1;
        if(cycle_count == 30)
            $finish;
    end

    initial begin
        cycle_count = 0; 
        #3; 

        input_valid <= 1; 
        input_row <= 6; 
        #10; 
        input_valid <= 0;
        #20; 

        input_valid <= 1;  
        input_row <= 2; 
        #10; 
        input_valid <= 0;
        #20; 

        input_valid <= 1;  
        input_row <= 3; 
        #10; 
        input_valid <= 0;
        #20; 
        
        input_valid <= 1; 
        input_row <= 3; 
        #10; 
        input_valid <= 0;
        #20; 
        
        input_valid <= 1; 
        input_row <= 3; 
        #10; 
        input_valid <= 0;
        #20;
        
        input_valid <= 1; 
        input_row <= 3; 
        #10; 
        input_valid <= 0;
        #20; 
         
        input_valid <= 1; 
        input_row <= 4; 
        #10; 
        input_valid <= 0;
        #20;
         
        input_valid <= 1; 
        input_row <= 0; 
        #10; 
        input_valid <= 0;
        #20;
         
        input_valid <= 1; 
        input_row <= 7; 
        #10; 
        input_valid <= 0;
        #20;
         
        input_valid <= 1; 
        input_row <= 1; 
        #10; 
        input_valid <= 0;
        #20;

    end

endmodule