`default_nettype none

// Simple pipeline register with DEPTH logic stages
// Use KW_pipe_reg_reset if you require the use of a reset signal
module KW_pipe_reg #(
  parameter int unsigned DATA_WIDTH,
  parameter int unsigned DEPTH = 1
) (
  input logic clock,

  input  logic [DATA_WIDTH-1:0] i,
  output logic [DATA_WIDTH-1:0] o
);
  generate
    if (DEPTH == 0) begin
      // Combinational assignment
      assign o = i;
    end else if (DEPTH == 1) begin
      // Single register
      always_ff @(posedge clock) begin
        o <= i;
      end
    end else begin
      // Shift register
      logic [DATA_WIDTH-1:0] shift [0:DEPTH-1];
      always @(posedge clock) begin
        shift[1:DEPTH-1] <= shift[0:DEPTH-2];
        shift[0] <= i;
      end
      assign o = shift[DEPTH-1];
    end
  endgenerate
endmodule
