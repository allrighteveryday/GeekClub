`timescale 1ns/1ns

module tb_four_bit_gray_code_counter();

reg                 clk;
reg                 rst_n;
wire[3:0]           o_gray_cnt;

//实例化待测模块
four_bit_gray_code_counter test(
    .clk(clk),
    .rst_n(rst_n),
    .o_gray_cnt(o_gray_cnt)
    );

//定义时钟（产生以20ns为周期的时钟信号）
initial begin
    clk <= 0;
    forever begin
        # 10;
        clk = ~clk;
    end
end

//定义复位信号
initial begin
    rst_n <= 0;
    # 2000;
    rst_n <= 1;
end

//监视
initial begin
    @(posedge rst_n) //等待复位完成
    $monitor("o_gray_cnt is %b at %0dns",o_gray_cnt, $time);
end

endmodule