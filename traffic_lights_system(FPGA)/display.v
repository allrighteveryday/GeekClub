
module display
(
    input wire[5:0]         num,
    output wire[13:0]       display_num
);

wire[3:0]            num1; //十位
wire[3:0]            num2; //个位
wire[6:0]            display_ten; //个位展示
wire[6:0]            display_one; //十位展示  

//获得十位
assign num1 = num / 10;

//获得个位
assign num2 = num % 10;

//显示十位
one_display diaplay1
(
    .num(num1),
    .display_num(display_ten)
);

//显示个位
one_display diaplay2
(
    .num(num2),
    .display_num(display_one)
);

assign display_num = {display_ten, display_one};

endmodule