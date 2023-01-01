`include "define.v"

module LittleDinosaur(clock, rst, jump, vga);
input clock, rst, jump;

//output [6:0]seven;
output [13:0] vga;

wire [`datalen*`datacount-1:0] gamedata;
wire [`imagecount*`imagewidth*`imageheight-1:0]image;
wire clk1, clk2, clk3;
wire collide;
wire [`scorelen : 0] score;

//wire [3:0] test;

Freq_Div(.clock(clock), .clk1(clk1), .clk2(clk2), .clk3(clk3));
readImage(.clock(clock), .image(image));

update_player(.clk3(clk3), .reset(rst), .pause(collide), .jump(jump), .player(gamedata[0 +: `datalen]));

enemy(.clk3(clk3), .reset(rst), .pause(collide), .gamedata(gamedata[1*`datalen +: (`datacount - 1)* `datalen]));

calc_score(.clk3(clk3), .reset(rst), .pause(collide), .score(score));
collide(.clk3(clk3), .gamedata(gamedata), .collide(collide));

display(.clock(clk1), .reset(rst), .image(image), .gamedata(gamedata), .vga(vga));

endmodule 
