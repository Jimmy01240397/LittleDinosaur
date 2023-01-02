`include "define.v"

module LittleDinosaur(clock, rst, jump, seven1, seven2, dot_col, dot_row, vga, test, test2);
input clock, rst, jump;

output reg [7*6-1:0]seven1;//, seven2;
output reg [6:0]seven2;
output [7:0]dot_col, dot_row; 
output [13:0] vga;
output test,test2;

reg start = 0;

wire [`datalen*`datacount-1:0] gamedata;
wire [`imagecount*`imagewidth*`imageheight-1:0]image;
wire clk1, clk2, clk3;
wire collide;
wire [`scorelen : 0] score;
wire [`randomNUMlen*`randomCount-1:0] randoms;
wire [`randomNUMlen * (1<<`randomNUMlen) * 2 - 1:0] testlist;

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

assign test = jump;

//wire [3:0] test;

Freq_Div(.clock(clock), .clk1(clk1), .clk2(clk2), .clk3(clk3));
readImage(.image(image));
random(.clock(clk3), .reset(rst), .start(start), .randoms(randoms), .testlist(testlist));

integer i;

/*always
begin
	//case(randoms[0*`randomNUMlen +: `randomNUMlen] % 16)
	for(i = 0; i < 6; i = i + 1)
	begin
		case(testlist[i*`randomNUMlen +: `randomNUMlen])
			0:seven1[i * 7 +: 7]=7'b1000000;
			1:seven1[i * 7 +: 7]=7'b1111001;
			2:seven1[i * 7 +: 7]=7'b0100100;
			3:seven1[i * 7 +: 7]=7'b0110000;
			4:seven1[i * 7 +: 7]=7'b0011001;
			5:seven1[i * 7 +: 7]=7'b0010010;
			6:seven1[i * 7 +: 7]=7'b0000010;
			7:seven1[i * 7 +: 7]=7'b1111000;
			8:seven1[i * 7 +: 7]=7'b0000000;
			9:seven1[i * 7 +: 7]=7'b0011000;
			10:seven1[i * 7 +: 7]=7'b0001000;
			11:seven1[i * 7 +: 7]=7'b0000011;
			12:seven1[i * 7 +: 7]=7'b1000110;
			13:seven1[i * 7 +: 7]=7'b0100001;
			14:seven1[i * 7 +: 7]=7'b0000110;
			15:seven1[i * 7 +: 7]=7'b0001110;
			default:seven1[i * 7 +: 7]=7'b1111111;
		endcase
	end
end*/


collide(.reset(rst), .gamedata(gamedata), .collide(collide));

update_player(.clk3(clk3), .reset(rst), .pause(collide), .start(start), .jump(jump), .player(gamedata[0 +: `datalen]), .test(test2));
enemy(.clk3(clk3), .reset(rst), .pause(collide), .start(start), .gamedata(gamedata[1*`datalen +: (`datacount - 1)* `datalen]));

calc_score(.clk3(clk3), .reset(rst), .pause(collide), .start(start), .score(score));

display(.clock(clk1), .reset(rst), .image(image), .gamedata(gamedata), .vga(vga));
score(.clk2(clk2), .reset(rst), .score(score), .seven1(seven1), .seven2(seven2), .dot_col(dot_col), .dot_row(dot_row));

endmodule 
