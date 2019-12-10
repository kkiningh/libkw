`default_nettype none
`define DATA_WIDTH (16)
`define DEPTH      (32)
`define SKID       (1)
`define ERR_MODE   (1)

module KW_fifo_stream_wrap (
  input logic clock,    // Clock
  input logic reset_n,  // Reset, active low, ASYNC

  /* RV input control */
  output logic i_ready,
  input  logic i_valid,

  /* RV output control */
  input  logic o_ready,
  output logic o_valid,

  /* Datapath */
  input  logic [`DATA_WIDTH-1:0] i_data,
  output logic [`DATA_WIDTH-1:0] o_data
);
  KW_fifo_stream #(
    .DATA_WIDTH(`DATA_WIDTH),
    .DEPTH(`DEPTH),
    .SKID(`SKID),
    .ERR_MODE(`ERR_MODE)
  ) dut (
    .*
  );
endmodule
