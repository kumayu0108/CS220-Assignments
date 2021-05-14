module top;
	reg clk;
	wire [7:0]result_val;
    wire check;
    res uut(clk, result_val, check);
	
	always @(posedge clk) begin
        #2
        if (check==1) begin
			$display("e =%d",result_val);
			$finish;
        end
	end

	initial begin
		forever begin
			clk=0;
			#5
			clk=1;
			#5
			clk=0;
		end
	end

endmodule