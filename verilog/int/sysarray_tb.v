

`timescale  10us/1ps

module sysarray_tb();

parameter n = 31;

reg [n:0] a00, a10, a20, a30, a40;
reg [n:0] b00, b01, b02, b03, b04;

reg [n:0] c00, c01, c02, c10, c20;
reg clock;

wire [n:0] a05, a15, a25, a35, a45;
wire [n:0] b50, b51, b52, b53, b54;

wire [n:0] c53, c54, c55, c35, c45;

reg [n:0] d00, d01, d02;
reg [n:0] d10, d11, d12;
reg [n:0] d20, d21, d22;

//module sysarr(
//		a00, a10, a20, a30, a40,
//		b00, b01, b02, b03, b04,

//		c00, c01, c02, c10, c20,

//		a05, a15, a25, a35, a45,
//		b50, b51, b52, b53, b54,

//		c53, c54, c55, c35, c45
//		);

//This function is used to convert unsigned integers to signed.
function integer twos(input [31:0] inp);
    twos = inp;
endfunction

sysarr s1(
	a00, a10, a20, a30, a40,
	b00, b01, b02, b03, b04,

	c00, c01, c02, c10, c20,

        a05, a15, a25, a35, a45,
        b50, b51, b52, b53, b54,

        c53, c54, c55, c35, c45,clock
        );

initial
begin

	//$dumpfile("Syyarr.vcd");
	//$dumpvars(0,sysarray_tb);

	clock = 0;

	a00 = 0; a10 = 0; a20 = 0; a30 = 0; a40 = 0;
	b00 = 0; b01 = 0; b02 = 0; b03 = 0; b04 = 0;
	c00 = 0; c01 = 0; c02 = 0; c10 = 0; c20 = 0;

	#10;
	clock = ~clock;
	#10;
	clock = ~clock;



	 a00 = 1; a10 = 2; a20 = 3; a30 = 0; a40 = 0;
	 b00 = 1; b01 = 4; b02 = 7; b03 = 0; b04 = 0;



	#10;
	clock = ~clock;
	 #10;
	 clock = ~clock;

	

	 a00 = 0; a10 = 4; a20 = 5; a30 = 6; a40 = 0;
	 b00 = 0; b01 = 2; b02 = 5; b03 = 8; b04 = 0;



	#10;
	clock = ~clock;
	 #10;
	 clock = ~clock;
	


	 a00 = 0; a10 = 0; a20 = 7; a30 = 8; a40 = 9;
	 b00 = 0; b01 = 0; b02 = 3; b03 = 6; b04 = 9;



	#10;
	clock = ~clock;
	#10;
	clock = ~clock;
	

	a00 = 0; a10 = 0; a20 = 0; a30 = 0; a40 = 0;
    b00 = 0; b01 = 0; b02 = 0; b03 = 0; b04 = 0;
	
	#10;
	clock = ~clock;
	#10;
	clock = ~clock;

	a00 = 0; a10 = 0; a20 = 0; a30 = 0; a40 = 0;
    b00 = 0; b01 = 0; b02 = 0; b03 = 0; b04 = 0;
	
	#10;
	clock = ~clock;
	#10;
	clock = ~clock;

	a00 = 0; a10 = 0; a20 = 0; a30 = 0; a40 = 0;
    b00 = 0; b01 = 0; b02 = 0; b03 = 0; b04 = 0;

	d02 = c35; d01 = c45; d00 = c55; d10 = c54; d20 = c53;
	
	#10;
	clock = ~clock;
	#10;
	clock = ~clock;
	
	d12 = c45; d11 = c55; d21 = c54;	

	a00 = 0; a10 = 0; a20 = 0; a30 = 0; a40 = 0;
    b00 = 0; b01 = 0; b02 = 0; b03 = 0; b04 = 0;

	#10;
	clock = ~clock;
	#10;
	clock = ~clock;
	
	d22 = c55;

	a00 = 0; a10 = 0; a20 = 0; a30 = 0; a40 = 0;
    b00 = 0; b01 = 0; b02 = 0; b03 = 0; b04 = 0;

    #10;
	clock = ~clock;
	 #10;
	clock = ~clock;
	
	 $display("Input Matrix 1 : ");
	 $display("[ 1, 2, 3 ]");
	 $display("[ 4, 5, 6 ]");
	 $display("[ 7, 8, 9 ]\n\n");

	 $display("Input Matrix 2 : ");
	 $display("[ 1, 2, 3 ]");
	 $display("[ 4, 5, 6 ]");
	 $display("[ 7, 8, 9 ]\n\n");


	$display("Output Matrix  = Input Matrix 1 * Input Matrix 2\n");
	$display("[ %b , %b , %b ]", d00, d01, d02);
	$display("[ %b,  %b , %b ]", d10, d11, d12);
	$display("[ %b,  %b , %b ]\n\n", d20, d21, d22);


	$display("Output matrix: \n");
	$display("[ 30, 36, 42]");
	$display("[ 66, 81, 96]");
	$display("[ 102, 126, 150]\n\n");





end

endmodule
