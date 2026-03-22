`timescale 1ns / 1ps

module and_gate(
input [7:0] in1,in2,
output wire [7:0] out,
output reg [4:0] flags
);
assign out = in1 & in2;
always @ (*) begin
    flags[4] = 1'b0;
    if (out == 8'b0000_0000) begin
        flags[3] = 1'b1;
    end
    else begin
        flags[3] = 1'b0;
    end
    flags[2] = 1'b0;
    flags[1] = 1'b0;
    flags[0] = ^out;
end
endmodule

module or_gate(
input [7:0] in1,in2,
output wire [7:0] out,
output reg [4:0] flags
);
assign out = in1 | in2;
always @ (*) begin
    flags[4] = 1'b0;
    if (out == 8'b0000_0000) begin
        flags[3] = 1'b1;
    end
    else begin
        flags[3] = 1'b0;
    end
    flags[2] = 1'b0;
    flags[1] = 1'b0;
    flags[0] = ^out;
end
endmodule

module xor_gate(
input [7:0] in1,in2,
output wire [7:0] out,
output reg [4:0] flags
);
assign out = in1 ^ in2;
always @ (*) begin
    flags[4] = 1'b0;
    if (out == 8'b0000_0000) begin
        flags[3] = 1'b1;
    end
    else begin
        flags[3] = 1'b0;
    end
    flags[2] = 1'b0;
    flags[1] = 1'b0;
    flags[0] = ^out;
end
endmodule
