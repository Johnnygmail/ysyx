module top(A,B,crl,result,carry,overflow,zero);
  input  [3:0]A,B;
  input [2:0] crl;
  output [3:0] result;
  reg [3:0] result_m;
  output overflow,carry,zero;
  assign carry=(((A+B)>>4)==1);
  assign overflow=(A[3]==B[3])&&(result[3]!=A[3]);
  assign zero=~(|result);
  assign result=result_m;
  always@(*)
  begin	  
  	case(crl)
		3'b0:result_m=A+B;
		3'b1:result_m=A+(~B+1'b1);
		3'b10:result_m=~A;
		3'b11:result_m=A&B;
		3'b100:result_m=A|B;
		3'b101:result_m=A^B;
		3'b110:result_m=A[3]>B[3]?1:(A<B?1:0);
		3'b111:result_m={{3'b0},(A==B)};
		default:result_m=4'b0;
	endcase
  end
 endmodule
