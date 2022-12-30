`include "define.v"

module gen_enemy(togenerate, gamedata);
    inout reg [43:0] gamedata [8:0];
    input togenerate;

    always@(posedge togenerate)
    begin
        if (togenerate)
        else(!togenerate)
    end 
endmodule