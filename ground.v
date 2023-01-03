module ground(clk3,reset,pause,start,ground);
input clk3, reset, pause, start;
output reg [`datalen - 1:0] ground;

reg [`groundcoundlen - 1:0] count;

always
begin
	if(start)
	begin
		ground[`datatypestart   +: `datatypelen]=`groundtype;
	end
	else
	begin
		ground[`datatypestart   +: `datatypelen]=`nulltype;
	end
	ground[`dataystart 		+: `dataylen]=`groundyPos;
	ground[`datawidthstart  +: `datawidthlen]=`groundwidth;
	ground[`dataheightstart +: `dataheightlen]=`groundheight;
end

always@(posedge clk3 or negedge reset)
begin
	if(!reset)
	begin
		ground[`dataxstart 		+: `dataxlen] <= `groundxPos;
	end
	else
	begin
		if(!pause && start)
		begin
			ground[`dataxstart 		+: `dataxlen] <= `groundxPos;
		end
		else
		begin
			ground[`dataxstart 		+: `dataxlen] <= `groundxPos;
		end
	end
end

endmodule 