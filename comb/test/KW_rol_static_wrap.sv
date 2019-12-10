`default_nettype none
`define WIDTH (16)
`define ROL (15)

module KW_rol_static_wrap (
  input  logic [`WIDTH-1:0] a,
  output logic [`WIDTH-1:0] b
);
  KW_rol_static #(
    .WIDTH(`WIDTH),
    .ROL(`ROL)
  ) dut (
    .a(a),
    .b(b)
  );
endmodule
