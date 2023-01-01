`include "define.v"
module update_player(clk3,reset,pause,jump,player);
input clk3, reset, pause, jump;
output reg [`datalen - 1:0] player;
reg floating = 0;

integer count;
always@(negedge jump or posedge clk3 or negedge reset or negedge pause)
begin
	if(!pause)
	begin
		if(!reset || !jump || clk3)
		begin
			player[`datatypestart +: `datatypelen]<=`playertype; //object type
			player[`dataxstart +: `dataxlen]<=`playerxPos;//player_position_x
			player[`datawidthstart +: `datawidthlen]<=`playerwidth;//player_width
			player[`dataheightstart +: `dataheightlen]<=`playerheight;//player_height
		end
		
		if(!reset)
		begin
			floating <= 0;
			count = 0;
		end
		else if(!jump)
		begin
			if(!floating)
			begin
				floating <= 1;
				count = 0;
			end
		end
		
		if(clk3)
		begin
			if(floating)
			begin
				count=count+10'd1;
				if(count>=`gameHz*`jumpDuration)
				begin
					floating<=0;
					count = 0;
				end
			end
		end
		
		if(!reset || !jump || clk3)
		begin
			if(floating)
				player[`dataystart +: `dataylen]<=`playerFloatingPos;//jump
			else
				player[`dataystart +: `dataylen]<=`playeryPos;//player_position_y
		end
	end
end
endmodule 