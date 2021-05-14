module returnmin(a, b, c, d, minidx);

input [2:0] a, b, c, d;

output [1:0] minidx;
reg [1:0] minidx;

always@(a, b, c, d) begin
	if(a < b) begin
		if(a < c) begin
			if(a < d) minidx <= 0;
			else minidx <= 3;
		end
		else begin
			if(c < d) minidx <= 2;
			else minidx <= 3;
		end
	end
	else begin
		if(b < c) begin
			if(b < d) minidx <= 1;
			else minidx <= 3;
		end
		else begin
			if(c < d) minidx <= 2;
			else minidx <= 3;
		end
	end
end
endmodule