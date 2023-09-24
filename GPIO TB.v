`timescale 1ns/100ps

module test1 ();

    reg PCLK;
    reg [7:0] PADDR, PWDATA;
    reg PRESETn, PSEL, PENABLE, PWRITE;

    wire [7:0] PRDATA ;
    wire PREADY;

    initial begin
        PRESETn = 1'b0;
        PSEL = 1'b1;
        PENABLE = 1'b1;
        PWRITE = 1'b1;

        PADDR =  8'b11111111;
        PWDATA = 8'b11001100;

        #20 PWRITE = 1'b0;
        #10 $stop;




    end

    initial begin 
            PCLK = 1;            
            forever begin
 
            #1 PCLK = ~PCLK;
        end
    end

    GPIO app1(.PCLK(PCLK), .PADDR(PADDR), .PWDATA(PWDATA), .PRESETn(PRESETn), .PSEL(PSEL), .PENABLE(PENABLE), .PWRITE(PWRITE), .PRDATA(PRDATA), .PREADY(PREADY));

endmodule
