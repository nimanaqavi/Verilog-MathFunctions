`timescale 1ps/1ps
module part_Ln_TB ();
    reg clk , rst , start ;
    reg [15:0] Xbus ;
    wire Ready ;
    wire [17:0] RBUS;
    part_Ln_TOP uut( clk , rst , start , Xbus , Ready , RBUS);
    always #5 clk=~clk;
    initial begin
        clk = 0 ;
        rst = 1 ;
        #12 
        rst=0 ;
        start =1 ;
        Xbus=16'h8000;  // 1/2
        #10
        start=0;
        #300
        rst = 1 ;
        #10
        rst=0 ;
        start =1 ;
        Xbus=16'h0000;  // 0
        #10
        start=0;
        #300
        rst = 1 ;
        #10
        rst=0 ;
        start =1 ;
        Xbus=16'h4000;  // 1/4
        #10
        start=0;
        #300
        $stop;
    end
endmodule
