
module traffic_lights_system(
    clk, //50MHz,20ns
    rst_n,
    o_led, //输出控制 板子上的灯的亮灭
    o_display //输出控制 板子上的数码管
    );
    
//////////引脚定义//////////
input            clk;
input            rst_n;
output           o_led;
output           o_display;

//每个方向的红绿灯有三个数据位，分别代表红、绿、黄灯且1表示亮0表示灭
reg[2:0]         light_N;
reg[2:0]         light_S;
reg[2:0]         light_E;
reg[2:0]         light_W;
wire[11:0]       o_led;
wire[13:0]       o_display;
reg              clk_1s; //1s时钟分频脉冲

//////////参量定义//////////
parameter        TIME_1S    = 36'd 1_000_000_000 / 20; // 1秒


//////////状态空间定义//////////
parameter        S0 = 4'b0000; //初始状态
parameter        S1 = 4'b0001; //状态1
parameter        S2 = 4'b0010; //状态2
parameter        S3 = 4'b0100; //状态3
parameter        S4 = 4'b1000; //状态4

reg[3:0]                state; //状态变量
reg[36:0]               cnt;   //定时器
reg[5:0]                cnt2;  //定时器2

//调用display模块（在开发板上展示计数过程）
display display(
    .num(cnt2),
    .display_num(o_display)
    );
    
//////////1秒分频//////////
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) cnt <= 36'b0;
    else if (cnt < TIME_1S - 1) cnt <= cnt + 1'b1;
    else cnt <= 36'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) clk_1s <= 1'b0;
    else if (cnt < TIME_1S/2) clk_1s <= 1'b1;
    else clk_1s <= 1'b0;
end

//////////状态机//////////
always@(posedge clk_1s or negedge rst_n)begin
    if(!rst_n)begin //复位时回到初始状态，并且定时器置0
        state <= S0;
        cnt2 <= 'b0;
    end
    else begin
        case(state)
            S0 : begin //初始状态：全亮
                light_N <= 3'b111;
                light_S <= 3'b111;
                light_E <= 3'b111;
                light_W <= 3'b111;
                
                state = S1;
            end
            
            S1 : begin //状态1：南北红灯，东西绿灯
                if (cnt2 < 30 - 1)begin
                    light_N <= 3'b100;
                    light_S <= 3'b100;
                    light_E <= 3'b010;
                    light_W <= 3'b010;
                    
                    cnt2 <= cnt2 + 1'b1; //定时器自增                    
                    state <= S1; //维持当前状态
                end
                else begin
                    cnt2 <= 'b0; //定时器置0
                    state <= S2; //切换至下一状态
                end
            end
                    
            S2 : begin //状态2：南北红灯，东西黄灯
                if (cnt2 < 5 - 1)begin
                    light_N <= 3'b100;
                    light_S <= 3'b100;
                    light_E <= 3'b001;
                    light_W <= 3'b001;
                    
                    cnt2 <= cnt2 + 1'b1;  
                    state <= S2;                    
                end
                else begin
                    cnt2 <= 'b0;
                    state <= S3;
                end
            end
                    
            S3 : begin //状态3：南北绿灯，东西红灯
                if (cnt2 < 30 - 1)begin
                    light_N <= 3'b010;
                    light_S <= 3'b010;
                    light_E <= 3'b100;
                    light_W <= 3'b100;
                    
                    cnt2 <= cnt2 + 1'b1;           
                    state <= S3;
                end
                else begin
                    cnt2 <= 'b0;
                    state <= S4;
                end
            end
                    
            S4 : begin //状态2：南北黄灯，东西红灯
                if (cnt2 < 5 - 1)begin
                    light_N <= 3'b001;
                    light_S <= 3'b001;
                    light_E <= 3'b100;
                    light_W <= 3'b100;
                    
                    cnt2 <= cnt2 + 1'b1;
                    state <= S4;
                end
                else begin
                    cnt2 <= 'b0;
                    state <= S1;
                end
            end
                    
            default : begin
                state <= S0;
                cnt2 <= 'b0;
            end
        
        endcase
    end
end

assign o_led = {light_N, light_S, light_E, light_W};
     
endmodule     
                
