`default_nettype none

module KW_mux_n_onehot #(
  parameter int unsigned N = 4,
  parameter int unsigned WIDTH = 16
) (
  input  logic [N-1:0]     i_sel_onehot,
  input  logic [WIDTH-1:0] i_data [0:N-1],
  output logic [WIDTH-1:0] o_data
);
  int i;
  always_comb begin
`ifdef VERILATOR
    // Workaround verilator's lack of support for tristates
    // by using X instead
    o_data = {WIDTH{1'bX}};
`else
    o_data = {WIDTH{1'bZ}};
`endif
    for (i = 0; i < N; i = i + 1) begin
      if (i_sel_onehot == {{N-1{1'b0}}, 1'b1} << i) begin
        o_data = i_data[i];
      end
    end
  end
endmodule
