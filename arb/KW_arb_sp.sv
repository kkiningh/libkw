`default_nettype none

module KW_arb_sp_internal #(
  parameter int N = 4,
  parameter int PRIORITY = 0
) (
  input  logic [N-1:0] request,
  output logic [N-1:0] grant
);
  generate
    if (N == 1) begin
      // For 1 request, always grant
      assign grant = request;
    end else begin
      logic [N-1:0] request_rotated, grant_rotated;
      // Rotate the request left so that bit PRIORITY is in the 0th position
      KW_rol_static #(.WIDTH(N), .ROL(PRIORITY)) KW_rol_static_inst (
        .a(request),
        .b(request_rotated)
      );

      // Zero all but the first set bit
      assign grant_rotated = request_rotated & -request_rotated;

      // Rotate the request right so that bit 0 is in PRIORITY position
      KW_ror_static #(.WIDTH(N), .ROR(PRIORITY)) KW_ror_static_inst (
        .a(grant_rotated),
        .b(grant)
      );
    end
  endgenerate
endmodule

module KW_arb_sp_lock_internal #(
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

module KW_arb_sp #(
  parameter int N = 4,
  parameter int PRIORITY = 0
) (
  input logic clock,
  input logic reset_n,

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
  KW_arb_sp_internal #(.N(N), .PRIORITY(PRIORITY)) arb_sp_internal_inst (
    .request(masked_request),
    .grant(grant_c)
  );

  // Compute current grant using lock
  KW_arb_sp_lock_internal #(.N(N)) arb_sp_lock_internal_inst (
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
