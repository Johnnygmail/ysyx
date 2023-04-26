//`include "MuxKeyInternal.v"
module top(X,Y,empty,sseg);
  input  [7:0]X;
  output reg [2:0] Y;
  output empty;
  output reg [6:0]sseg;
  assign empty=(X==8'b0);
  always@(*)
  begin	  
  casez (X)
	8'b1zzzzzzz:Y=3'b111;
	8'b01zzzzzz:Y=3'b110;	
	8'b001zzzzz:Y=3'b101;
	8'b0001zzzz:Y=3'b100;
	8'b00001zzz:Y=3'b011;
	8'b000001zz:Y=3'b010;
	8'b0000001z:Y=3'b001;
	8'b0000000z:Y=3'b000;
	default:Y=3'b0;
  endcase
  end
  always@(*)begin
	  case({1'b0,Y})
		        4'b0000: sseg =7'b0000001; //共阳极数码管
			4'b0001: sseg =7'b1001111;
			4'b0010: sseg =7'b0010010;
			4'b0011: sseg =7'b0000110;
			4'b0100: sseg =7'b1001100;
			4'b0101: sseg =7'b0100100;
			4'b0110: sseg =7'b0100000;
			4'b0111: sseg =7'b0001111;
			4'b1000: sseg =7'b0000010;
			4'b1001: sseg =7'b0000100;
			4'b1010: sseg =7'b0001000;
			4'b1011: sseg =7'b1100000;
			4'b1100: sseg =7'b0110001;	
			4'b1101: sseg =7'b1000010;
			4'b1110: sseg =7'b0110000;
			default: sseg =7'b0111000;
	endcase
  end
 endmodule
