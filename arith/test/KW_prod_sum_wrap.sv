`default_nettype none

module KW_prod_sum_wrap (
  input logic clock,

  /* Datapath */
  input  logic [15:0][15:0] a,
  input  logic [15:0][15:0] b,
  output logic [15:0] sum
);
  KW_prod_sum #(
    .A_WIDTH(16),
    .B_WIDTH(16),
    .SUM_WIDTH(16),
    .NUM_INPUTS(16),
    .NUM_STAGES(2)
  ) dut (
    .clock(clock),
    .a(a),
    .b(b),
    .sum(sum)
  );
endmodule
