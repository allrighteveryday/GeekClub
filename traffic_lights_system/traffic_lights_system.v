
module traffic_lights_system(
    clk, //50MHz,20ns
    rst_n,
    light_N,
    light_S,
    light_E,
    light_W
    );
    
//////////引脚定义//////////
input                   clk;
input                   rst_n;
//每个方向的红绿灯有三个数据位，分别代表红、绿、黄灯且1表示亮0表示灭
output reg[2:0]         light_N;
output reg[2:0]         light_S;
output reg[2:0]         light_E;
output reg[2:0]         light_W;

//////////持续时间定义//////////
parameter       TIME_LONG  = 36'd30_000_000_000 / 20; // 30秒
parameter       TIME_SHORT = 36'd 3_000_000_000 / 20; // 3秒

//////////状态空间定义//////////
parameter       S0 = 4'b0000; //初始状态
parameter       S1 = 4'b0001; //状态1
parameter       S2 = 4'b0010; //状态2
parameter       S3 = 4'b0100; //状态3
parameter       S4 = 4'b1000; //状态4

reg[3:0]                state; //状态变量
reg[36:0]               cnt;   //定时器

//////////状态机//////////
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin //复位时回到初始状态，并且定时器置0
        state <= S0;
        cnt <= 'b0;
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
                if (cnt < TIME_LONG - 1)begin
                    light_N <= 3'b100;
                    light_S <= 3'b100;
                    light_E <= 3'b010;
                    light_W <= 3'b010;
                    
                    cnt <= cnt + 1'b1; //定时器自增                    
                    state <= S1; //维持当前状态
                end
                else begin
                    cnt <= 'b0; //定时器置0
                    state <= S2; //切换至下一状态
                end
            end
                    
            S2 : begin //状态2：南北红灯，东西黄灯
                if (cnt < TIME_SHORT - 1)begin
                    light_N <= 3'b100;
                    light_S <= 3'b100;
                    light_E <= 3'b001;
                    light_W <= 3'b001;
                    
                    cnt <= cnt + 1'b1;  
                    state <= S2;                    
                end
                else begin
                    cnt <= 'b0;
                    state <= S3;
                end
            end
                    
            S3 : begin //状态3：南北绿灯，东西红灯
                if (cnt < TIME_LONG - 1)begin
                    light_N <= 3'b010;
                    light_S <= 3'b010;
                    light_E <= 3'b100;
                    light_W <= 3'b100;
                    
                    cnt <= cnt + 1'b1;           
                    state <= S3;
                end
                else begin
                    cnt <= 'b0;
                    state <= S4;
                end
            end
                    
            S4 : begin //状态2：南北黄灯，东西红灯
                if (cnt < TIME_SHORT - 1)begin
                    light_N <= 3'b001;
                    light_S <= 3'b001;
                    light_E <= 3'b100;
                    light_W <= 3'b100;
                    
                    cnt <= cnt + 1'b1;
                    state <= S4;
                end
                else begin
                    cnt <= 'b0;
                    state <= S1;
                end
            end
                    
            default : begin
                state <= S0;
                cnt <= 'b0;
            end
        
        endcase
    end
end
     
endmodule     
                
