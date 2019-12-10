`default_nettype none

/// Divide clock by integer
module KW_clock_div #(
  parameter int unsigned RATIO = 4
) (
  input  logic i_clock,  // Input clock
  input  logic reset_n,  // ASYCN reset (active low)
  input  logic testmode, // testmode enable
  input  logic en,       // clock divide enable
  output logic o_clock   // Output clock
);
  logic [RATIO-1:0] counter_q;
  logic clock_q;

  always_ff @(posedge i_clock or negedge reset_n) begin
    if (!reset_n) begin
      clock_q   <= 1'b0;
      counter_q <= '{RATIO{1'b0}};
    end else begin
      clock_q <= 1'b0;
      if (en) begin
        if (counter_q == (RATIO[RATIO-1:0] - 1)) begin
          clock_q <= 1'b1;
        end else begin
          counter_q <= counter_q + 1;
        end
      end
    end
  end

  // bypass in testmode
  assign o_clock = testmode ? i_clock : clock_q;
endmodule
