`include "define.v"

module readImage(image);
output reg [`imagecount*`imagewidth*`imageheight-1:0] image;
reg [`imagewidth-1:0] title[0:`imageheight-1];
reg [`imagewidth-1:0] ground[0:`imageheight-1];
reg [`imagewidth-1:0] dinosaur1[0:`imageheight-1];
reg [`imagewidth-1:0] dinosaur2[0:`imageheight-1];
reg [`imagewidth-1:0] cactus[0:`imageheight-1];
integer i,k;

initial
begin
	for(i=0; i < `imagecount; i=i+1)
	begin
		case(i+1)
			`titletype: $readmemb("./imageConverter/title.txt", title);
			`groundtype: $readmemb("./imageConverter/ground.txt", ground);
			`player1type: $readmemb("./imageConverter/dinosaur1.txt", dinosaur1);
			`player2type: $readmemb("./imageConverter/dinosaur2.txt", dinosaur2);
			`enemytype: $readmemb("./imageConverter/cactus.txt", cactus);
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
			case(i+1)
				`titletype: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = title[k];
				`groundtype: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = ground[k];
				`player1type: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = dinosaur1[k];
				`player2type: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = dinosaur2[k];
				`enemytype: image[i*`imagewidth*`imageheight + k*`imagewidth +: `imagewidth] = cactus[k];
			endcase
		end
	end
end

endmodule 