`include "define.v"

module enemy(clk3, reset, pause, gamedata);
    input clk3, reset, pause;
    inout reg [`datalen * (`datacount - 1) - 1:0] gamedata;
    reg [3:0] i;
    reg [3:0] j;
    wire togenerate;

    check_gen_enemy(clk3, togenerate);
    always@(posedge clk3 or negedge reset or negedge pause)
	 begin
	 if(!pause)
	 begin
		 if(!reset)
		 begin
			 for (j = 0; j < `datacount - 1; j = j + 1)
				begin :loop
						  gamedata[j  *   `datalen + `datatypestart    +: `datatypelen]   <= `nulltype;
				end
		 end
		 else
		 begin
			  for (i = 0; i < `datacount - 1; i = i + 1)
			  begin
					if(gamedata[i*`datalen+`datatypestart +: `datatypelen] == `enemytype)
					begin
						 if (gamedata[i * `datalen + `dataxstart +: `dataxlen] == 0)
						 begin
							  gamedata[i * `datalen + `datatypestart +: `datatypelen] <= 0;
						 end
						 else
						 begin
							  gamedata[i * `datalen + `dataxstart +: `dataxlen] <= gamedata[i * `datalen + `dataxstart +: `dataxlen] - `enemymovementperframe;
						 end
					end
			  end
			  
			if (togenerate)
			begin
				 for (j = 0; j < `datacount - 1; j = j + 1)
					begin :loop
						 if(gamedata[j * `datalen +`datatypestart +: `datatypelen] == `nulltype)
						 begin
							  gamedata[j  *   `datalen + `datatypestart    +: `datatypelen]   <= `enemytype;
							  gamedata[j  *   `datalen + `dataxstart       +: `dataxlen]      <= `screenwidth;
							  gamedata[j  *   `datalen + `dataystart       +: `dataylen]      <= `enemyyPos;
							  gamedata[j  *   `datalen + `datawidthstart   +: `datawidthlen]  <= `enemywidthinit;
							  gamedata[j  *   `datalen + `dataheightstart  +: `dataheightlen] <= `enemyheightinit;
						disable loop;
						 end
					end
				end
			end
		 end
	 end
endmodule
