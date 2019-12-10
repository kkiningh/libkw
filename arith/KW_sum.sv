`default_nettype none

/// Sum all values in a vector
module KW_sum #(
  parameter int unsigned DATA_WIDTH,
  parameter int unsigned NUM_INPUTS = 1,
  parameter int unsigned NUM_STAGES = 2 // Latency is NUM_STAGES - 1
) (
  input logic clock,

  /* Datapath */
  input  logic [NUM_INPUTS-1:0][DATA_WIDTH-1:0] a,
  output logic                 [DATA_WIDTH-1:0] sum
);
  logic [DATA_WIDTH-1:0] sum_internal;
`ifdef SYNOPSYS
  DW02_sum #(
    .num_inputs (NUM_INPUTS),
    .input_width(DATA_WIDTH)
  ) dw_sum_inst (
    .INPUT(a),
    .SUM  (sum_internal)
  );
`else
  int i;
  always_comb begin
    sum_internal = 'b0;
    for (i = 0; i < NUM_INPUTS; i = i + 1) begin
      sum_internal = sum_internal + a[i];
    end
  end
`endif

  KW_pipe_reg #(
    .DATA_WIDTH(DATA_WIDTH  ),
    .DEPTH     (NUM_STAGES-1)
  ) pipe (
    .clock  (clock),
    .i      (sum_internal),
    .o      (sum)
  );
endmodule
