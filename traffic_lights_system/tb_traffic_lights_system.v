`timescale 1ns/1ns

module tb_traffic_lights_system();

reg                 clk;
reg                 rst_n;
wire[2:0]           light_N; 
wire[2:0]           light_S;
wire[2:0]           light_E;
wire[2:0]           light_W;

//实例化交通灯控制系统
traffic_lights_system test(
    .clk(clk),
    .rst_n(rst_n),
    .light_N(light_N),
    .light_S(light_S),
    .light_E(light_E),
    .light_W(light_W)
    );
    
//产生时钟信号
initial begin
    clk <= 0;
    forever begin
        # 10;
        clk = ~clk;
    end
end

//产生复位信号
initial begin
    rst_n <= 0;
    # 2000;
//    rst_n <= 1;
//   # 64'd50000000000;
//    rst_n <= 0;
//    # 2000;
    rst_n <= 1;
end

//监视
initial begin
    $monitor(" light_N is %b at %0dns \n light_S is %b at %0dns \n light_E is %b at %0dns \n light_W is %b at %0dns \n\n\n ", light_N, $time, light_S, $time, light_E, $time, light_W, $time);


end

endmodule


