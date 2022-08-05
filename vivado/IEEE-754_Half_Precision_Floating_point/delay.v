
module delay(a,b,a1,b1,clock);

parameter n = 15;
input [n:0] a,b;
input clock;
output [n:0] a1,b1;
reg [n:0] a1,b1;


always @(posedge clock)
begin
	// #25;
	a1 <= a;
	b1 <= b;
end

endmodule
