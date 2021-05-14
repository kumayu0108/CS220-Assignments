module fsm(inp, clk, z);
    
    input inp;
    input clk;
    reg m = 0, n = 0, o = 0, M = 0, N = 0, O = 0;

    output z;
    wire z;
    assign z = (~m & o & inp) | (~m & n & ~o & ~inp) | (m & ~n & ~o & ~inp) | (~m & ~n & ~o & ~inp);  

    always @(posedge clk) begin   
        m <= (~n & o) | (~m & n & ~o & inp) | (~m & n & o) | (m & ~n & ~o & inp);
        n <= (~m & ~n & ~o & inp) | (~m & n & ~o & ~inp) | (m & ~n & ~o & ~inp);
        o <= (~m & ~n & ~inp) | (~m & n & ~o) | (~m & n & o & ~inp) | (m & ~n);
    end
    
endmodule