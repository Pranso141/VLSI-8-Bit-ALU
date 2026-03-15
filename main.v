module adder1b (
input a,b,cin,
output y,g,p,cout
);
assign y = a ^ b ^ cin;
assign g = a & b;
assign p = a | b;
assign cout = (a & b) | (b & cin) | (a & cin);
endmodule


module cla8b (
input [7:0] in1,in2,
input cin,
output [7:0] out,
output cout
);
wire [7:0] G ;
wire [7:0] P ;
wire [8:0] C ;
assign C[0] = cin;
genvar i;
generate 
for (i = 0; i < 8; i = i+1) begin  
adder1b fda(.a(in1[i]),.b(in2[i]),.cin(C[i]),.y(out[i]),.g(G[i]),.p(P[i]),.cout());
assign C[i+1] = (C[i] & P[i]) | G[i];
end
endgenerate
assign cout = C[8];
endmodule
