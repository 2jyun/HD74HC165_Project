`timescale 1ns / 1ps

module HD74HC165(clk, clock_in_hibit, serial_in, q, shift_load, qh, qh_bar);
    input shift_load;
    input clk;
    input clock_in_hibit;
    input serial_in;
    input [7:0] q;
    output qh;
    output qh_bar;
    wire qh_bar;
    reg qh;
    reg [7:0] store = 8'b0000_0000;
    always@(posedge clk)begin // syncronous ����
        //clock_in_hibit�� LOW�� �� ���� HIGH�̸� ���� �����ϰ� ���� ���� 
        if(!clock_in_hibit)begin 
            if(shift_load)begin // 0�� �� shift_mode ���� �Է� ���� 
                store <= (store << 1) | serial_in; 
                //store�� LSB bit�� 1ĭ shift�� �� �� Serial_in����
                //OR������ ���� serial_in�� �Է��� LSB�� ����
            end
            if(!shift_load)begin // 0�� �� load_mode ���� �Է�
                                 // Ŭ���� Don't care�̱� ������ Ŭ���� ���� ���ѵ� ����
            store <= q;
        end
            qh <= store[7];
        end
    end
    assign qh_bar = ~qh;
endmodule
