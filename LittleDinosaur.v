`include "define.v"

module LittleDinosaur(clock, rst, jump, seven1, seven2, dot_col, dot_row, vga);
input clock, rst, jump;

output [6:0]seven1, seven2;
output [7:0]dot_col, dot_row; 
output [13:0] vga;

reg start = 0;

wire [`datalen*`datacount-1:0] gamedata;
wire [`imagecount*`imagewidth*`imageheight-1:0]image;
wire clk1, clk2, clk3;
wire collide;
wire [`scorelen-1 : 0] score;
wire [`randomNUMlen*`randomCount-1:0] randoms;

always@(negedge rst or negedge jump)
begin
	if(!rst)
	begin
		start <= 0;
	end
	else
	begin
		start <= 1;
	end
end


Freq_Div(.clock(clock), .clk1(clk1), .clk2(clk2), .clk3(clk3));
readImage(.image(image));
random(.clock(clk3), .reset(rst), .start(start), .randoms(randoms));

collide(.reset(rst), .gamedata(gamedata), .collide(collide));

ground(.clk3(clk3), .reset(rst), .pause(collide), .start(start), .ground(gamedata[0 * `datalen +: `datalen]));

update_player(.clk3(clk3), .reset(rst), .pause(collide), .start(start), .jump(jump), .player(gamedata[1 * `datalen +: `datalen]));
enemy(.clk3(clk3), .reset(rst), .pause(collide), .start(start), .randoms(randoms), .gamedata(gamedata[2 * `datalen +: `enemymaxcount * `datalen]));

calc_score(.clk3(clk3), .reset(rst), .pause(collide), .start(start), .score(score));

display(.clock(clk1), .reset(rst), .image(image), .gamedata(gamedata), .vga(vga));
score(.clk2(clk2), .score(score), .seven1(seven1), .seven2(seven2), .dot_col(dot_col), .dot_row(dot_row));

endmodule 
