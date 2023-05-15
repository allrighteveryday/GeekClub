`timescale 1ns/1ns

module tb_frequency_counter();

reg             clk;
reg             rst_n;
reg             en;
reg             pulse;
wire            o_vld;
wire[15:0]      o_cnt;

//实例化频率计数器
frequency_counter test(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .pulse(pulse),
    .o_vld(o_vld),
    .o_cnt(o_cnt)
    );

//定义时钟信号
initial begin
    clk <= 0;
    forever begin
    # 5;
    clk = ~clk;
    end
end

//定义复位信号
initial begin
    rst_n <= 0;
    # 2500;
    rst_n <= 1;
end

//定义使能信号
initial begin
    en <= 0;
    forever begin
    # 3000;
    en <= ~en;
    end
end

//定义脉冲
initial begin
    pulse <= 0;
    forever begin
        # (({$random} % 100) + 50);
        pulse = ~pulse;
    end
end

endmodule