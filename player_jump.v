`include "define.v"

module player_jump(clk3,reset,button,jump);
input clk3;
input reset;
input button;
output jump;
reg jump;
always@(posedge clk3)
begin
	if(button)
	begin
		jump<=1'b1;
	end
	else
	begin
		jump<=1'b0;
	end
end
endmodule