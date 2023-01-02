`include "define.v"

module enemy(clk3, reset, pause, start, randoms, gamedata);
    input clk3, reset, pause, start;
	 input [`randomNUMlen*`randomCount-1:0] randoms;
    inout reg [`datalen * (`datacount - 1) - 1:0] gamedata;
    integer i;
	 reg generated;

    always@(posedge clk3 or negedge reset)
	 begin
		 if(!reset)
		 begin
			 for (i = 0; i < `datacount - 1; i = i + 1)
			 begin :loop
				 gamedata[i  *   `datalen + `datatypestart    +: `datatypelen]   <= `nulltype;
			 end
		 end
		 else
		 begin
			 if(!pause && start)
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
				  
				 if (randoms[0*`randomNUMlen +: `randomNUMlen] == 0)
				 begin
					 generated = 0;
					 for (i = 0; i < `datacount - 1; i = i + 1)
					 begin :loop
						 if(!generated && gamedata[i * `datalen +`datatypestart +: `datatypelen] == `nulltype)
						 begin
							  gamedata[i  *   `datalen + `datatypestart    +: `datatypelen]   <= `enemytype;
							  gamedata[i  *   `datalen + `dataxstart       +: `dataxlen]      <= `screenwidth;
							  gamedata[i  *   `datalen + `dataystart       +: `dataylen]      <= `enemyyPos;
							  gamedata[i  *   `datalen + `datawidthstart   +: `datawidthlen]  <= `enemywidthinit;
							  gamedata[i  *   `datalen + `dataheightstart  +: `dataheightlen] <= `enemyheightinit;
							  generated = 1;
							  disable loop;
						 end
						 else
						 begin
							  gamedata[i  *   `datalen + `datatypestart    +: `datatypelen]   <= gamedata[i  *   `datalen + `datatypestart    +: `datatypelen];
							  gamedata[i  *   `datalen + `dataxstart       +: `dataxlen]      <= gamedata[i  *   `datalen + `dataxstart       +: `dataxlen];
							  gamedata[i  *   `datalen + `dataystart       +: `dataylen]      <= gamedata[i  *   `datalen + `dataystart       +: `dataylen];
							  gamedata[i  *   `datalen + `datawidthstart   +: `datawidthlen]  <= gamedata[i  *   `datalen + `datawidthstart   +: `datawidthlen];
							  gamedata[i  *   `datalen + `dataheightstart  +: `dataheightlen] <= gamedata[i  *   `datalen + `dataheightstart  +: `dataheightlen];
						 end
					 end
				 end
				 else
				 begin
					 for (i = 0; i < `datacount - 1; i = i + 1)
					 begin :loop
					    gamedata[i  *   `datalen + `datatypestart    +: `datatypelen]   <= gamedata[i  *   `datalen + `datatypestart    +: `datatypelen];
					    gamedata[i  *   `datalen + `dataxstart       +: `dataxlen]      <= gamedata[i  *   `datalen + `dataxstart       +: `dataxlen];
					    gamedata[i  *   `datalen + `dataystart       +: `dataylen]      <= gamedata[i  *   `datalen + `dataystart       +: `dataylen];
					    gamedata[i  *   `datalen + `datawidthstart   +: `datawidthlen]  <= gamedata[i  *   `datalen + `datawidthstart   +: `datawidthlen];
					    gamedata[i  *   `datalen + `dataheightstart  +: `dataheightlen] <= gamedata[i  *   `datalen + `dataheightstart  +: `dataheightlen];
					 end
				 end
			 end
		 end
	 end
endmodule
