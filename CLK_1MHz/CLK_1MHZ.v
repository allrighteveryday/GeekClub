//输入时钟100MHz，产生一个1MHz低频时钟
`timescale 1ns/1ns

module CLK_1MHZ(
    clk,
    rst_n,
    out_clk
    );
    
parameter   MAX = 8'd100;

input   clk;
input   rst_n;
output  out_clk;

//注：input只能用wire型信号
wire         clk;
wire         rst_n;
reg          out_clk;
reg[7:0]     cnt = 8'b0;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) out_clk <= 1'b0;
    else if (cnt < MAX - 1) cnt <= cnt + 1'b1; // 小于99则+1 （产生0~99的数 => 计数100次）*计数
    else cnt <= 8'b0;
end

//0~49 out_clk为1，50~99 out_clk为0
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) out_clk <= 1'b0;
    else if (cnt < MAX/2) out_clk <= 1'b1; //0-49为1，50-99为0
    else out_clk <= 1'b0;
end
// 47-> 1
// 48-> 1
// 49-> 1
// 50-> 0
// 51-> 0
// 52-> 0
// ......
// 98-> 0
// 99-> 0
// 100/0->1
endmodule