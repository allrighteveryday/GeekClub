`timescale 1ns/1ns

module four_bit_gray_code_counter(
    clk,  //输入时钟50MHz,即20ns
    rst_n,
    o_gray_cnt,
    );

//一秒定时器计数上限 1s/20ns =几个时钟周期计数至1s
parameter               TIMER_MAX = 32'd1000000000/20;

input                   clk;
input                   rst_n;
output wire[3:0]        o_gray_cnt;

//////////1s定时器//////////
reg[31:0]               time_cnt; //定时器定义

always@(posedge clk)begin 
    if(!rst_n) time_cnt <= 'b0;
    else if(time_cnt < TIMER_MAX - 1) time_cnt <= time_cnt + 1;
    else time_cnt <= 'b0;
end

//0
//1
//2
//3
//......
//TIMER_MAX-1
//总共计数 TIMER_MAX 次

//////////4位二进制计数器//////////
reg[3:0]                b_cnt;

always@(posedge clk)begin
    if(!rst_n) b_cnt <= 'b0;
    else if(time_cnt == TIMER_MAX-1) b_cnt <= b_cnt + 1; //每秒 b_cnt 自增 1
    else ;
end

//////////格雷码转换器//////////
reg[3:0]                    r_gray; //格雷码转换
                    
always@(*)begin
    if(!rst_n) r_gray <= 'b0;
    else begin
        case(b_cnt)
                4'b0000 : r_gray <= 'b0000;
                4'b0001 : r_gray <= 'b0001;
                4'b0010 : r_gray <= 'b0011;
                4'b0011 : r_gray <= 'b0010;
                4'b0100 : r_gray <= 'b0110;
                4'b0101 : r_gray <= 'b0111;
                4'b0110 : r_gray <= 'b0101;
                4'b0111 : r_gray <= 'b0100;
                4'b1000 : r_gray <= 'b1100;
                4'b1001 : r_gray <= 'b1101;
                4'b1010 : r_gray <= 'b1111;
                4'b1011 : r_gray <= 'b1110;
                4'b1100 : r_gray <= 'b1010;
                4'b1101 : r_gray <= 'b1011;
                4'b1110 : r_gray <= 'b1001;
                4'b1111 : r_gray <= 'b1000;
                default : ; //别忘了
        endcase //别忘了
    end
end

//////////格雷码输出//////////
assign o_gray_cnt = r_gray;


endmodule













