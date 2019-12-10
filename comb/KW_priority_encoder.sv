`default_nettype none

/// Simple priority encoder.
module KW_priority_encoder #(
  parameter int unsigned N,
  parameter int unsigned M = $clog2(N)
) (
  input  logic [N-1:0] a,
  output logic [M-1:0] b
);
  int i;
  always_comb begin
    b = '{M{1'bX}};
    for (i = 0; i < N; i = i + 1) begin
      if (a[i]) begin
        b = i[M-1:0];
      end
    end
  end
endmodule
