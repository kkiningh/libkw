`default_nettype none

module KW_prod_sum #(
  parameter int A_WIDTH,
  parameter int B_WIDTH,
  parameter int SUM_WIDTH,

  parameter int NUM_INPUTS = 4,
  parameter int NUM_STAGES = 3 // Latency is NUM_STAGES - 1
) (
  input logic clock,

  /* Datapath */
  input  logic [NUM_INPUTS-1:0][A_WIDTH-1:0] a,
  input  logic [NUM_INPUTS-1:0][B_WIDTH-1:0] b,
  output logic [SUM_WIDTH-1:0] sum
);
`ifndef SYNTHESIS
  initial begin
    assert (A_WIDTH >= 1) else $fatal("A_WIDTH must be >= 1");
    assert (B_WIDTH >= 1) else $fatal("B_WIDTH must be >= 1");
    assert (SUM_WIDTH >= 2) else $fatal("SUM_WIDTH must be >= 2");
    assert (NUM_INPUTS >= 2 && NUM_INPUTS <= 17) else
      $fatal("NUM_INPUTS must be in [2, 17] inclusive");
  end
`endif

`ifdef VERILATOR
  logic [SUM_WIDTH-1:0] result;
  generate
    case (NUM_INPUTS)
      // Explicitly write out the product-sum expression to help DC optimize it
      2: assign result =
        a[0] * b[0] + a[1] * b[1];
      3: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
      4: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
      5: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3] +
        a[4] * b[4];
      6: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3] +
        a[4] * b[4] + a[5] * b[5];
      7: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3] +
        a[4] * b[4] + a[5] * b[5] + a[6] * b[6];
      8: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3] +
        a[4] * b[4] + a[5] * b[5] + a[6] * b[6] + a[7] * b[7];
      9: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3] +
        a[4] * b[4] + a[5] * b[5] + a[6] * b[6] + a[7] * b[7] +
        a[8] * b[8];
      10: assign result =
        a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3] +
        a[4] * b[4] + a[5] * b[5] + a[6] * b[6] + a[7] * b[7] +
        a[8] * b[8] + a[9] * b[9];
      16: assign result =
        a[ 0] * b[ 0] + a[ 1] * b[ 1] + a[ 2] * b[ 2] + a[ 3] * b[ 3] +
        a[ 4] * b[ 4] + a[ 5] * b[ 5] + a[ 6] * b[ 6] + a[ 7] * b[ 7] +
        a[ 8] * b[ 8] + a[ 9] * b[ 9] + a[10] * b[10] + a[11] * b[11] +
        a[12] * b[12] + a[13] * b[13] + a[14] * b[14] + a[15] * b[15];
      17: assign result =
        a[ 0] * b[ 0] + a[ 1] * b[ 1] + a[ 2] * b[ 2] + a[ 3] * b[ 3] +
        a[ 4] * b[ 4] + a[ 5] * b[ 5] + a[ 6] * b[ 6] + a[ 7] * b[ 7] +
        a[ 8] * b[ 8] + a[ 9] * b[ 9] + a[10] * b[10] + a[11] * b[11] +
        a[12] * b[12] + a[13] * b[13] + a[14] * b[14] + a[15] * b[15] +
        a[16] * b[16];
    endcase
  endgenerate

  KW_pipe_reg #(
    .DATA_WIDTH(SUM_WIDTH),
    .DEPTH(NUM_STAGES-1)
  ) pipe (
    .clock(clock),
    .i(result),
    .o(sum)
  );
`else
  // Use a Designware component
  DW_prod_sum_pipe #(
    .a_width   (A_WIDTH),
    .b_width   (B_WIDTH),
    .num_inputs(NUM_INPUTS),
    .sum_width (SUM_WIDTH),
    .num_stages(NUM_STAGES),
    .stall_mode(1'b0), // non-stallable
    .rst_mode  (1'b1), // async reset
    .op_iso_mode(1'b0) // controlled by variable DW_lp_op_iso_mode
  ) prod_sum_pipe (
    .clk(clock),
    .rst_n(reset_n),
    .en(1'b1),
    .tc(1'b0), // unsigned
    .a(a),
    .b(b),
    .sum(sum)
  );
`endif
endmodule
