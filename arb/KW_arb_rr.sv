`default_nettype none

module KW_arb_rr_internal #(
  parameter int N = 4
) (
  input logic clock,
  input logic reset_n,

  input  logic [N-1:0] request,
  output logic [N-1:0] grant
);
  generate
    if (N == 1) begin
      // For 1 request, always grant
      assign grant = request;
    end else begin
      // Update priority
      logic [N-1:0] priority_;
      always_ff @(posedge clock or negedge reset_n) begin
        if (!reset_n) begin
          priority_ <= 'b1;
        end else begin
          // If there's any grants, rotate the priority
          // Otherwise, keep old value
          priority_ <= |grant ? {grant[N-2:0], grant[N-1]} : priority_;
        end
      end

      // Replicate the internal arbiter structure to allow wrapping
      logic [2*N-1:0] req2, pri2, gnt2;
      assign req2 = {request, request};
      assign pri2 = {{N{1'b0}}, priority_};
      assign gnt2 = req2 & ~(req2 - pri2); // TODO: check how this synthesizes

      // Output is the logical or of both halves of the inputs
      assign grant = gnt2[N-1:0] | gnt2[2*N-1:N];

`ifdef VERILATOR
      always_comb assert (~|priority_ || ~|request || $onehot(grant))
        else $error("grant must be onehot (was %b)", grant);
      assert property (@(negedge clock) $onehot(priority_))
        else $error("priority_ must be onehot (was %b)", priority_);
`endif
    end
  endgenerate
endmodule

module KW_arb_rr_lock_internal #(
  parameter int N = 4
) (
  input logic clock,
  input logic reset_n,

  input  logic [N-1:0] grant_c,
  input  logic [N-1:0] request,
  input  logic [N-1:0] lock,
  output logic [N-1:0] grant,
  // Flags
  output logic locked
);
  // Hold logic
  logic [N-1:0] last;
  always_ff @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
      last <= {N{1'b0}};
    end else begin
      last <= grant;
    end
  end

  // hold the grant if grant was set last cycle, lock is active
  // and the request is still active
  assign locked = |(last & lock & request);
  assign grant = locked ? last : grant_c;
endmodule

module KW_arb_rr #(
  parameter int N = 4
) (
  input logic clock,
  input logic reset_n, // Reset, active low, ASYNC

  input  logic [N-1:0] request, // Requests from clients
  input  logic [N-1:0] mask,    // Mask for the request vector.
                                // Masked requests (mask[i] == 1) are not
                                // considered during arbitration
  input  logic [N-1:0] lock,    // Lock the current request
  output logic [N-1:0] grant,   // Granted requests

  // Flags
  output logic parked,  // Indicates there are no requesting clients
  output logic granted, // Indicates the arbiter issued a grant
  output logic locked   // Indicates the arbiter is locked
);
  // Mask off the request vector
  wire [N-1:0] masked_request = request & ~mask;

  // Compute conditional grant values
  logic [N-1:0] grant_c;
  KW_arb_rr_internal #(.N(N)) arb_rr_internal_inst (
    .clock(clock),
    .reset_n(reset_n),
    .request(masked_request),
    .grant(grant_c)
  );

  // Compute current grant using lock
  KW_arb_rr_lock_internal #(.N(N)) arb_rr_lock_internal_inst (
    .clock(clock),
    .reset_n(reset_n),
    .request(masked_request),
    .grant_c(grant_c),
    .lock(lock),
    .grant(grant),
    .locked(locked)
  );

  // Compute flags
  assign granted = |masked_request;
  assign parked  = ~|masked_request;
endmodule
