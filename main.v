`timescale 1ns / 1ps


module main(
input [7:0] in1,in2,
input [3:0] sel,
output reg [7:0] out,
output reg [4:0] flags
    );
    
    wire [7:0] case1result,case2result,case3result,case4result,case5result;
    wire [4:0] case1flags,case2flags,case3flags,case4flags,case5flags;
    cla8b case1 (.in1(in1),.in2(in2),.cin(1'b0),.out(case1result),.flags(case1flags));
    cla8b case2 (.in1(in1),.in2(in2),.cin(1'b1),.out(case2result),.flags(case2flags));
    
    always @ (*)
    begin
    case (sel) 
    4'b0000 : begin  out = case1result; flags = case1flags; end
    4'b0001 : begin  out = case2result; flags = case2flags; end
    4'b0010 : ;
    4'b0011 : ;
    4'b0100 : begin  out = case5result; flags = case5flags; end
    
    endcase
    end
    
endmodule

//module that inverts all the bits and is the ones complement
module onescomp(
input [7:0] in1,
output [7:0] out
);
assign out = ~in1;

endmodule
//module that does two's complement of the input 
module twoscomp (
input [7:0] in1,
output [7:0] out
);
onescomp one(.in1(in1),.out(out));
assign out = out + 1'b1;

endmodule


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
output reg [4:0] flags
);
wire [7:0] G ;
wire [7:0] P ;
wire [8:0] C ;
assign C[0] = cin;
genvar i;
generate 
    for (i = 0; i < 8; i = i+1) begin : generationblock
adder1b fda(.a(in1[i]),.b(in2[i]),.cin(C[i]),.y(out[i]),.g(G[i]),.p(P[i]),.cout());
assign C[i+1] = (C[i] & P[i]) | G[i];
end
endgenerate
assign cout = C[8];

always @ (*)
begin
if (C[8] == 1'b1) 
begin 
flags[4] = 1'b1;
end
else if (out == 8'b00000000) begin
flags[3] = 1'b0;
end
else if ()
end
endmodule
