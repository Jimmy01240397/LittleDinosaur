`include "define.v"

module display(clock, reset, image, gamedata, vga);
input clock, reset;
input [`imagecount*`imagewidth*`imageheight-1:0] image;
input [`datalen*`datacount-1:0] gamedata;
output reg [13:0] vga;

reg [`screenwidthnumlen-1:0]x = 0;
reg [`screenheightnumlen-1:0]y = 0;

reg [`screenwidthnumlen-1:0]hcount = 0;
reg [`screenheightnumlen-1:0]vcount = 0;

wire W_active_flag;

/*parameter       C_H_SYNC_PULSE      =   44  , 
                C_H_BACK_PORCH      =   148  ,
                C_H_ACTIVE_TIME     =   1920 ,
                C_H_FRONT_PORCH     =   88  ,
                C_H_LINE_PERIOD     =   2200 ;

parameter       C_V_SYNC_PULSE      =   5   , 
                C_V_BACK_PORCH      =   36  ,
                C_V_ACTIVE_TIME     =   1080 ,
                C_V_FRONT_PORCH     =   4  ,
                C_V_FRAME_PERIOD    =   1125 ;*/

// 分辨率为640*480时行时序各个参数定义
parameter       C_H_SYNC_PULSE      =   96  , 
                C_H_BACK_PORCH      =   48  ,
                C_H_ACTIVE_TIME     =   `screenwidth ,
                C_H_FRONT_PORCH     =   16  ,
                C_H_LINE_PERIOD     =   800 ;

// 分辨率为640*480时场时序各个参数定义               
parameter       C_V_SYNC_PULSE      =   2   , 
                C_V_BACK_PORCH      =   33  ,
                C_V_ACTIVE_TIME     =   `screenheight ,
                C_V_FRONT_PORCH     =   10  ,
                C_V_FRAME_PERIOD    =   525 ;
					 
//parameter       C_COLOR_BAR_WIDTH   =   C_H_ACTIVE_TIME / 8  ;  



always @(posedge clock or negedge reset)
begin
    if(!reset)
        hcount <=  `screenwidthnumlen'd0   ;
    else if(hcount == C_H_LINE_PERIOD - 1'b1)
        hcount <=  `screenwidthnumlen'd0   ;
    else
        hcount <=  hcount + 1'b1  ;                
		  
	 if(clock)
		 vga[12] =   (hcount < C_H_SYNC_PULSE) ? 1'b0 : 1'b1    ; 
	 else
		 vga[12] =   vga[12]    ; 
end                


always @(posedge clock or negedge reset)
begin
    if(!reset)
        vcount <=  `screenheightnumlen'd0   ;
    else if(vcount == C_V_FRAME_PERIOD - 1'b1)
        vcount <=  `screenheightnumlen'd0   ;
    else if(hcount == C_H_LINE_PERIOD - 1'b1)
        vcount <=  vcount + 1'b1  ;
    else
        vcount <=  vcount ;
		
	 if(clock)
		 vga[13] =   (vcount < C_V_SYNC_PULSE) ? 1'b0 : 1'b1    ; 
	 else
		 vga[13] =   vga[13]    ; 
end                

assign W_active_flag =  (hcount >= (C_H_SYNC_PULSE + C_H_BACK_PORCH                  ))  &&
                       (hcount <= (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_H_ACTIVE_TIME))  && 
                       (vcount >= (C_V_SYNC_PULSE + C_V_BACK_PORCH                  ))  &&
                       (vcount <= (C_V_SYNC_PULSE + C_V_BACK_PORCH + C_V_ACTIVE_TIME))  ;  

integer i;
integer check;
integer oldx;
integer oldy;

always@(posedge clock or negedge reset)
begin
	if(!reset)
	begin
		vga[11:0] = 12'd0;
	end
	else if(W_active_flag)
	begin
		x = hcount - C_H_SYNC_PULSE - C_H_BACK_PORCH;
		y = vcount - C_V_SYNC_PULSE - C_V_BACK_PORCH;
		check = 0;
		
		for(i = 0; i < `datacount; i = i + 1)
		begin: loop
			if(gamedata[i*`datalen+`datatypestart +: `datatypelen])
			begin
				if(!check &&
					x >= gamedata[i*`datalen+`dataxstart +: `dataxlen] && 
					x < gamedata[i*`datalen+`dataxstart +: `dataxlen] + gamedata[i*`datalen+`datawidthstart +: `datawidthlen] && 
					y >= gamedata[i*`datalen+`dataystart +: `dataylen] && 
					y < gamedata[i*`datalen+`dataystart +: `dataylen] + gamedata[i*`datalen+`dataheightstart +: `dataheightlen])
				begin
				
					oldx = `imagewidth - (x - gamedata[i*`datalen+`dataxstart +: `dataxlen]) * `imagewidth / gamedata[i*`datalen+`datawidthstart +: `datawidthlen] - 1;
					oldy = (y - gamedata[i*`datalen+`dataystart +: `dataylen]) * `imageheight / gamedata[i*`datalen+`dataheightstart +: `dataheightlen];
					vga[11:0] = (image[(gamedata[i*`datalen+`datatypestart +: `datatypelen] - 1)*`imagewidth*`imageheight+oldy*`imagewidth + oldx] ? ~(12'd0) : 12'd0);
				
					//vga[11:0] = 12'd0;
					check = 1;
					disable loop;
				end
			end
		end
		
		if(!check)
			vga[11:0] = ~(12'd0);
	end
	else
	begin
		vga[11:0] = 12'd0;
	end
end
endmodule 