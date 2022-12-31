`include "define.v"

module check_gen_enemy(clk3, togenerate);
    input       clk3;
    output  	 togenerate;
    GARO(.clk(clk3), .random(togenerate));
endmodule 
