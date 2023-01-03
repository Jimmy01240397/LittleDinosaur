module calc_score(clk3, reset, pause, start, score);
input clk3, reset, pause, start;
output reg [`scorelen-1 : 0] score;

integer frameCnt;

always@(posedge clk3 or negedge reset)
begin
	if(!reset)
	begin
		score <= 0;
		frameCnt <= 0;
	end
	else
	begin
		if(!pause && start)
		begin
			frameCnt <= frameCnt + 1;
			if(frameCnt == `scoreaddperiod)
			begin
				score <= (((score + 1) / 800) % 8) * 800 + (((score + 1) / 100) % 8) * 100 + (((score + 1) / 10) % 10) * 10 + (((score + 1) / 1) % 10) * 1;
				frameCnt <= 0;
			end
		end
	end
end

endmodule
