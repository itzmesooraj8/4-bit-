`timescale 1ns / 1ps

// Self-checking testbench for the parameterized counter
module tb_counter;

    parameter WIDTH = 4;
    localparam MAX_COUNT = (1<<WIDTH);

    reg clk = 0;
    reg reset;
    wire [WIDTH-1:0] q;

    // Device under test
    counter #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    // VCD dump
    initial begin
        $dumpfile("counter_waveform.vcd");
        $dumpvars(0, tb_counter);
    end

    // Self-checking sequence
    integer i;
    reg error;
    reg [WIDTH-1:0] expected;

    initial begin
        // Initialize
        error = 0;
        expected = 0;
        reset = 1;

        // Hold reset for a bit > one clock edge
        #12;
        @(negedge clk);
        reset = 0; // release reset

        // Allow a few clock cycles and check sequence
        for (i = 0; i < (MAX_COUNT + 4); i = i + 1) begin
            @(posedge clk);
            #1; // wait for signals to settle
            // The counter increments on the posedge, so advance expected first
            expected = expected + 1'b1;
            $display("Time %0t: q = %0d (expected %0d)", $time, q, expected);
            if (q !== expected) begin
                $display("ERROR at time %0t: q=%0d expected=%0d", $time, q, expected);
                error = 1;
            end
        end

        if (!error) begin
            $display("\nTEST PASSED: Counter incremented correctly for %0d cycles", i);
        end else begin
            $display("\nTEST FAILED: See ERROR messages above");
        end

        // Give time for dump then finish
        #5;
        $finish;
    end

endmodule
