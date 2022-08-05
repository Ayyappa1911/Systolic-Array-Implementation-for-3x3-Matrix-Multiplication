
module sysarr(
		a00, a10, a20, a30, a40,
		b00, b01, b02, b03, b04,
		
		c00, c01, c02, c10, c20,

		a05, a15, a25, a35, a45,
		b50, b51, b52, b53, b54,

		c53, c54, c55, c35, c45, clock
		);


parameter n = 31;



input clock;
input [n:0] a00, a10, a20, a30, a40;
input [n:0] b00, b01, b02, b03, b04;

input [n:0] c00, c01, c02, c10, c20; 

output [n:0] a05, a15, a25, a35, a45;
output [n:0] b50, b51, b52, b53, b54;

output [n:0] c53, c54, c55, c35, c45;

wire [n:0] a01, a11, a21, a31, a41;
wire [n:0] a02, a12, a22, a32, a42;
wire [n:0] a03, a13, a23, a33, a43;
wire [n:0] a04, a14, a24, a34, a44;

wire [n:0] b10, b20, b30, b40;
wire [n:0] b11, b21, b31, b41;
wire [n:0] b12, b22, b32, b42;
wire [n:0] b13, b23, b33, b43;
wire [n:0] b14, b24, b34, b44;

wire [n:0] c11, c12, c13;
wire [n:0] c21, c22, c23, c24;
wire [n:0] c31, c32, c33, c34;
wire [n:0] c42, c43, c44;

reg [n:0] aa01, aa11, aa21, aa31, aa41;
reg [n:0] aa02, aa12, aa22, aa32, aa42;
reg [n:0] aa03, aa13, aa23, aa33, aa43;
reg [n:0] aa04, aa14, aa24, aa34, aa44;

reg [n:0] bb10, bb20, bb30, bb40;
reg [n:0] bb11, bb21, bb31, bb41;
reg [n:0] bb12, bb22, bb32, bb42;
reg [n:0] bb13, bb23, bb33, bb43;
reg [n:0] bb14, bb24, bb34, bb44;

reg [n:0] ca11, ca12, ca13;
reg [n:0] ca21, ca22, ca23, ca24;
reg [n:0] ca31, ca32, ca33, ca34;
reg [n:0] ca42, ca43, ca44;


//module PE(a,b,c,a1,b1,out);
//module delay(a,b,a1,b1);

//The model of systolic array(along with variable names) is attached as an image in the report. 


PE pe00(a00, b00, c00, a01, b10, c11,clock);
PE pe01(aa01, b01, c01, a02, b11, c12,clock);
PE pe02(aa02, b02, c02, a03, b12, c13,clock);
delay d03(aa03, b03, a04, b13,clock);
delay d04(aa04, b04, a05, b14,clock);


PE pe10(a10, bb10, c10, a11, b20, c21,clock);
PE pe11(aa11, bb11, ca11, a12, b21, c22,clock);
PE pe12(aa12, bb12, ca12, a13, b22, c23,clock);
PE pe13(aa13, bb13, ca13, a14, b23, c24,clock);
delay d14(aa14, bb14, a15, b24,clock);

PE pe20(a20, bb20, c20, a21, b30, c31,clock);
PE pe21(aa21, bb21, ca21, a22, b31, c32,clock);
PE pe22(aa22, bb22, ca22, a23, b32, c33,clock);
PE pe23(aa23, bb23, ca23, a24, b33, c34,clock);
PE pe24(aa24, bb24, ca24, a25, b34, c35,clock);

delay d30(a30, bb30, a31, b40,clock);
PE pe31(aa31, bb31, ca31, a32, b41, c42,clock);
PE pe32(aa32, bb32, ca32, a33, b42, c43,clock);
PE pe33(aa33, bb33, ca33, a34, b43, c44,clock);
PE pe34(aa34, bb34, ca34, a35, b44, c45,clock);

delay d40(a40, bb40, a41, b50,clock);
delay d41(aa41, bb41, a42, b51,clock);
PE pe42(aa42, bb42, ca42, a43, b52, c53,clock);
PE pe43(aa43, bb43, ca43, a44, b53, c54,clock);
PE pe44(aa44, bb44, ca44, a45, b54, c55,clock);




always @(*)
begin
ca11 <= c11;
ca12 <= c12;
ca13 <= c13;

ca21 <= c21;
ca22 <= c22;
ca23 <= c23;
ca24 <= c24;

ca31 <= c31;
ca32 <= c32;
ca33 <= c33;
ca34 <= c34;

ca42 <= c42;
ca43 <= c43;
ca44 <= c44;

aa01 <= a01; aa11 <= a11; aa21 <= a21; aa31 <= a31; aa41 <= a41;
aa02 <= a02; aa12 <= a12; aa22 <= a22; aa32 <= a32; aa42 <= a42;
aa03 <= a03; aa13 <= a13; aa23 <= a23; aa33 <= a33; aa43 <= a43;
aa04 <= a04; aa14 <= a14; aa24 <= a24; aa34 <= a34; aa44 <= a44;

bb10 <= b10; bb20 <= b20; bb30 <= b30; bb40 <= b40;
bb11 <= b11; bb21 <= b21; bb31 <= b31; bb41 <= b41;
bb12 <= b12; bb22 <= b22; bb32 <= b32; bb42 <= b42;
bb13 <= b13; bb23 <= b23; bb33 <= b33; bb43 <= b43;
bb14 <= b14; bb24 <= b24; bb34 <= b34; bb44 <= b44;

//$display("a00 = %d, b00 = %d, c00 = %d",a00,b00,c00);
//$display("C11 = %d, C12 = %d, C13 = %d",ca11,ca12,ca13);
//$display("C21 = %d, C22 = %d, C23 = %d, C24 = %d",ca21,ca22,ca23,ca24);
//$display("C31 = %d, C32 = %d, C33 = %d, C34 = %d",ca31,ca32,ca33,ca34);
//$display("C42 = %d, C43 = %d, C44 = %d",ca42,ca43,ca44);

// // $display("a10 = %d,b10 = %d, c10 = %d, a11 = %d, b20= %d, C21 = %d", a10,b10,c10,a11,b20,c21);
// // $display("a00 = %d, a10 = %d, a20 = %d, a30 = %d, a40 = %d",a01,a11,a21,a31,a41);
// $display("a00 = %d, a10 = %d, a20 = %d, a30 = %d, a40 = %d",a10,a11,a12,a13,a14);
// // $display("b00 = %d, b10 = %d, b20 = %d, b30 = %d, b40 = %d",b00,b10,b20,b30,b40);
//$display("c35 = %d; c45 = %d; c55 = %d; c54 = %d; c53 = %d\n",c35,c45,c55,c54,c53);



end

endmodule


