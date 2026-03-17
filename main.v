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
    sub   case3 (.in1(in1),.in2(in2),.out(caseresult[2]),.flags(caseflags[2])); 
    
    twoscomp case5 (.in1(in1),.out(caseresult[4]),.flags(caseflags[4]));
    always @ (*)
    begin
    case (sel) 
    4'b0000 : begin  out = caseresult[0]; flags = caseflags[0]; end
    4'b0001 : begin  out = caseresult[1]; flags = caseflags[1]; end
    4'b0010 : begin  out = caseresult[2]; flags = caseflags[2]; end
    4'b0011 : ;
    4'b0100 : begin  out = caseresult[4]; flags = caseflags[4]; end
    4'b0101: ;
    endcase
    end
    
endmodule

module sub(
input [7:0] in1,in2,
output reg [7:0] out,
output reg [4:0] flags
);
wire [7:0] invertedin1;
wire tocheckcout,iffinalcout;
wire [7:0] middleout, finalout,toholdout;
wire [7:0] invertedcarryoutput;
onescomp invert1(.in1(in2),.out(invertedin2));
adderforsub asub (.in1(in1),.in2(invertedin2),.cin(1'b1),.out(middleout),.cout(tocheckcout));

onescomp invert2 (.in1(middleout),.out(invertedcarryoutput));
adderforsub asub2 (.in1(8'b0000_0000),.in2(invertedcarryoutput),.cin(~tocheckcout),.cout(iffinalcout),.out(toholdout));

always @ (*) begin
if (tocheckcout == 1'b0) begin
out = toholdout;
flags[4] = iffinalcout;
    if (out == 8'b0000_0000) begin
        flags[3] = 1'b1;
    end
    else begin 
        flags[3] = 1'b0;
    end
    flags[2] = 1'b0;
end 
else 
begin
out = middleout;
flags[4] = tocheckcout;
    if (out == 8'b0000_0000) begin
        flags[3] = 1'b1;
    end
    else begin 
        flags[3] = 1'b0;
    end
    flags[2] = 1'b1;
end
flags[1] = 1'b0;
flags[0] = ^out;
end




endmodule

module adderforsub (
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
    for (i = 0; i < 8; i = i+1) begin : generationblock
adder1b fda(.a(in1[i]),.b(in2[i]),.cin(C[i]),.y(out[i]),.g(G[i]),.p(P[i]),.cout());
assign C[i+1] = (C[i] & P[i]) | G[i];
end
endgenerate
assign cout = C[8];
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
wire [7:0] tempout;
onescomp one(.in1(in1),.out(tempout));
assign out = tempout + 1'b1;
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
flags[3] = 1'b1;
end
{flags[2],flags[1]} = {2{1'b0}};
flags[0] = ^out;
end
endmodule
