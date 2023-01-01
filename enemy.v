`include "define.v"

module enemy(clk3, reset, pause, gamedata);
    input clk3, reset, pause;
    inout reg [`datalen * (`datacount - 1) - 1:0] gamedata;
    integer i;
    wire togenerate;
	 reg generated;

    check_gen_enemy(.clk3(clk3), .togenerate(togenerate));
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
			 if(!pause)
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
					 generated <= 0;
					 for (i = 0; i < `datacount - 1; i = i + 1)
					 begin :loop
						 if(!generated && gamedata[i * `datalen +`datatypestart +: `datatypelen] == `nulltype)
						 begin
							  gamedata[i  *   `datalen + `datatypestart    +: `datatypelen]   <= `enemytype;
							  gamedata[i  *   `datalen + `dataxstart       +: `dataxlen]      <= `screenwidth;
							  gamedata[i  *   `datalen + `dataystart       +: `dataylen]      <= `enemyyPos;
							  gamedata[i  *   `datalen + `datawidthstart   +: `datawidthlen]  <= `enemywidthinit;
							  gamedata[i  *   `datalen + `dataheightstart  +: `dataheightlen] <= `enemyheightinit;
							  generated <= 1;
							  disable loop;
						 end
					 end
				 end
			 end
		 end
	 end
endmodule
