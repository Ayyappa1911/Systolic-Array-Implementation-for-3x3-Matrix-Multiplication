

module delay(a,b,a1,b1,clock);

parameter n = 31;

input [n:0] a,b;
input clock;
output [n:0] a1,b1;
reg [n:0] a1,b1;

//Delay block is just used as a regester to hold the a,and b for a clock cycle.

always @(posedge clock)
begin
	a1 <= a;
	b1 <= b;
end

endmodule
