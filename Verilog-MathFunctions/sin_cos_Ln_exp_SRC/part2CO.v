module part_2_CO ( input clk , rst , start , Done , co , input [1:0] MOD , input [2:0] count , output reg Ready , ldE , init_E1 , init_E2 );  // state machin fo sin(x) 
                                                                                                                                              // cos(x) , e^(x)
    reg[1:0] ns , ps ;
    parameter IDLE = 0 , START = 1 , WAIT = 2 , ADD = 3 ;
    always @( posedge clk , posedge rst ) begin
        if(rst==1)
            ps <= IDLE ;
        else
            ps <= ns ;
    end

    always @( start , Done , ps , co , count ) begin
         ns = 0 ;
        {ldE , init_E2,init_E1, Ready} = 0 ;
        case (ps)
            IDLE: begin
                ns = start ? START : IDLE ;
                Ready = 1 ;
            end
            START: begin
                ns = start ? START : WAIT ;
                if(MOD==1)
                    init_E2 = 1 ;
                else
                    init_E1 = 1 ;
            end
            WAIT: begin
                ns = Done ? ADD : WAIT ;
            end
            ADD: begin                         //   تعیین جاهایی که باید لود کنیم
                ns = co ? IDLE : WAIT ;
                if(MOD==0)
                    ldE = 1 ;
                else begin
                    if(MOD==1) begin
                        if(count[0]==1)
                            ldE=1;
                    end 
                    else begin
                        if(MOD==2)
                            if(count[0]==0)
                            ldE=1;
                    end
                end
            end
        endcase
    end
endmodule
