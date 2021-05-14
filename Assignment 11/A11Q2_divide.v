module divider(clk, inp, dnd, dsr, dnd_len, dsr_len, quo, rmdr, count_add, count_sub, done);

input clk;
input inp;
input [4:0] dnd_len; // dnd length
input [4:0] dsr_len; // sr length 
input [31:0] dnd;
input [31:0] dsr;

output done;
output [31:0] quo;
output [31:0] count_add;
output [31:0] count_sub;
output signed [31:0] rmdr;

reg done;
reg [4:0] itr;
reg [31:0] quo;
reg [31:0] dsr_new;
reg [31:0] count_add;
reg [31:0] count_sub; 
reg signed [31:0] rmdr;


initial begin
#1
done <= 1;
end

always @(posedge clk) begin

  if(dnd_len < dsr_len) begin      // IF bits of dnd is less than dsr 
      rmdr <= dnd;
      quo <= 0;
      itr <= 0;
      count_add <= 0;
      count_sub <= 0;
      done <= 1;
  end


  else begin

  if (inp==1) begin
    rmdr <= dnd;
    quo <= 0;
    itr <= 0;
    count_add <= 0;
    count_sub <= 0;
    dsr_new  <=  dsr << (dnd_len - dsr_len);
    done <= 0;
  end

  else begin

      if(rmdr >= 0) begin
          quo = (quo<<1)|1;
          rmdr = rmdr - dsr_new;
          count_sub = count_sub + 1;
      end

      else begin
          quo = quo ^ 1'b1;
          quo = (quo << 1) | 1;
          rmdr = rmdr + dsr_new;
          count_add = count_add + 1;
      end

      itr = itr + 1;
      dsr_new = dsr_new >> 1;

      if(itr == (dnd_len - dsr_len + 1) ) begin

        if(rmdr >= 0) done = 1;
      
        else begin
          done = 1;
          rmdr = rmdr + dsr;
          quo = quo ^ 1'b1;
          count_add = count_add + 1;
        end

      end

      else begin
          done <= 0;
      end  

    end
end

end


endmodule
