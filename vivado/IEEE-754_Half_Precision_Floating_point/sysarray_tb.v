

`timescale 1ns/1ps

module sysarray_tb();

parameter n = 15;

reg clock;

wire [n:0] c53,c54,c55,c35,c45;
integer i;

//module sysarray_mem(clock);

sysarray_mem m1(clock,c53,c54,c55,c35,c45);

initial
begin
    clock = 0;
    
    for(i = 0 ; i <= 40; i = i + 1)
    begin 
    #10;
    clock = ~clock;
    #10;
    clock = ~clock;
    end
end

endmodule