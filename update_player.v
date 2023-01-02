`include "define.v"
module update_player(clk3,reset,pause,start,jump,player, test);
input clk3, reset, pause, start, jump;
output reg [`datalen - 1:0] player;
reg floating = 0;
reg jumped = 1;
reg clk3ed = 0;
reg [30:0] count;

always
begin
	if(start)
	begin
		player[`datatypestart +: `datatypelen]=`playertype; //object type
		player[`dataxstart +: `dataxlen]=`playerxPos;//player_position_x
		player[`datawidthstart +: `datawidthlen]=`playerwidth;//player_width
		player[`dataheightstart +: `dataheightlen]=`playerheight;//player_height
		if(floating)
			player[`dataystart +: `dataylen]=`playerFloatingPos;//jump
		else
			player[`dataystart +: `dataylen]=`playeryPos;//player_position_y
	end
	else
	begin
		player[`datatypestart +: `datatypelen]=`titletype; //object type
		player[`dataxstart +: `dataxlen]=`titlexPos;//title_position_x
		player[`dataystart +: `dataylen]=`titleyPos;//title_position_y
		player[`datawidthstart +: `datawidthlen]=`titlewidth;//title_width
		player[`dataheightstart +: `dataheightlen]=`titleheight;//title_height
	end
end

output reg test;
//assign test = jumped;

always@(negedge jump or posedge clk3 or negedge reset)
begin
	if(!reset)
	begin
		floating <= 0;
		count <= 0;
	end
	else if(!jump)
	begin
		if(jumped != jump && !pause && start && !floating)
		begin
			floating <= 1;
			count <= 0;
		end
		else if(clk3 && clk3ed != clk3 && floating)
		begin
			if(count>=(`gameHz*`jumpDuration))
			begin
				floating<=0;
				count <= 0;
			end
			else
			begin
				floating<=floating;
				count<=count+1;
			end
			test <= 1;
		end
		else
		begin
			floating <= floating;
			count <= count;
			test <= 0;
		end
	end
	else
	begin
		if(clk3 && clk3ed != clk3 && floating)
		begin
			if(count>=(`gameHz*`jumpDuration))
			begin
				floating<=0;
				count <= 0;
			end
			else
			begin
				floating<=floating;
				count<=count+1;
			end
		end
		else
		begin
			floating <= floating;
			count <= count;
		end
	end
		
	if(!jump || clk3 || !reset)
	begin
		jumped <= jump;
		clk3ed <= clk3;
	end
end
endmodule 