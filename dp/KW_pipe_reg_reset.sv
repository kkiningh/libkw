`default_nettype none

// Simple pipeline register with DEPTH logic stages
module KW_pipe_reg_reset #(
  parameter int unsigned DATA_WIDTH,
  parameter int unsigned DEPTH = 1
) (
  input logic clock,
  input logic reset_n,

  input  logic [DATA_WIDTH-1:0] i,
  output logic [DATA_WIDTH-1:0] o
);
  generate
    if (DEPTH == 0) begin
      // Combinational assignment
      assign o = i;
    end else if (DEPTH == 1) begin
      // Single register
      always_ff @(posedge clock or negedge reset_n) begin
        if (~reset_n) begin
          o <= '{DATA_WIDTH{1'b0}};
        end else begin
          o <= i;
        end
      end
    end else begin
      // Shift register
      logic [DATA_WIDTH-1:0] shift [0:DEPTH-1];
      always @(posedge clock or negedge reset_n) begin
        if (!reset_n) begin
          shift <= '{DEPTH{'{DATA_WIDTH{1'b0}}}};
        end else begin
          shift[1:DEPTH-1] <= shift[0:DEPTH-2];
          shift[0] <= i;
        end
      end
      assign o = shift[DEPTH-1];
    end
  endgenerate
endmodule
