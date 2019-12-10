`default_nettype none
`define N (4)
`define WIDTH (16)

module KW_mux_n_onehot_wrap (
  input  logic [`N-1:0]     i_sel_onehot,
  input  logic [`WIDTH-1:0] i_data [0:`N-1],
  output logic [`WIDTH-1:0] o_data
);
  KW_mux_n_onehot #(
    .N(`N),
    .WIDTH(`WIDTH)
  ) dut (
    .i_sel_onehot(i_sel_onehot),
    .i_data      (i_data),
    .o_data      (o_data)
  );
endmodule
