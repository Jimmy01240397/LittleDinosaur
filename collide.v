module collide(reset, gamedata, collide);

input reset;
input [`datalen * `datacount - 1:0] gamedata;
output reg collide;

reg collideX, collideY;
integer i;

reg [`datalen - 1:0] data [`datacount - 1:0];

always
begin
	if(!reset)
	begin
		collide = 0;
	end
	else
	begin
		for(i = 0; i < `datacount; i = i + 1)
		begin
			data[i] = gamedata[i * `datalen +: `datalen];
		end
		
		if(data[0][`datatypestart +: `datatypelen] == `playertype)
		begin
			for(i = 1; i < `datacount; i = i + 1)
			begin
				if(!collide && data[i][`datatypestart +: `datatypelen] == `enemytype)
				begin
					// p.x+p.width<e.x or e.x+e.width<p.x => X not collide
					
					collideX = !(
										 ((data[0][`dataxstart +: `dataxlen] + data[0][`datawidthstart +: `datawidthlen]) < data[i][`dataxstart +: `dataxlen])
									 || ((data[i][`dataxstart +: `dataxlen] + data[i][`datawidthstart +: `datawidthlen]) < data[0][`dataxstart +: `dataxlen])
									 );
									
					// p.y+p.height<e.y or e.y+e.height<p.y => Y not collide
					collideY = !(
										 ((data[0][`dataystart +: `dataylen] + data[0][`dataheightstart +: `dataheightlen]) < data[i][`dataystart +: `dataylen])
									 || ((data[i][`dataystart +: `dataylen] + data[i][`dataheightstart +: `dataheightlen]) < data[0][`dataystart +: `dataylen])
									 );
					collide = (collideX & collideY);
				end
			end
		end
		else
		begin
			collide = 0;
		end
	end
end
endmodule
