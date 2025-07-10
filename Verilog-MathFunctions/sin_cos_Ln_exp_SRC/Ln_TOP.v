module part_Ln_TOP (input clk , rst , start , input [15:0] Xbus , output Ready , output [17:0] RBUS);
    wire ldx , ldt , init_t , ldE , init_E , init_counter , counter_en , select , co ;
    part_Ln uut(clk , rst , ldx , ldt , init_t , ldE , init_E , init_counter , counter_en , select , Xbus , RBUS ,  co );
    part_LnCO ut( clk , rst , start , co, ldx , ldt , init_t , ldE , init_E , counter_en , init_counter , select , Ready );
endmodule