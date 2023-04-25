`timescale 1ns/1ns

module tb_CLK_1MHZ();

reg		clk;
reg		rst_n;
wire     	out_clk;

parameter   CYCLE = 10;

CLK_1MHZ TEST_CLK
(
    .clk(clk),
    .rst_n(rst_n),
    .out_clk(out_clk)
);

//产生100MHz的时钟信号
initial begin
    clk  <= 0;
    forever
    # (CYCLE/2) clk = ~clk;
end

//复位信号
initial begin 
    rst_n <= 0;
    # 1000;
    rst_n <= 1;
end


endmodule
    
