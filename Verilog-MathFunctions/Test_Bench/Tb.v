`timescale 1ps/1ps
module part_TB ();             // تست بچ برای اینکه تست کنم ببینم ترم های دارای فاکتوریل و توان های  ورودی درسته
    reg clk , rst , start ;
    reg [15:0] Xbus ;
    wire Done ;
    wire[15:0] Tbus;

    part_1_TOP uut( clk , rst , start , Xbus ,  Tbus , Done);
    always #5 clk=~clk;
    initial begin
        clk = 0 ;
        rst = 1 ;
        #12 
        rst=0 ;
        start =1 ;
        Xbus=16'h8000;
        #10
        start=0;
        #300
        rst = 1 ;
        #10
        rst=0 ;
        start =1 ;
        Xbus=16'hFFFF;
        #10
        start=0;
        #300
        $stop;
    end
    
endmodule
