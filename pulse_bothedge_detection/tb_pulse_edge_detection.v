`timescale 1ns/1ns

module tb_pulse_edge_detection();

reg         clk;
reg         rst_n;
reg         i_pulse;
wire        o_posedge;
wire        o_negedge;
wire        o_bothedge;

pulse_posedge_detection test_pos(
    .clk(clk),
    .rst_n(rst_n),
    .i_pulse(i_pulse),
    .o_edge(o_posedge)
    );
    
pulse_negedge_detection test_neg(
    .clk(clk),
    .rst_n(rst_n),
    .i_pulse(i_pulse),
    .o_edge(o_negedge)
    );

pulse_bothedge_detection test_both(
    .clk(clk),
    .rst_n(rst_n),
    .i_pulse(i_pulse),
    .o_edge(o_bothedge)
    );

    
//产生时钟信号
initial begin
    clk <= 0;
    forever 
    # 5 clk = ~ clk;
end

//产生复位信号
initial begin
    rst_n <= 0;
    # 1000;
    rst_n <= 1;
end
    
//产生待测脉冲
initial begin
    i_pulse <= 0;
    # 2266;
    i_pulse <= 1;
    # 1166;
    i_pulse <= 0;
    # 66;
    i_pulse <= 1;
    # 1166;
    i_pulse <= 0;
    # 2266;
    i_pulse <= 1;
end

endmodule
    
