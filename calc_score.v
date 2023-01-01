module calc_score(clk3, reset, pause, score);
input clk3, reset, pause;
output reg [`scorelen : 0] score;

reg frameCnt;

always@(posedge clk3 or negedge reset or negedge pause)
begin
	if(!pause)
	begin
		if(!reset)
		begin
			score <= 0;
			frameCnt <= 0;
		end
		else
		begin
			frameCnt <= frameCnt + 1;
			if(frameCnt == `scoreaddperiod)
			begin
				score <= score + 1;
			end
		end
	end
end

endmodule
