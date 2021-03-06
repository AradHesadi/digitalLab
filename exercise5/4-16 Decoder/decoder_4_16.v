module Decoder_2_4 (W, En, Y);
   input [1:0] W;
   input En;
   output reg [0:3] Y;
    always @(W, En)
    begin
      if (En == 0)
        Y = 4'b0000;
      else
        case (W)
           0: Y = 4'b1000;
           1: Y = 4'b0100;
           2: Y = 4'b0010;
           3: Y = 4'b0001;
        endcase
    end
endmodule


module Decoder_4_16 (W, En, Y);
 input [3:0] W;
 input En;
 output [0:15] Y;
 wire [0:3] M;
 Decoder_2_4 Dec1 (W[3:2],En ,M[0:3]);
 Decoder_2_4 Dec2 (W[1:0], M[0] , Y[0:3]);
 Decoder_2_4 Dec3 (W[1:0], M[1] , Y[4:7]);
 Decoder_2_4 Dec4 (W[1:0], M[2] , Y[8:11]);
 Decoder_2_4 Dec5 (W[1:0], M[3] , Y[12:15]);
endmodule

//testbench//

module tb_decoder();
  reg [3:0] W;
  reg En;
  wire [0:15] Y;
Decoder_4_16 d1 (W , En , Y);

initial
 begin 

	W = 0; En =0;
	#100;
	W = 0; En =1;
	#100;
	W = 1; En =1;
	#100;
	W = 2; En =1;
	#100;
	W = 3; En =1;
	#100;
	W = 5; En =1;
	#100;
	W = 6; En =1;
	#100;
	W = 7; En =1;
	#100;
	W = 8; En =1;
	#100;

end

endmodule