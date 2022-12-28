module LittleDinosaur(cnt, rst, out);

input cnt, rst;

output reg [79:0]out;

/* 
 * read Image
*/

reg [31:0]indexDinosourImg;
reg [31:0]indexCactusImg;

reg [79:0]dinosourImg[0:40]; // need to set image size
reg [79:0]cactusImg[0:40];   // need to set image size

initial
	begin
		indexDinosourImg = 0;
		indexCactusImg = 0;
		$readmemb("./imageConverter/dinosaur.txt", dinosourImg);
		$readmemb("./imageConverter/cactus.txt", cactusImg);
	end

always @(posedge cnt)
begin
	out = dinosourImg[indexDinosourImg]; // here is tmperatory output for test
	indexDinosourImg = indexDinosourImg + 1;
	indexCactusImg = indexCactusImg + 1;
end

/* 
 * read Image end
*/

endmodule
