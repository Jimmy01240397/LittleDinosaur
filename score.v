module score(clk2, score, seven1, seven2, dot_col, dot_row);
input clk2; 
input [`scorelen-1:0]score;
output reg [6:0]seven1;
output reg [6:0]seven2;
output reg [7:0]dot_col; 
output reg [7:0]dot_row;

reg [2:0] row_count;

wire [3:0] digitO;		//digit
wire [3:0] digitT;		//ten digit
wire [2:0] digitH;		//hundred digit
wire [2:0] digitK;		//thousand digit


assign digitO = (score / 1) % 10;
assign digitT = (score / 10) % 10;
assign digitH = (score / 100) % 8;
assign digitK = (score / 800) % 8;

always
begin
	//seven displayer
	case(digitO)
	  0: seven1 = 7'b1000000;
	  1: seven1 = 7'b1111001;
	  2: seven1 = 7'b0100100;
	  3: seven1 = 7'b0110000;
	  4: seven1 = 7'b0011001;
	  5: seven1 = 7'b0010010;
	  6: seven1 = 7'b0000010;
	  7: seven1 = 7'b1111000;
	  8: seven1 = 7'b0000000;
	  9: seven1 = 7'b0010000;
	endcase
	case(digitT)
	  0: seven2 = 7'b1000000;
	  1: seven2 = 7'b1111001;
	  2: seven2 = 7'b0100100;
	  3: seven2 = 7'b0110000;
	  4: seven2 = 7'b0011001;
	  5: seven2 = 7'b0010010;
	  6: seven2 = 7'b0000010;
	  7: seven2 = 7'b1111000;
	  8: seven2 = 7'b0000000;
	  9: seven2 = 7'b0010000;
	endcase
end



always@(posedge clk2)
begin
	//dot matrix'd
	case (row_count)
		0: dot_row <= 8'b01111111;
		1: dot_row <= 8'b10111111;
		2: dot_row <= 8'b11011111;
		3: dot_row <= 8'b11101111;
		4: dot_row <= 8'b11110111;
		5: dot_row <= 8'b11111011;
		6: dot_row <= 8'b11111101;
		7: dot_row <= 8'b11111110;
	endcase
	if(row_count < digitK)	
	begin
		dot_col <= 8'b11111111;
	end
	else if(row_count > digitK)	
	begin
		dot_col <= 8'b00000000;
	end
	else
	begin
		case(digitH)	//remainder		
			0: dot_col <= 8'b00000000;
			1: dot_col <= 8'b10000000;
			2: dot_col <= 8'b11000000;
			3: dot_col <= 8'b11100000;
			4: dot_col <= 8'b11110000;
			5: dot_col <= 8'b11111000;
			6: dot_col <= 8'b11111100;
			7: dot_col <= 8'b11111110;
			default: dot_col <= 8'b00000000;
		endcase
	end
	row_count <= row_count + 1;
end

endmodule