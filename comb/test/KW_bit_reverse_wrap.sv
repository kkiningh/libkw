`default_nettype none
`define WIDTH (32)

module KW_bit_reverse_wrap (
  input  logic [`WIDTH-1:0] i,
  output logic [`WIDTH-1:0] o
);
  KW_bit_reverse #(
    .WIDTH(`WIDTH)
  ) dut (
    .*
  );
endmodule
