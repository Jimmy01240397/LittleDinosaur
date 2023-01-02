module random(clock, reset, start, randoms, testlist);
input clock, reset, start;
output reg [`randomNUMlen*`randomCount-1:0] randoms;
output [`randomNUMlen * (1<<`randomNUMlen) * 2 - 1:0] testlist;

reg [`randomNUMlen * (1<<`randomNUMlen) * 2 - 1:0] randomlist [0:0];
reg [`randomNUMlen-1:0] seeds [1:0];
reg [`randomNUMlen:0] count = 6;//(1<<`randomNUMlen);
integer i;

initial
begin
	$readmemh("./GenRandom/randomlist.txt", randomlist);
end

assign testlist = randomlist[0];

always@(posedge clock or negedge reset)
begin
	if(!reset)
	begin
		count = 6;//(1<<`randomNUMlen);
		randoms = 0;
		seeds[0] = 0;
		seeds[1] = 0;
	end
	else
	begin
		if(start)
		begin
			for(i = 0; i < `randomCount; i = i + 1)
			begin
				/*randoms[i*`randomNUMlen +: `randomNUMlen] = randomlist[0][seeds[0]];
				seeds[0] = (seeds[0] + 1) % (1<<`randomNUMlen);*/
				randoms[i*`randomNUMlen +: `randomNUMlen] = 
				randomlist[0][((seeds[0] ^ seeds[1]) % count)*`randomNUMlen +: `randomNUMlen];
				
				randomlist[0][((seeds[0] ^ seeds[1]) % count)*`randomNUMlen +: (1<<`randomNUMlen)] = 
				randomlist[0][(((seeds[0] ^ seeds[1]) % count) + 1)*`randomNUMlen +: (1<<`randomNUMlen)];
				
				randomlist[0][((1<<`randomNUMlen) - 1)*`randomNUMlen +: `randomNUMlen] = 
				randoms[i*`randomNUMlen +: `randomNUMlen];
				
				
				seeds[1] = seeds[0];
				seeds[0] = 
				randoms[i*`randomNUMlen +: `randomNUMlen];
				
				if(count > 1)
					count = count - 1;
				else
					count = 6;//(1<<`randomNUMlen);
			end
		end
		else
		begin
			seeds[0] = seeds[0] + 1;
		end
	end
end

endmodule 