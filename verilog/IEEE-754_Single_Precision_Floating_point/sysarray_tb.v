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


// d is the final expected output matrix.
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
function integer twos(input [31:0] inp);
    twos = inp;
endfunction

function real singletof(input [31:0] inp);
	integer exp;
	reg [31:0] man;

	integer i;
	begin

    	singletof = 0;    

    	if(inp[30:0] == 0)
    	begin
    	    singletof = 0;
    	end
    	else
    	begin
		
    	    exp = inp[30:23];
    	    exp = exp - 127;
    	    man = 24'b100000000000000000000000 + inp[22:0];
			

    	    for(i = 23; i > -1;i = i - 1)
    	    begin
    	        singletof = singletof + man[i] * (2**(i-23+exp));
    	    end


    	    if(inp[31])
    	    begin
    	        singletof = -1*singletof;
    	    end
    	end

	end
endfunction

//function real halftof(input [31:0] inp);
//	integer exp;
//	reg [31:0] man;

//	integer i;
//	begin

//    	halftof = 0;    

//    	if(inp[14:0] == 0)
//    	begin
//    	    halftof = 0;
//    	end
//    	else
//    	begin
		
//    	    exp = inp[14:10];
//    	    exp = exp - 31;
//    	    man = 11'b10000000000 + inp[9:0];
			

//    	    for(i = 10; i > -1;i = i - 1)
//    	    begin
//    	        halftof = halftof + man[i] * (2**(i-10+exp));
//    	    end


//    	    if(inp[15])
//    	    begin
//    	        halftof = -1*halftof;
//    	    end
//    	end

//	end
//endfunction

// function [31:0] floattoieee(input [31:0] N,e,m,input real inp);

// 	//  N,e,m;
// 	integer n,n1,i,s;
// 	real tmp;
// 	reg [31:0] out;
// 	integer j;
// 	// input real inp;
// 	begin
// 		j = 23;
// 		tmp = inp;
//     	if(inp >= 0)
//     	begin
//     	    s = 0;
//     	end
//     	else
//     	begin
//     	    s = 1;
//     	    tmp = -1*inp;
//     	end
//     	n = $clog2(inp);
// 		if(inp < (2**n))
// 		begin
// 			n = n - 1;
// 		end

// 		n1 = n;
// 		// $display("%d",n);
//     	out = 0;
//     	for(i = 0; i < m+1;i = i + 1)
//     	begin
//     	    if(tmp > 0)
//     	    begin
// 				if(tmp > (2**n))
// 				begin
// 					out[j] = 1;
// 					tmp = tmp - (2**n);
// 				end
// 				else
// 				begin
// 					out[j] = 0;
// 				end
//     	        // out[j] = tmp % (2);
// 				// $display("a%b",out);
//     	        // tmp = tmp - (2**n);
// 				// if(out[j])
// 				// begin
// 				// 	tmp = (tmp - 1)/2;
// 				// end
// 				// else
// 				// begin
// 				// 	tmp = tmp/2;
// 				// end
//     	        n = n - 1;
// 				j = j - 1;
//     	        // out = out << 1;
//     	    end
//     	end
// 		// $display("a%b",out);
//     	out[m] = 0;
// 		// $display("a%b",out);
//     	// out[m+e-1:m] = (2**(e-1)) + (n);
// 		// $display("%b",((2**(e-1)) + n1 -1)<< m);
// 		j = ((2**(e-1)) + n1 -1) << m;
//     	out = out + j;
// 		// $display("a%b",out);
//     	out[N-1] = s[0];
	
//     	if(inp == 0)
//     	begin
//     	    out = 0;
//     	end

// 		floattoieee = out;

// 	end

// endfunction


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

	// The first row of the first input matrix is given as input for systolic array at a00,a10, and a20.
	a00 = 32'b01000000110010000000000000000000 ; a10 = 32'b01000000000010111000010100011110 ; a20 = 32'b01000000010110011001100110011001 ; a30 = 0; a40 = 0;
	b00 = 32'b00111111010000000000000000000000 ; b01 = 32'b01000001010001010111000010100011 ; b02 = 32'b01000001000000011110101110000101 ; b03 = 0; b04 = 0;
	// The first column of the second input matric is given as an input for the systolic array at b00,b01, and b02.

	
	#10;
	clock = ~clock;
	 #10;
	 clock = ~clock;

	
    // The second row of the first input matrix is given as input for systolic array at a10,a20, and a30.
	a00 = 0; a10 = 32'b11000000100010011001100110011001 ; a20 = 32'b00111111100011001100110011001100 ; a30 = 32'b01000000101100000000000000000000 ; a40 = 0;
	b00 = 0; b01 = 32'b01000001010000000000000000000000 ; b02 = 32'b00000000000000000000000000000000 ; b03 = 32'b01000000110111100001010001111010 ; b04 = 0;
	// The second column of the second input matrix is given as an input for the systolic array at b01,b02, and b03.

	

	#10;
	clock = ~clock;
	 #10;
	 clock = ~clock;
	
	
	// The Third row of the first input matrix is given as input for systolic array at a20,a30, and a40.
	a00 = 0; a10 = 0; a20 = 32'b01000001000010101011100001010001 ; a30 = 32'b11000001000100110011001100110011 ; a40 = 32'b00000000000000000000000000000000;
	b00 = 0; b01 = 0; b02 = 32'b01000000010000000000000000000000 ; b03 = 32'b11000000111010111000010100011110 ; b04 = 32'b01000000000000000000000000000000 ;
    // The Third column of the second input matrix is given as an input for the systolic array at b02,b03, and b04.

	

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
	

	
	$display("Input matrix 1 in decimal form: \n");
	
	$display("[ 6.25, 2.18,  3.40]");
	$display("[ -4.3, 1.099, 5.5 ]");
	$display("[ 8.67, -9.2,  0   ]\n\n");

	$display("Input matrix 2 in decimal form: \n");
	
	$display("[ 0.75, 12,  3.0  ]");
	$display("[ 12.34, 0,  -7.36]");
	$display("[ 8.12, 6.94, 2.0 ]\n\n");


	$display("Output Matrix  = Input Matrix 1 * Input Matrix 2\n");
	$display("[ %b , %b , %b ]", d00, d01, d02);
	$display("[ %b,  %b , %b ]", d10, d11, d12);
	$display("[ %b,  %b , %b ]\n\n", d20, d21, d22);


	$display("Output matrix in decimal form: \n");
	$display("[ 59.1967, 98.596,  9.5052]");
	$display("[ 55.009,  -13.43,  -9.996]");
	$display("[ -107.025, 104.04, 93.72 ]\n\n");

	$display("Expected Output matrix: \n");
	$display("[ 59.1967, 98.596,  9.5052]");
	$display("[ 54.9966,  -13.43,  -9.9886]");
	$display("[ -107.0255, 104.04, 93.72 ]");





end

endmodule
