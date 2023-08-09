`timescale 1ns / 1ps

module tb_HD74HC165();
    reg shift_load;
    reg clk;
    reg clock_in_hibit;
    reg serial_in;
    reg [7:0] q;
    wire qh;
    wire qh_bar;
    HD74HC165 U0 (.shift_load(shift_load), .qh(qh), .qh_bar(qh_bar), .clk(clk), .clock_in_hibit(clock_in_hibit), .serial_in(serial_in), .q(q));
    always begin
        #5 clk = ~clk;
    end

    initial begin
        //default Value
        clk = 0;
        shift_load = 1;
        clock_in_hibit = 0;
        serial_in = 0;
        q = 8'b0000_0000;
        $monitor("Time:%d [ns], Qh: %d ", $time(), qh);
        $monitor("Time:%d [ns], Qh_bar: %d", $time(), qh_bar);
    end

    initial begin
        //Shift mode with serial Input
        serial_in <= 1; // Serial Input
        repeat (8) @(posedge clk); // clock�� 8Ŭ�� �Է� �� FF�Է�
        serial_in <= 0;
        repeat (9) @(posedge clk); // clock�� 9Ŭ�� ���� FF�� �������� ���Ȯ��

        //load Mode parallel Input
        shift_load <= 0;
        q <= 8'b1010_1010;
        @(posedge clk);
        shift_load <= 1;
        repeat (8) @(posedge clk); // clock�� 8Ŭ�� ���� ����Ʈ ��� Ȯ��

        // Shift mode with clock_in_hibit HIGH ���� ����
        clock_in_hibit <= 1;
        serial_in <= 1;
        repeat (8) @(posedge clk);
        clock_in_hibit <= 0;
        serial_in <= 0;
        repeat (8) @(posedge clk);

        // Load mode with parallel input (different value)
        shift_load <= 0;
        q <= 8'b1100_1100;
        @(posedge clk);
        shift_load <= 1;
        repeat (8) @(posedge clk);
        $finish; //Done
    end

endmodule
