`include "define.v"

module readImage(clock, image);
input clock;
output reg [`imagecount*`imagewidth*`imageheight-1:0] image;
reg [`imagewidth-1:0] dinosaur[0:`imageheight-1];
reg [`imagewidth-1:0] cactus[0:`imageheight-1];
integer i,k;

initial
begin
	for(i=0; i < `imagecount; i=i+1)
	begin
		case(i)
			0: $readmemb("./imageConverter/dinosaur.txt", dinosaur);
			1: $readmemb("./imageConverter/cactus.txt", cactus);
		endcase
	end
	i = 0;
end


always@(posedge clock)
begin
	for(k=0; k < `imageheight; k=k+1)
	begin
		case(i)
			0: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = dinosaur[k];
			1: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = cactus[k];
		endcase
	end
	i = (i+1) % `imagecount;
end

endmodule 