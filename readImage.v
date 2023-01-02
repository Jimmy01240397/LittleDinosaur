`include "define.v"

module readImage(image);
output reg [`imagecount*`imagewidth*`imageheight-1:0] image;
reg [`imagewidth-1:0] title[0:`imageheight-1];
reg [`imagewidth-1:0] dinosaur[0:`imageheight-1];
reg [`imagewidth-1:0] cactus[0:`imageheight-1];
integer i,k;

initial
begin
	for(i=0; i < `imagecount; i=i+1)
	begin
		case(i)
			0: $readmemb("./imageConverter/title.txt", title);
			1: $readmemb("./imageConverter/dinosaur.txt", dinosaur);
			2: $readmemb("./imageConverter/cactus.txt", cactus);
		endcase
	end
	i = 0;
end


always
begin
	for(i=0; i < `imagecount; i=i+1)
	begin
		for(k=0; k < `imageheight; k=k+1)
		begin
			case(i)
				0: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = title[k];
				1: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = dinosaur[k];
				2: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = cactus[k];
			endcase
		end
	end
end

endmodule 