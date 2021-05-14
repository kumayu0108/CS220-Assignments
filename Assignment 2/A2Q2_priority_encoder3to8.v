module priority_encoder3to8(in, out);

    input [7:0] in; 
    output [2:0] out;
    wire [2:0] out; 

    assign out[2] = ~in[0] & ~in[1] & ~in[2] & ~in[3]; 
    assign out[1] = ~in[0] & ~in[1] & (in[2] | in[3] | (~in[4] & ~in[5]));  
    assign out[0] = ~in[0] & (in[1] | (~in[2] & in[3]) | (~in[2] & ~in[4] & in[5]) | (~in[2] & ~in[4] & ~in[6] & in[7])); 

endmodule
