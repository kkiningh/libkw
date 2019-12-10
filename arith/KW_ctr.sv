`default_nettype none

module KW_ctr #(
  parameter int unsigned WIDTH
) (
  input  logic clock,
  input  logic reset_n,
  input  logic cen,
  output logic [WIDTH-1:0] count
);
  always_ff @(posedge clock or negedge reset_n) begin
    if (~reset_n) begin
      count <= {WIDTH{1'b0}};
    end else if (cen) begin
      count <= count + 'd1;
    end
  end
endmodule
