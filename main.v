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
              sub case3 (.in1(in1),.in2(in2),.out(caseresult[2]),.flags(caseflags[2])); 
    subwithborrow case4 (.in1(in1),.in2(in2),.bin(1'b1),.out(caseresult[3]),.flags(caseflags[3]));
         twoscomp case5 (.in1(in1),.out(caseresult[4]),.flags(caseflags[4]));
        increment case6 (.in1(in1),.out(caseresult[5]),.flags(caseflags[5]));
        decrement case7 (.in1(in1),.out(caseresult[6]),.flags(caseflags[6]));
    always @ (*)
    begin
    case (sel) 
    4'b0000 : begin  out = caseresult[0]; flags = caseflags[0]; end
    4'b0001 : begin  out = caseresult[1]; flags = caseflags[1]; end
    4'b0010 : begin  out = caseresult[2]; flags = caseflags[2]; end
    4'b0011 : begin  out = caseresult[3]; flags = caseflags[3]; end
    4'b0100 : begin  out = caseresult[4]; flags = caseflags[4]; end
    4'b0101:  begin  out = caseresult[5]; flags = caseflags[5]; end
    4'b0110:  begin  out = caseresult[6]; flags = caseflags[6]; end
    4'b0111: ;
    4'b1000: ;
    4'b1001: ;
    4'b1010: ;
    4'b1011: ;
    4'b1100: ;
    4'b1101: ;
    default: ;
    endcase
    end
    
endmodule
