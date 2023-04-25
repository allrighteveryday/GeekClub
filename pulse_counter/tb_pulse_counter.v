`timescale 1ns/1ns

module tb_pulse_counter();

reg             clk;
reg             rst_n;
reg             pulse;
reg             en;
wire[31:0]      cnt;    

pulse_counter test(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .pulse(pulse),
    .cnt(cnt)
    );
    
initial begin
    clk <= 0;
    forever
    # 5 clk = ~ clk;
end

initial begin
    rst_n <= 0;
    # 1000;
    rst_n <= 1;
end

initial begin 
    en <= 0;
    # 500;
    en <= 1;
    # 2000;
    en <= 0;
    # 500;
    en <= 1;
end

reg[10:0]           A;
reg[10:0]           B;

//注：$random 要用{}
initial begin
    forever begin
    pulse <= 0;
    A = ({$random} % 600) + 30;
    # A;
    pulse <= 1;
    B = ({$random} % 600) + 30;
    # B;
    end
end



endmodule