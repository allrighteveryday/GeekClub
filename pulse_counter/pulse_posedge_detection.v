`timescale 1ns/1ns

module pulse_posedge_detection(
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
wire             o_edge;
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

//检测结果为：preg1与preg2取反
assign  o_edge = preg1 & (~ preg2); 
//assign 等号左值需为wire型

endmodule
