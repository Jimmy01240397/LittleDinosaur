`include "define.v"
module update_player(clk3,jump,player);
input jump;
input clk3;
output [43:0] player;
reg [9:0] count;
reg [43:0] player;
reg floating = 0;
always@(posedge jump or posedge clk3)
begin
	player[0:3]=4'b1111; //object type
	player[4:13]=`playerxPos;//player_position_x
	player[14:23]=`playeryPos;//player_position_y
	player[24:33]=`imagewidth;//player_width
	player[34:43]=`imageheight;//player_height
	if(floating)
	begin
		count=count+10'd1;
	end
	if(jump)
	begin
		if(!floating)
		begin
			floating<=1;
			player[14:23]<=`playerFloatingPos;
		end
	end
	if(count>=120)
	begin
		floating<=0;
		player[14:23]<=`playeryPos;
	end
end
endmodule