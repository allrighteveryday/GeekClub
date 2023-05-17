# 状态机（state machine）

### 定义

在有限个状态之间按一定规律转换的时序电路

### Mealy状态机

模型图：![mealy状态机](mealy%E7%8A%B6%E6%80%81%E6%9C%BA.png)

![mealy状态机](../mealy%E7%8A%B6%E6%80%81%E6%9C%BA.png)

+ 状态寄存器：由一组触发器组成，用来记忆状态机当前所处的状态。状态的改变**只发生在时钟跳变沿**。

+ 状态是否改变，如何改变，取决于**组合逻辑F**的输出。F是当前状态与输入信号的函数。

+ 状态机的输出是由**输出逻辑G**提供的。G也是当前状态和输入信号的函数。

+ Moore状态机模型图如下（输出不受输入影响）

![moore状态机](moore%E7%8A%B6%E6%80%81%E6%9C%BA.png)

### 状态机的设计

1. 状态空间定义
2. 状态跳转
3. 下个状态判断
4. 各个状态下的动作

#### 状态空间的定义

用二进制数表示所有状态

```verilog
//编码方式一
//define state space
parameter	SLEEP	=	2'b00;
parameter	STUDY	=	2'b01;
parameter	EAT		=	2'b10;
parameter	AMUSE	=	2'b11;

//internal variable
reg[1:0]	current_state;
reg[1:0]	next_state

//编码方式二
//define state space
parameter	SLEEP	=	4'b1000;
parameter	STUDY	=	4'b0100;
parameter	EAT		=	4'b0010;
parameter	AMUSE	=	4'b0001;
ji
//internal variable
reg[3:0]	current_state;
reg[3:0]	next_state

//注：编码方式二为独热码。每个状态只有一个寄存器置位，译码逻辑简单

```

#### 状态跳转（时序逻辑）

```verilog
//transition
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        current_state <= SLEEP; //复位状态即初始状态
    else
        current_state <= next_state; //不是复位状态下，赋值下一个状态
end
    
```

#### 下一个状态判断（组合逻辑）

组合逻辑G

```verilog
//next state decision
always @ (current_state or input_signals) begin
    case (current_state)
        SLEEP: begin
            if (clock_alarm)
                next_state = STUDY;
            else 
                next_state = SLEEP
        end
        SYUDY: begin
            if (lunch_time)
                next_state = EAT;
            else
                next_state = STUDY;
        //if/else要配对以避免锁存器的产生
        end
        EAT:    ......;
        AMUSE:  ......;
        default:......;
    endcase
 end
        
```

#### 各个状态下动作

```verilog
//action

wire read_book;
assign read_book = (current_state == STUDY) ? 1'b1 : 1'b0;

//表示二（动作比较复杂）
always@(current_state) begin
    if(current_state == STUDY)
        read_book = 1;
    else
        read_book = 0;
end
```





