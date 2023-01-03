`include "define.v"
module update_player(clk3,reset,pause,start,jump,player);
input clk3, reset, pause, start, jump;
output reg [`datalen - 1:0] player;
reg floating = 0;
reg jumped = 1;
reg clk3ed = 0;
reg [30:0] count;
integer index;

always
begin
	if(start)
	begin
		player[`dataxstart +: `dataxlen]=`playerxPos;//player_position_x
		player[`datawidthstart +: `datawidthlen]=`playerwidth;//player_width
		player[`dataheightstart +: `dataheightlen]=`playerheight;//player_height
		
		if(count < (`gameHz * `jumpDuration / 4))
			player[`dataystart +: `dataylen]=`playeryPos - (`playerFloatingMax / (`gameHz * `jumpDuration / 4) * count);//player_position_y
		else if (count > (`gameHz * `jumpDuration / 4 * 3))
			player[`dataystart +: `dataylen]=`playeryPos - `playerFloatingMax + (`playerFloatingMax / (`gameHz * `jumpDuration / 4) * (count - (`gameHz * `jumpDuration / 4 * 3)));//player_position_y
		else
			player[`dataystart +: `dataylen]=`playeryPos - `playerFloatingMax;
	end
	else
	begin
		player[`dataxstart +: `dataxlen]=`titlexPos;//title_position_x
		player[`dataystart +: `dataylen]=`titleyPos;//title_position_y
		player[`datawidthstart +: `datawidthlen]=`titlewidth;//title_width
		player[`dataheightstart +: `dataheightlen]=`titleheight;//title_height
	end
end

always@(posedge clk3 or negedge reset)
begin
	if(!reset)
	begin
		index <= 0;
		floating <= 0;
		count <= 0;
		jumped <= jump;
	end
	else 
	begin
		if(!pause && start)
		begin
			if(!jump && jumped != jump && !floating)
			begin
				floating <= 1;
				count <= 0;
			end
			else if(jump && jumped != jump && floating && count <= (`gameHz * `jumpDuration / 4 * 3))
			begin
				floating <= floating;
				count <= (`gameHz * `jumpDuration / 4 * 3);
			end
			else if(floating)
			begin 
				// floating count
				if(count >= (`gameHz * `jumpDuration))
				begin
					floating <= 0;
					count <= 0;
				end
				else
				begin
					floating <= floating;
					count <= count+1;
				end
			end
			else
			begin
				floating <= floating;
				count <= count;
			end
			player[`datatypestart +: `datatypelen]<=(`playerstartindex + (index / `playerimageaddperiod)); //object type
			index <= (index + 1) % ((`playerendindex - `playerstartindex + 1) * `playerimageaddperiod);
		end
		else
		begin
			if(!start)
			begin
				player[`datatypestart +: `datatypelen]<=`titletype; //object type
			end
			else
			begin
				player[`datatypestart +: `datatypelen]<=player[`datatypestart +: `datatypelen]; //object type
			end
			index <= index;
			floating <= floating;
			count <= count;
		end
		jumped <= jump;
	end
end
endmodule 