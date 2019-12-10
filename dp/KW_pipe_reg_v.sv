`default_nettype none

// Pipeline register with associated valid bit
// Valid is set to zero on reset
module KW_pipe_reg_v #(
  parameter int unsigned DATA_WIDTH,
  parameter int unsigned DEPTH = 1
) (
  input logic clock,
  input logic reset_n, // active low, ASYNC

  input  logic                  i_v,
  input  logic [DATA_WIDTH-1:0] i,
  output logic                  o_v,
  output logic [DATA_WIDTH-1:0] o
);
  KW_pipe_reg #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH     (DEPTH)
  ) data_pipe_reg (
    .clock(clock),
    .i(i),
    .o(o)
  );

  KW_pipe_reg_reset #(
    .DATA_WIDTH(1),
    .DEPTH     (DEPTH)
  ) valid_pipe_reg (
    .clock  (clock),
    .reset_n(reset_n),
    .i(i_v),
    .o(o_v)
  );
endmodule
