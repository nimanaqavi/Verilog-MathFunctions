module part_1_TOP (input clk , rst , start , input [15:0] Xbus , output [15:0] Tbus , output Done , co , output [2:0] count );       //   خروجی ترم ها
    wire ldx , ldt , init_t , init_counter , counter_en , select ;
    
    part_1 par1(clk , rst , ldx , ldt , Init_t , init_counter , counter_en , select , Xbus ,  Tbus ,  co , count );

    part_1CO par2( clk , rst , start , co,  ldx , ldt , Init_t , counter_en , Init_counter , select , Done );
endmodule
