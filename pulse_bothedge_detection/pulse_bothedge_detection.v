`timescale 1ns/1ns

module pulse_bothedge_detection(
    clk,
    rst_n,
    i_pulse,
    o_edge
    );
    
input           clk;
input           rst_n;
input           i_pulse;
output          o_edge;

wire            clk;
wire            rst_n;
wire            i_pulse;
wire            o_edge;
wire            i_posedge;
wire            i_negedge;
reg             preg1;
reg             preg2;
    
//每一个时钟上升沿来时，preg1对输入脉冲采样，preg2对preg1采样
always@(posedge clk)begin
    if(!rst_n) begin 
        preg1 <= 0;
        preg2 <= 0;
    end
    else begin 
        preg1 <= i_pulse;
        preg2 <= preg1;
    end
end

//检测结果为：上升沿或下降沿
assign  i_posedge = preg1 & (~ preg2); 
assign  i_negedge = preg2 & (~ preg1);
assign  o_edge = i_posedge | i_negedge;


endmodule