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

module rotator (
input [7:0] in1,
input dir,
output [7:0] out,
output reg [4:0] flags
);
reg [7:0] midout;
always @ (*) begin
    if (dir == 1'b1)
        begin
            midout = {in1[0], in1[7:1]};
        end
     else
        begin
            midout = {in1[6:0],in1[7]};
        end
    end
assign out = midout;

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

module rotator_carry (
input [7:0] in1,
input dir,cin,  
output [7:0] out,
output reg [4:0] flags
);
wire [8:0] in_c;
reg [8:0] middlestate,midout;
assign in_c = {cin,in1[7:0]};
always @ (*) begin
    if (dir == 1'b1)
        begin
            middlestate = in_c >> 1;
            midout = {in1[0],middlestate[7:0]};
        end
     else
        begin
            middlestate = in_c << 1;
            midout = {middlestate[8:1],cin};  
        end
    end
assign out = midout[7:0];

    always @ (*)
        begin
           flags[4] = midout[8];
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
