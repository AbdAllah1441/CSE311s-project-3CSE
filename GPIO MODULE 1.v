module GPIO (
            PRESETn, 
            PSEL,
            PENABLE,
            PWRITE,
            PCLK, 
            PADDR, 
            PWDATA, 
            PRDATA,
            PREADY
            );

    input PRESETn, PSEL, PENABLE, PWRITE;
    input [7:0] PADDR, PWDATA; 
    //input 
    input PCLK ;    
    output reg [7:0] PRDATA ;
    output reg PREADY ;
    
    reg [7:0] INNER_DATA ;
    integer i;

    initial begin
        PRDATA = 8'b00000000;
        INNER_DATA = 8'b00000000;
        PREADY = 1'b0;
   
    end


    always @(posedge PCLK or posedge PRESETn)begin
            
            // RESET
            if (!PRESETn) begin
                PRDATA = 8'b00000000;
                PREADY = 1'b0;
            end
            //selecting
            if(PSEL && PENABLE) begin
                PREADY = 1'b1;
                // Writing
                if (PWRITE) begin 

                    for (i = 0; i < 8; i = i + 1) begin
                        if (PADDR[i]) begin
                            INNER_DATA[i] = PWDATA[i] ;
                        end
                    end
                    PREADY = 1'b0;
                end

                //Reading
                else begin
                    PRDATA = INNER_DATA;
                    PREADY = 1'b0;
                end

            end
    end

endmodule