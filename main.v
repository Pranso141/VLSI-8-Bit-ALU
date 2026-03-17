`timescale 1ns / 1ps


module main(
input [7:0] in1,in2,
input [3:0] sel,
output reg [7:0] out,
output reg [4:0] flags
    );
    
    wire [7:0] caseresult[13:0];
    wire [4:0] caseflags[13:0];
    cla8b case1 (.in1(in1),.in2(in2),.cin(1'b0),.out(caseresult[0]),.flags(caseflags[0]));
    cla8b case2 (.in1(in1),.in2(in2),.cin(1'b1),.out(caseresult[1]),.flags(caseflags[1]));
    
    
    twoscomp case5 (.in1(in1),.out(caseresult[4]),.flags(caseflags[4]));
    always @ (*)
    begin
    case (sel) 
    4'b0000 : begin  out = caseresult[0]; flags = caseflags[0]; end
    4'b0001 : begin  out = caseresult[1]; flags = caseflags[1]; end
    4'b0010 : ;
    4'b0011 : ;
    4'b0100 : begin  out = caseresult[4]; flags = caseflags[4]; end
    
    endcase
    end
    
endmodule

module sub();

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
output wire [7:0] out,
output reg [4:0] flags
);
onescomp one(.in1(in1),.out(out));
assign out = out + 1'b1;
always @ (*) begin
flags = 5'b00000;
if (out == 8'b0000_0000) begin
flags[3] = 1'b1;
end
flags[0] = ^out;
{flags[4],flags[2],flags[1]} = {3{1'b0}};
end

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
always @ (*)
begin
flags = 0;
if (C[8] == 1'b1) 
begin 
flags[4] = 1'b1;
end
if (out == 8'b00000000) begin
flags[3] = 1'b0;
end
{flags[2],flags[1]} = {2{1'b0}};
flags[0] = ^out;
end
endmodule
