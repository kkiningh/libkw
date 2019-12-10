`default_nettype none

/// For reset_n, asynchronously assert and sychronously de-assert (AASD)
/// Number of stages is configurable, but defaults to 4
module KW_reset_sync #(
  parameter int unsigned STAGES = 4
) (
  input  logic clock,     // Destination clock being syncronized to
  input  logic i_reset_n, // Input reset, active low, async
  input  logic testmode,  // Testmode enable
  output logic o_reset_n  // Output reset, active low, AASD
);
  // Syncronizer
  logic [STAGES-1:0] sync_stages;
  always_ff @(posedge clock or negedge i_reset_n) begin
    if (!i_reset_n) begin
      sync_stages <= {STAGES{1'b0}};
    end else begin
      sync_stages <= {sync_stages[STAGES-2:0], 1'b1};
    end
  end

  // bypass syncronizer in testmode
  assign o_reset_n = testmode ? i_reset_n : sync_stages[STAGES-1];
endmodule
