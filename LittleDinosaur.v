`include "define.v"

module LittleDinosaur(clock, rst, vga);
`include "readImage.v"
input clock, rst;

output reg [14:0]vga;

wire [`imagecount*`imagewidth*`imageheight-1:0]image;
wire [(`datatypelen+`dataxlen+`dataylen+`datawidthlen+`dataheigthlen)*`datacount-1:0] gamedata;
wire clk1, clk2, clk3;

initial
begin
	readImage(image);
end

Freq_Div(.clock(clock), .clk1(clk1), .clk2(clk2), .clk3(clk3));



display(.clock(clk1), .reset(rst), .image(image), .gamedata(gamedata), .vga(vga));


endmodule 