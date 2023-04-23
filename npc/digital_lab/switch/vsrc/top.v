
module top(
  input clk,
  input rst,
  input [1:0]sw,
  output f
);
  assign f = rst?0:sw[1] ^ sw[0];
endmodule
