module part_2_DP (input clk , rst , start , ldE , init_E1,init_E2 , input [15:0] Xbus , input [1:0] MOD , output Done , co , output[2:0] count , output [17:0] RBUS );
    reg [17:0] add_out ;
    wire [15:0] Tbus ;
    reg [17:0] E_reg ;
    wire [17:0] add_in ;
    assign add_in = {2'b00,Tbus} ;   //    E_REG  ورودی برای جمع کننده ورودی   

    part_1_TOP ut( clk , rst , start , Xbus , Tbus , Done , co , count);

    always @(posedge clk , posedge rst) begin         //    Register for saving SUM
        if(rst==1)
            E_reg <= 0;
        else begin
            if(init_E1==1)
                E_reg <= 18'h10000 ;
            else begin
                if(init_E2==1)
                    E_reg <= 0 ;
                    else begin
                        if(ldE==1)
                            E_reg <= add_out ;
                    end
            end
        end
    end
    parameter e = 0 , sin = 1 , cos = 2 , ln = 3 ;

    always @(posedge Done ) begin                 //   مشخص کردن نحوه جمع و تفریق بین ترم ها
        add_out = 0 ;
        case (MOD)
            e:begin
                    add_out = E_reg + add_in ;
            end
            sin:begin
                if(count===3'b000)
                    add_out = E_reg + add_in; 
                else begin
                    if(count==3'b100)
                        add_out = E_reg + add_in; 
                    else begin
                        if(count===3'b010)
                            add_out = E_reg - add_in; 
                        else begin
                            if(count==3'b110)
                                add_out = E_reg - add_in; 
                        end
                    end
                end
            end 
            cos:begin
                if(count===3'b011)
                    add_out = E_reg + add_in; 
                else begin
                    if(count==3'b101)
                        add_out = E_reg + add_in; 
                    else begin
                        if(count===3'b001)
                            add_out = E_reg - add_in; 
                        else begin
                            if(count==3'b111)
                                add_out = E_reg - add_in; 
                        end
                    end
                end
            end
        endcase
    end

    assign RBUS = E_reg ;                         //  قرار دادن تو خروجی 
endmodule

