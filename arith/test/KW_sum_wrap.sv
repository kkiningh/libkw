`default_nettype none
`define DATA_WIDTH (16)
`define NUM_INPUTS (8)
`define NUM_STAGES (2)

module KW_sum_wrap (
  input logic clock,

  /* Datapath */
  input  logic [`NUM_INPUTS-1:0][`DATA_WIDTH-1:0] a,
  output logic                  [`DATA_WIDTH-1:0] sum
);
  KW_sum #(
    .DATA_WIDTH(`DATA_WIDTH),
    .NUM_INPUTS(`NUM_INPUTS),
    .NUM_STAGES(`NUM_STAGES)
  ) dut (
    .*
  );
endmodule
