module ALU (
    input  [31:0] a, b,
    input  [ 2:0] f ,
	output [31:0] y_out,
    output zero,
    output c_out
);

    wire [31:0] not_b;
    assign not_b = ~ b;

    wire [31:0] b_mux_not_b;
    assign b_mux_not_b = (1'b0 == f[2]) ? b : not_b;

    wire [31:0] fx00;
    assign fx00 = a & b_mux_not_b;

    wire [31:0] fx01;
    assign fx01 = a | b_mux_not_b;

    wire [31:0] fx10;
    assign {c_out, fx10} = a + b_mux_not_b + f[2];

    wire [31:0] fx11;
    assign fx11 = {{31{1'b0}}, ((a[31] == not_b[31]) && (fx10[31] != a[31])) ? ~(fx10[31]) : fx10[31]};

    assign zero = ~| y_out;

    assign y_out = 2'b00 == f[1:0] ? fx00 : (2'b01 == f[1:0] ? fx01 : (2'b10 == f[1:0] ? fx10 : fx11 ));

endmodule