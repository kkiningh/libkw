`default_nettype none

module KW_fifo_stream #(
  parameter int unsigned DATA_WIDTH = 16, // Data width in bits
  parameter int unsigned DEPTH      = 16, // Queue depth
  parameter int unsigned SKID       = 1,  // Queue skid

  // Error modes:
  // 0 - Underflow/overflow with pointer latched checking
  // 1 - Underflow/overflow latched checking
  // 2 - Underflow/overflow unlatched checking
  parameter int ERR_MODE = 1
) (
  input logic clock,    // Clock
  input logic reset_n,  // Reset, active low, ASYNC

  /* RV input control */
  output logic i_ready,
  input  logic i_valid,

  /* RV output control */
  input  logic o_ready,
  output logic o_valid,

  /* Datapath */
  input  logic [DATA_WIDTH-1:0] i_data,
  output logic [DATA_WIDTH-1:0] o_data
);
  // Flags
  logic empty, almost_empty, half_full, almost_full, full;
  logic error;
  KW_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH     (DEPTH),
    .AF_LEVEL  (SKID),
    .AE_LEVEL  (1), // Almost empty is unused
    .ERR_MODE  (ERR_MODE)
  ) fifo (
    .clock  (clock),
    .reset_n(reset_n),
    /* Control */
    .push_req(i_ready && i_valid),
    .pop_req (o_ready && o_valid),
    /* Datapath */
    .data_i(i_data),
    .data_o(o_data),
    /* Flags */
    .empty       (empty),
    .almost_empty(almost_empty),
    .half_full   (half_full),
    .almost_full (almost_full),
    .full        (full),
    .error       (error)
  );

  KW_unread __unread_almost_empty (almost_empty);
  KW_unread __unread_half_full    (half_full);
  KW_unread __unread_full         (full);
  KW_unread __unread_error        (error);

  assign i_ready = !almost_full;
  assign o_valid = !empty;
endmodule
