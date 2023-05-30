
module one_display
(
    input wire[3:0]         num,
    output reg[6:0]         display_num
);

always@(*)begin
    case(num)
        'd0 : display_num = 7'b0000001;
        'd1 : display_num = 7'b1001111;
        'd2 : display_num = 7'b0010010;
        'd3 : display_num = 7'b0000110;  
        'd4 : display_num = 7'b1001100;
        'd5 : display_num = 7'b0100100;  
        'd6 : display_num = 7'b0100000;
        'd7 : display_num = 7'b0001111; 
        'd8 : display_num = 7'b0000000;
        'd9 : display_num = 7'b0000100;         
    endcase
end

endmodule