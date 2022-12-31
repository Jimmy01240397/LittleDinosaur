`include "define.v"

module check_gen_enemy(clk3, reset, togenerate);
    input       clk3, reset;
    output  	 togenerate;
    GARO(.clk(clk3), .reset(reset), .random(togenerate));
endmodule 