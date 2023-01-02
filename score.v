module score(clk2, reset, score, seven1, seven2, dot_col, dot_row);
input clk2, reset; 
input [12:0]score;
output [6:0]seven1;
output [6:0]seven2;
output [7:0]dot_col; 
output [7:0]dot_row;

integer digitO;		//digit
integer digitT;		//ten digit
integer digitH;		//hundred digit
integer digitK;		//thousand digit

reg [6:0]seven1;
reg [6:0]seven2;
reg [7:0] dot_row;
reg [7:0] dot_col;
reg [7:0] row_count;


always@(posedge clk2 or negedge reset)
begin
	if(~reset) begin
		seven1 <= 4'b0000;
		seven2 <= 4'b0000;
		dot_col <= 8'b0;
      dot_row <= 8'b0;
      row_count <= 0;
	end
	else
	begin
		digitH = score / 100;
		digitT = score / 10 - 10 * digitH;
		digitO = score - 10 * digitT - 100 * digitH;
		digitK = digitH / 8;
		
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
			case(digitH - digitK * 8)	//remainder		
				1: dot_col <= 8'b10000000;
				2: dot_col <= 8'b11000000;
				3: dot_col <= 8'b11100000;
				4: dot_col <= 8'b11110000;
				5: dot_col <= 8'b11111000;
				6: dot_col <= 8'b11111100;
				7: dot_col <= 8'b11111110;
				8: dot_col <= 8'b11111111;
				default: dot_col <= 8'b00000000;
			endcase
		end
		row_count <= row_count + 1;
	end
end

endmodule