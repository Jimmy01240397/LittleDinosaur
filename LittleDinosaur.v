`include "define.v"

module LittleDinosaur(clock, rst, vga);
input clock, rst;

//output [6:0]seven;
output [13:0]vga;

reg [`datalen*`datacount-1:0] gamedata;
wire [`imagecount*`imagewidth*`imageheight-1:0]image;
wire clk1, clk2, clk3;

//wire [3:0] test;

Freq_Div(.clock(clock), .clk1(clk1), .clk2(clk2), .clk3(clk3));

readImage(.clock(clock), .image(image));

always@(posedge clock)
begin
	gamedata[0*`datalen+`datatypestart +: `datatypelen] = 1;
	gamedata[0*`datalen+`dataxstart +: `dataxlen] = 10;
	gamedata[0*`datalen+`dataystart +: `dataylen] = 400;
	gamedata[0*`datalen+`datawidthstart +: `datawidthlen] = 40;
	gamedata[0*`datalen+`dataheigthstart +: `dataheigthlen] = 80;
	
	gamedata[1*`datalen+`datatypestart +: `datatypelen] = 2;
	gamedata[1*`datalen+`dataxstart +: `dataxlen] = 300;
	gamedata[1*`datalen+`dataystart +: `dataylen] = 150;
	gamedata[1*`datalen+`datawidthstart +: `datawidthlen] = 40;
	gamedata[1*`datalen+`dataheigthstart +: `dataheigthlen] = 80;
	
	gamedata[2*`datalen+`datatypestart +: `datatypelen] = 0;
end

//sevenDisplay(.test(test), .out(seven));

display(.clock(clk1), .reset(rst), .image(image), .gamedata(gamedata), .vga(vga));


endmodule 