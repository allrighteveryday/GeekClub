`timescale 1ns/1ns

module pulse_counter(
    clk,
    rst_n,
    pulse,
    en,
    cnt
    );
    
    
input           clk;   
input           rst_n;
input           pulse;
input           en;
output          cnt;

wire            clk;
wire            rst_n;
wire            pulse;
wire            en;
wire            i_posedge;
reg[31:0]       cnt;

pulse_posedge_detection test( 
    .clk(clk),
    .rst_n(rst_n),
    .i_pulse(pulse),
    .o_edge(i_posedge)
    );

always@(*)begin
    if(!rst_n) cnt = 'b0;
    else if(en)
        if(i_posedge) cnt = cnt + 1'b1;
        else cnt = cnt;
    else cnt = 'b0;

end

    
endmodule
    
    