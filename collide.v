module collide(reset, gamedata, collide);

input reset;
input [`datalen * `datacount - 1:0] gamedata;
output reg collide;

reg collideX, collideY;
integer i,playerindex;

reg [`datalen - 1:0] data [`datacount - 1:0];

always
begin
	if(!reset)
	begin
		collide = 0;
	end
	else
	begin
		playerindex = 0;
		for(i = 0; i < `datacount; i = i + 1)
		begin
			data[i] = gamedata[i * `datalen +: `datalen];
			if(data[i][`datatypestart +: `datatypelen] >= `playerstartindex && data[i][`datatypestart +: `datatypelen] <= `playerendindex)
			begin
				playerindex = i;
			end
		end
		
		collide = 0;
		if(data[playerindex][`datatypestart +: `datatypelen] >= `playerstartindex && data[playerindex][`datatypestart +: `datatypelen] <= `playerendindex)
		begin
			for(i = 0; i < `datacount; i = i + 1)
			begin
				if(!collide && data[i][`datatypestart +: `datatypelen] == `enemytype)
				begin
					// p.x+p.width<e.x or e.x+e.width<p.x => X not collide
					
					collideX = !(
										 ((data[playerindex][`dataxstart +: `dataxlen] + data[playerindex][`datawidthstart +: `datawidthlen]) < data[i][`dataxstart +: `dataxlen])
									 || ((data[i][`dataxstart +: `dataxlen] + data[i][`datawidthstart +: `datawidthlen]) < data[playerindex][`dataxstart +: `dataxlen])
									 );
									
					// p.y+p.height<e.y or e.y+e.height<p.y => Y not collide
					collideY = !(
										 ((data[playerindex][`dataystart +: `dataylen] + data[playerindex][`dataheightstart +: `dataheightlen]) < data[i][`dataystart +: `dataylen])
									 || ((data[i][`dataystart +: `dataylen] + data[i][`dataheightstart +: `dataheightlen]) < data[playerindex][`dataystart +: `dataylen])
									 );
					collide = (collideX & collideY);
				end
			end
		end
	end
end
endmodule
