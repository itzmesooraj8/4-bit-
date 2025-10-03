`timescale 1ns / 1ps

// Counter implemented using D flip-flops (parameterized width)
module counter #(
    parameter WIDTH = 4
) (
    input  wire                 clk,
    input  wire                 reset,
    output wire [WIDTH-1:0]     q
);

    // Internal wires for D inputs
    wire [WIDTH-1:0] d;

    // Simple combinational logic for next-state (binary increment)
    // d = q + 1
    assign d = q + 1'b1;

    // Instantiate D flip-flops
    genvar gi;
    generate
        for (gi = 0; gi < WIDTH; gi = gi + 1) begin : DFFS
            dff u_dff (
                .clk(clk),
                .reset(reset),
                .d(d[gi]),
                .q(q[gi])
            );
        end
    endgenerate

    // No internal sequential copy needed: DFF outputs `q` hold the state

endmodule
