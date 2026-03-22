`timescale 1ns / 1ps



module decrement(
input [7:0] in1,
output [7:0] out,
output reg [4:0] flags
);
wire [7:0] subtractionresult;
wire couttemp;
subberfordec dec (.in1(in1),.in2(~(8'b0000_0000)),.cin(~(1'b1)),.out(subtractionresult),.cout(couttemp)); // better than adding the number 1 as no propogation needs to occur 
assign out = subtractionresult;
always @ (*) begin
    if (out == 8'b0000_0000) begin
        flags[3] = 1'b1;    
    end
    else begin
        flags[3] = 1'b0;
    end
    flags[4] = couttemp;
    flags[2] = 1'b0;
    flags[1] = 1'b0;
    flags[0] = ^out;
end
endmodule

module subberfordec (
input [7:0] in1,in2,
input cin,
output [7:0] out,
output cout
);
wire [8:0] C ;
assign C[0] = cin;
genvar i;
generate 
    for (i = 0; i < 8; i = i+1) begin : generationblock
adder1b fda(.a(in1[i]),.b(in2[i]),.cin(C[i]),.y(out[i]),.g(),.p(),.cout());
assign C[i+1] = (C[i] | in1[i]);
end
endgenerate
assign cout = C[8];
endmodule















module subwithborrow(
input [7:0] in1,in2,
input bin,
output reg [7:0] out,
output reg [4:0] flags
);
wire [7:0] invertedin2;
wire tocheckcout,iffinalcout;
wire [7:0] middleout, finalout,toholdout;
wire [7:0] invertedcarryoutput;
onescomp invert1(.in1(in2),.out(invertedin2));
adderforsub asub (.in1(in1),.in2(invertedin2),.cin(~bin),.out(middleout),.cout(tocheckcout));

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














module increment(
input [7:0] in1,
output [7:0] out,
output reg [4:0] flags
);
wire [7:0] additionresult;
wire couttemp;
adderforinc inc (.in1(in1),.in2(8'b0000_0000),.cin(1'b1),.out(additionresult),.cout(couttemp)); // better than adding the number 1 as no propogation needs to occur 
assign out = additionresult;
always @ (*) begin
    if (out == 8'b0000_0000) begin
        flags[3] = 1'b1;    
    end
    else begin
        flags[3] = 1'b0;
    end
    flags[4] = couttemp;
    flags[2] = 1'b0;
    flags[1] = 1'b0;
    flags[0] = ^out;
end
endmodule

module adderforinc (
input [7:0] in1,in2,
input cin,
output [7:0] out,
output cout
);
wire [7:0] P ;
wire [8:0] C ;
assign C[0] = cin;
genvar i;
generate 
    for (i = 0; i < 8; i = i+1) begin : generationblock
adder1b fda(.a(in1[i]),.b(in2[i]),.cin(C[i]),.y(out[i]),.g(),.p(P[i]),.cout());
assign C[i+1] = (C[i] & P[i]);
end
endgenerate
assign cout = C[8];
endmodule









module sub(
input [7:0] in1,in2,
output reg [7:0] out,
output reg [4:0] flags
);
wire [7:0] invertedin2;
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
