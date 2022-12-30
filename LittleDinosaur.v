`include "define.v"

module LittleDinosaur(clock, rst, vga);
input clock, rst;

//output [6:0]seven;
output [13:0]vga;

reg [`datalen*`datacount-1:0] gamedata;
wire [`imagecount*`imagewidth*`imageheight-1:0]image;
wire clk1, clk2, clk3;
wire togenerate;

//wire [3:0] test;

Freq_Div(.clock(clock), .clk1(clk1), .clk2(clk2), .clk3(clk3));
check_gen_enemy(.clk3(clk3), .reset(rst), .togenerate(togenerate));


endmodule 