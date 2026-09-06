`timescale 1ns/1ps

module tb_sequence_detector_1101_overlapping;

    reg clk;
    reg reset;
    reg din;

    wire detected;

    sequence_detector_1101_overlapping DUT (
        .clk(clk),
        .reset(reset),
        .din(din),
        .detected(detected)
    );

    always #5 clk = ~clk;

    task send_bit;
        input bit_value;
        begin
            din = bit_value;
            #10;
        end
    endtask

    initial begin
        $dumpfile("sequence_detector_1101_overlapping.vcd");
        $dumpvars(0, tb_sequence_detector_1101_overlapping);
        clk = 0;
        reset = 1;
        din = 0;
        #10;
        reset = 0;
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(1);

        send_bit(1);
        send_bit(0);
        send_bit(1);
        #10;
        $finish;

    end

endmodule