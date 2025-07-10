module part_1 (input clk , rst , ldx , ldt , init_t , init_counter , counter_en , select , input[15:0] Xbus , output [15:0] out , output co , output reg [2:0] count  );
    reg [15:0] Mux_in , X_reg ,T_reg;
    wire[15:0] Mux_out ;
    wire[31:0] Mult_out;
    always @(posedge clk , posedge rst) begin    // Register for input
        if(rst==1)
            X_reg <= 0;
        else begin
            if(ldx==1)
                X_reg <= Xbus;
        end
    end
    always @(posedge clk , posedge rst) begin    // Register for Temp
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
    always @(posedge clk , posedge rst ) begin    // counter 
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
    assign co = (count==3'b111) ? 1 : 0 ;          // look up table
    always @(count) begin
         case (count)
            0: Mux_in = 16'hFFFF;
            1: Mux_in = 16'h8000;
            2: Mux_in = 16'h5555;
            3: Mux_in = 16'h4000;
            4: Mux_in = 16'h3333;
            5: Mux_in = 16'h2AAA;
            6: Mux_in = 16'h2492;
            7: Mux_in = 16'h2000;
        endcase
    end
    assign Mux_out = (select==1) ? Mux_in : X_reg ;
    assign Mult_out= Mux_out * T_reg ;
    assign out = T_reg ;                                       

endmodule
