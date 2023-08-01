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
    always@(posedge clk)begin // syncronous 동작
        //clock_in_hibit이 LOW일 때 동작 HIGH이면 값을 유지하고 동작 정지 
        if(!clock_in_hibit)begin 
            if(shift_load)begin // 0일 때 shift_mode 병렬 입력 차단 
                store <= (store << 1) | serial_in; 
                //store의 LSB bit를 1칸 shift한 한 후 Serial_in과의
                //OR연산을 통해 serial_in의 입력을 LSB에 대입
            end
            if(!shift_load)begin // 0일 때 load_mode 병렬 입력
                                 // 클럭과 Don't care이기 때문에 클럭과 동기 시켜도 무관
            store <= q;
        end
            qh <= store[7];
        end
    end
    assign qh_bar = ~qh;
endmodule
