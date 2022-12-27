module readImage(index, out);

input [31:0]index;

output [79:0]out;

reg [79:0]img[0:40]; // image size

initial
	begin
		$readmemb("./imageConverter/dinosaur.txt", img);
	end
	
assign out = img[index];
	
endmodule
