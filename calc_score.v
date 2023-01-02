module calc_score(clk3, reset, pause, start, score);
input clk3, reset, pause, start;
output reg [`scorelen : 0] score;

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
				score <= score + 1;
				frameCnt <= 0;
			end
		end
	end
end

endmodule
