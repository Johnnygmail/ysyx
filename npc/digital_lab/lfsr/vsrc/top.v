//`include "MuxKeyInternal.v"
module top(X,Y,clk,rst,sseg,sseg1);
  input  [7:0]X;
  input clk;
  input rst;
  output reg [7:0] Y;
  output reg [6:0]sseg;
  output reg [6:0]sseg1;
  wire [7:0]Y_next;
  assign Y_next=(Y==0?(8'b1):{Y[4]^Y[3]^Y[2]^Y[0],Y[7:1]});
  always@(posedge clk or negedge rst)
  begin
    if(rst)
	    Y=8'b1;
    else
	    Y=Y_next;
  end

  always@(*)
  begin
	  case(Y[3:0])
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

  always@(*)
	  begin
    case(Y[7:4])
                        4'b0000: sseg1 =7'b0000001; //共阳极数码管
                        4'b0001: sseg1 =7'b1001111;
                        4'b0010: sseg1 =7'b0010010;
                        4'b0011: sseg1 =7'b0000110;
                        4'b0100: sseg1 =7'b1001100;
                        4'b0101: sseg1 =7'b0100100;
                        4'b0110: sseg1 =7'b0100000;
                        4'b0111: sseg1 =7'b0001111;
                        4'b1000: sseg1 =7'b0000010;
                        4'b1001: sseg1 =7'b0000100;
                        4'b1010: sseg1 =7'b0001000;
                        4'b1011: sseg1 =7'b1100000;
                        4'b1100: sseg1 =7'b0110001;
                        4'b1101: sseg1 =7'b1000010;
                        4'b1110: sseg1 =7'b0110000;
                        default: sseg1 =7'b0111000;
        endcase

  end

 endmodule
