`timescale 1ns/1ns

//功能描述：在使能信号下，计算输入脉冲的每两个上升沿之间的时钟周期数并输出，即输出脉冲频率计数值。
//注意：输入脉冲的第一个上升沿滤掉。

module frequency_counter(
    clk,
    rst_n,
    en,
    pulse,
    o_vld,
    o_cnt
    );
    
input               clk;
input               rst_n;
input               en; //使能信号
input               pulse; //输入脉冲
output              o_vld; //表示计数的有效输出
output[15:0]        o_cnt; //计数器

//////////实例化脉冲边沿检测模块//////////
wire                 rise_edge; //脉冲上升沿检测输出
pulse_posedge_detection pos_dete(
    .clk(clk),
    .rst_n(rst_n),
    .i_pulse(pulse),
    .o_edge(rise_edge)
    );

//////////滤掉第一个上升沿（对o_vld）//////////
reg                 flag; //定义一个标记信号。
always@(posedge clk) begin
    if(!rst_n) flag <= 'b0;
    else if(!en) flag <= 'b0;
    else if (rise_edge) flag <= 1'b1; //pulse第一个上升沿来的适合，flag信号拉高
    else ; // 锁存flag
end

assign o_vld = rise_edge & flag; //实际计算信号为输入信号与标记信号

//////////开始频率计数（对o_cnt）//////////
reg[15:0]           r_cnt; //定义一个内部计数器
always@(posedge clk)begin
    if(!rst_n) r_cnt <= 'b0;
    else if(!en) r_cnt <= 'b0;
    else if(rise_edge) r_cnt <= 'b0; //上升沿来时计数器置0
    else r_cnt <= r_cnt + 1'b1; //其他时间在计数
end

assign o_cnt = r_cnt + 1'b1; //输出计数值等于内部计数器加1

endmodule
    
    
    

   
