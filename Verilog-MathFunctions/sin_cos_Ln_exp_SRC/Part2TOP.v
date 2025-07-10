module part_2_TOP (input clk , rst , start , input [1:0] MOD , input [15:0] Xbus , output Ready , output [17:0] RBUS);

    wire ldE ,  init_E1,init_E2 , Done ,Done1 , Done2 , co ;
    wire [2:0] count ;
    wire [17:0] out1 , out2 ;
    reg [17:0] Final_output ;
    reg Ready1;
    part_2_DP uut1( clk , rst , start , ldE , init_E1,init_E2 , Xbus , MOD , Done , co , count , out1 );     // برای توابع e , cos , sin
    part_2_CO uut2(  clk , rst , start , Done , co , MOD , count , Done1 , ldE , init_E1,init_E2 );
    part_Ln_TOP uut3( clk , rst , start , Xbus , Done2 , out2 );                                           //  برای تابع ln(1+x)
    always @( Done1 , Done2 , out1 , out2 ) begin
        case (MOD)
           0 : begin 
            Final_output = out1 ; Ready1 = Done1 ;
           end
           1 : begin 
            Final_output = out1 ; Ready1 = Done1 ;
           end
           2 : begin 
            Final_output = out1 ; Ready1 = Done1 ;
           end
           3 : begin 
            Final_output = out2 ; Ready1 = Done2 ;
           end

        endcase
        
    end
    assign RBUS = Final_output ;
    assign Ready = Ready1 ;
endmodule
