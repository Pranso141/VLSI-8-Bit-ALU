`timescale 1ns / 1ps

module logical_shift(
input [7:0] in1,
input dir,
output [7:0] out,
output reg [4:0] flags
    );
    reg [7:0] medout;
    always @ (*) begin
    if (dir == 1'b1)
        begin
            medout = in1 >> 1;
        end
     else
        begin
            medout = in1 << 1;
        end
    end
   assign out = medout;

    always @ (*)
        begin
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


