`include "define.v"

module Freq_Div(clock,clk1,clk2,clk3);
input clock;
output reg clk1, clk2, clk3;
reg [31:0]count1 = 0, count2 = 0, count3 = 0;
always@(posedge clock)
begin
	if(count1 % (`clockHz / 2 / `vgaHz) == 0)
	begin
		clk1 = ~clk1;
	end
	if(count2 % (`clockHz / 2 / `dotHz) == 0)
	begin
		clk2 = ~clk2;
	end
	if(count3 % (`clockHz / 2 / `gameHz) == 0)
	begin
		clk3 = ~clk3;
	end

	count1 = (count1 + 1) % (`clockHz / 2 / `vgaHz);
	count2 = (count2 + 1) % (`clockHz / 2 / `dotHz);
	count3 = (count3 + 1) % (`clockHz / 2 / `gameHz);
end
endmodule 
