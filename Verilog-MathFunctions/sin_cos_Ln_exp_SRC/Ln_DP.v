module part_Ln (input clk , rst , ldx , ldt , init_t , ldE , init_E , init_counter , counter_en , select , input[15:0] Xbus , output [17:0] out , output co );
    reg[2:0] count ;
    reg [15:0] Mux_in , X_reg , T_reg ;
    wire[15:0] Mux_out ;
    wire[31:0] Mult_out;
    wire [17:0] add_in ;
    reg [17:0] add_out ,E_reg ;
    assign add_in = {2'b00 , T_reg };
    always @(posedge clk , posedge rst) begin
        if(rst==1)
            X_reg <= 0;
        else begin
            if(ldx==1)
                X_reg <= Xbus;
        end
    end
    always @(posedge clk , posedge rst) begin
        if(rst==1)
            T_reg <= 0;
        else begin
            if(init_t==1)
                T_reg <= 16'hFFFF; 
            else begin
                if(ldt==1)
                    T_reg <= Mult_out[31:16]; 
            end
        end
    end
    always @(posedge clk , posedge rst) begin
        if(rst==1)
            E_reg <= 0;
        else begin
            if(init_E==1)
                E_reg <= 18'h0000;
            else begin
                if(ldE==1)
                    E_reg <= add_out ; 
            end
        end
    end
    always @(posedge clk , posedge rst ) begin
        if(rst==1)
            count <= 0 ;
        else begin
            if(init_counter==1)
                count <= 0 ;
            else begin
                if(counter_en==1)
                    count <= count+1; 
            end
        end
    end
    assign co = (count==3'b111) ? 1 : 0 ;
    always @(count) begin
         case (count)
            0: Mux_in = 16'hFFFF;
            1: Mux_in = 16'h8000;
            2: Mux_in = 16'hAAAA;
            3: Mux_in = 16'hC000;
            4: Mux_in = 16'hCCCC;
            5: Mux_in = 16'hD555;
            6: Mux_in = 16'hD999;
            7: Mux_in = 16'hE000;
        endcase
    end
    assign Mux_out = (select==1) ? Mux_in : X_reg ;
    assign Mult_out= Mux_out * T_reg ;
    always @(count) begin 
        case (count)
            0: add_out =  E_reg + add_in ; 
            1: add_out =  E_reg - add_in ; 
            2: add_out =  E_reg + add_in ;
            3: add_out =  E_reg - add_in ; 
            4: add_out =  E_reg + add_in ; 
            5: add_out =  E_reg - add_in ;
            6: add_out =  E_reg + add_in ; 
            7: add_out =  E_reg - add_in ;  
            default: add_out = 0;
        endcase
    end
    assign out = add_out; 
endmodule