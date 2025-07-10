module part_1CO (input clk , rst , start , co, output reg ldx , ldt , Init_t , counter_en , Init_counter , select , Done );  // state machine for terms(x , x^(2)/2 , x^(3)/6 ...)
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
        {ldx , ldt , Init_t , counter_en , Init_counter , select , Done} = 0 ;

        case (ps)                        
            IDLE: begin
                ns = start ? START : IDLE ;
            end
            START: begin
                ns = start ? START : load ;
            end
            load: begin
                ldx = 1 ; Init_t = 1 ; Init_counter = 1 ;
                ns = Mult1;
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
                counter_en = 1 ; Done = 1 ;
                ns = co ? IDLE : Mult1 ;
            end
        endcase
    end

endmodule

