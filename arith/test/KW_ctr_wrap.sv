`default_nettype none
`define WIDTH (16)

module KW_ctr_wrap (
  input  logic clock,
  input  logic reset_n,
  input  logic cen,
  output logic [`WIDTH-1:0] count
);
  KW_ctr #(
    .WIDTH(`WIDTH)
  ) dut (
    .clock(clock),
    .reset_n(reset_n),
    .cen(cen),
    .count(count)
  );
endmodule
