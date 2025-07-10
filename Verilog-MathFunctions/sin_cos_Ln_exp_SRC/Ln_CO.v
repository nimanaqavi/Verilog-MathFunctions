
module part_LnCO (input clk , rst , start , co, output reg ldx , ldt , init_t , ldE , init_E , counter_en , init_counter , select , Ready );
    reg [2:0] ps , ns ;
    parameter IDLE = 0 , START = 1 , load = 2 , Mult1 = 3 , Mult2 = 4 , adding = 5 ;
    always @( posedge clk or posedge rst ) begin
        if(rst==1)
            ps <= IDLE ;
        else
            ps <= ns ;
    end
    always @( start , ps , co ) begin
         ns = IDLE ;
        { ldx , ldt , init_t , counter_en , init_counter , select , ldE , init_E  , Ready } = 0 ;

        case (ps)
            IDLE: begin
                ns = start ? START : IDLE ;
                Ready = 1 ;
            end
            START: begin
                ns = start ? START : load ;
            end
            load: begin
                ldx = 1 ; init_t = 1 ; init_E = 1 ; init_counter = 1 ;
                ns = Mult1 ;
            end
            Mult1: begin
                ns = Mult2 ;
                select = 1 ; ldt = 1 ;
            end
            Mult2: begin
                select = 0 ; ldt = 1 ;
                ns = adding ;
            end
            adding: begin
                counter_en = 1 ; ldE = 1 ;
                ns = co ? IDLE : Mult1 ;
            end
        endcase
    end
endmodule