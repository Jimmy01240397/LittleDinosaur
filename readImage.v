`include "define.v"

task readImage ;
	output [`imagecount*`imagewidth*`imageheight-1:0] image;
	reg [`imagewidth-1:0] tmp[0:`imageheight];
	integer i;
	integer k;
	begin
		for(i=0; i < `imagewidth; i=i+1)
		begin
			case(i)
				0: $readmemb("./imageConverter/dinosaur.txt", tmp);
				1: $readmemb("./imageConverter/cactus.txt", tmp);
			endcase

			for(k=0; k < `imageheight; k=k+1)
			begin
				image[i*`imageheight + k] = tmp[k];
			end
		end
	end
endtask
