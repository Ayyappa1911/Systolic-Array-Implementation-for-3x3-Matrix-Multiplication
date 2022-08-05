
module sysarray_mem(clock, cc53,cc54,cc55,cc35,cc45);
//module sysarray_mem(clock);
parameter n = 31;

input clock;

output [n:0] cc53,cc54,cc55,cc35,cc45;
reg [n:0] cc53,cc54,cc55,cc35,cc45;
	
reg [n:0] a00, a10, a20, a30, a40;
reg [n:0] b00, b01, b02, b03, b04;

reg [n:0] c00, c01, c02, c10, c20;
//reg clock;

wire [n:0] a05, a15, a25, a35, a45;
wire [n:0] b50, b51, b52, b53, b54;

wire [n:0] c53, c54, c55, c35, c45;

reg [n:0] d00, d01, d02;
reg [n:0] d10, d11, d12;
reg [n:0] d20, d21, d22;


reg wea,ena;
reg [4:0] flg;
wire [n:0] data,dina;
wire reset;



//integer flg;

reg [n:0] inp1 [0:8];
reg [n:0] inp2 [0:8];
reg [n:0] d[0:8];

sysarr s1(
	a00, a10, a20, a30, a40,
	b00, b01, b02, b03, b04,

	c00, c01, c02, c10, c20,

        a05, a15, a25, a35, a45,
        b50, b51, b52, b53, b54,

        c53, c54, c55, c35, c45,clock
);


blk_mem_gen_0 hlf_mem (
  .clka(clock),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(flg),  // input wire [4 : 0] addra
  .dina(dina),    // input wire [31 : 0] dina
  .douta(data)  // output wire [31 : 0] douta
);

//blk_mem_gen_0 hif_mem (
//  .clka(clock),    // input wire clka
//  .ena(ena),      // input wire ena
//  .wea(wea),      // input wire [0 : 0] wea
//  .addra(flg),  // input wire [4 : 0] addra
//  .dina(dina),    // input wire [15 : 0] dina
//  .douta(data)  // output wire [15 : 0] douta
//);

vio_0 VIO (
  .clk(clock),                // input wire clk
  .probe_in0(a05),    // input wire [31 : 0] probe_in0
  .probe_in1(a12),    // input wire [31 : 0] probe_in1
  .probe_in2(a25),    // input wire [31 : 0] probe_in2
  .probe_in3(a35),    // input wire [31 : 0] probe_in3
  .probe_in4(a45),    // input wire [31 : 0] probe_in4
  .probe_in5(b50),    // input wire [31 : 0] probe_in5
  .probe_in6(b51),    // input wire [31 : 0] probe_in6
  .probe_in7(b52),    // input wire [31 : 0] probe_in7
  .probe_in8(b53),    // input wire [31 : 0] probe_in8
  .probe_in9(b54),    // input wire [31 : 0] probe_in9
  .probe_in10(c53),  // input wire [31 : 0] probe_in10
  .probe_in11(c54),  // input wire [31 : 0] probe_in11
  .probe_in12(c55),  // input wire [31 : 0] probe_in12
  .probe_in13(c35),  // input wire [31 : 0] probe_in13
  .probe_in14(c45),  // input wire [31 : 0] probe_in14
  .probe_in15(data),  // input wire [31 : 0] probe_in15
  .probe_out0(reset)  // output wire [0 : 0] probe_out0
);

//vio_0 VIO (
//  .clk(clock),                // input wire clk
//  .probe_in0(a05),    // input wire [15 : 0] probe_in0
//  .probe_in1(a15),    // input wire [15 : 0] probe_in1
//  .probe_in2(a25),    // input wire [15 : 0] probe_in2
//  .probe_in3(a35),    // input wire [15 : 0] probe_in3
//  .probe_in4(a45),    // input wire [15 : 0] probe_in4
//  .probe_in5(b50),    // input wire [15 : 0] probe_in5
//  .probe_in6(b51),    // input wire [15 : 0] probe_in6
//  .probe_in7(b52),    // input wire [15 : 0] probe_in7
//  .probe_in8(b53),    // input wire [15 : 0] probe_in8
//  .probe_in9(b54),    // input wire [15 : 0] probe_in9
//  .probe_in10(c53),  // input wire [15 : 0] probe_in10
//  .probe_in11(c54),  // input wire [15 : 0] probe_in11
//  .probe_in12(c55),  // input wire [15 : 0] probe_in12
//  .probe_in13(c35),  // input wire [15 : 0] probe_in13
//  .probe_in14(c45),  // input wire [15 : 0] probe_in14
//  .probe_in15(data),  // input wire [15 : 0] probe_in15
//  .probe_out0(reset)  // output wire [15 : 0] probe_out0
//);



//ila_0 your_instance_name (
//	.clk(clock), // input wire clk
//	.probe0(a00), // input wire [15:0]  probe0  
//	.probe1(a10), // input wire [15:0]  probe1 
//	.probe2(a20), // input wire [15:0]  probe2 
//	.probe3(a30), // input wire [15:0]  probe3 
//	.probe4(a40), // input wire [15:0]  probe4 
//	.probe5(b01), // input wire [15:0]  probe5 
//	.probe6(b02), // input wire [15:0]  probe6 
//	.probe7(b03), // input wire [15:0]  probe7 
//	.probe8(b04), // input wire [15:0]  probe8 
//	.probe9(c00), // input wire [15:0]  probe9 
//	.probe10(c01), // input wire [15:0]  probe10 
//	.probe11(c02), // input wire [15:0]  probe11 
//	.probe12(c10), // input wire [15:0]  probe12 
//	.probe13(c20), // input wire [15:0]  probe13 
//	.probe14(a05), // input wire [15:0]  probe14 
//	.probe15(a15), // input wire [15:0]  probe15 
//	.probe16(a25), // input wire [15:0]  probe16 
//	.probe17(a35), // input wire [15:0]  probe17 
//	.probe18(a45), // input wire [15:0]  probe18 
//	.probe19(b50), // input wire [15:0]  probe19 
//	.probe20(b51), // input wire [15:0]  probe20 
//	.probe21(b52), // input wire [15:0]  probe21 
//	.probe22(b53), // input wire [15:0]  probe22 
//	.probe23(b54), // input wire [15:0]  probe23 
//	.probe24(c53), // input wire [15:0]  probe24 
//	.probe25(c54), // input wire [15:0]  probe25 
//	.probe26(c55), // input wire [15:0]  probe26 
//	.probe27(c35), // input wire [15:0]  probe27 
//	.probe28(c45), // input wire [15:0]  probe28 
//	.probe29(data), // input wire [15:0]  probe29 
//	.probe30(b00), // input wire [15:0]  probe30 
//	.probe31(reset), // input wire [0:0]  probe31
//	.probe32(flg), 
//	.probe33(d[0]), // input wire [15:0]  probe33 
//	.probe34(d[1]), // input wire [15:0]  probe34 
//	.probe35(d[2]), // input wire [15:0]  probe35 
//	.probe36(d[3]), // input wire [15:0]  probe36 
//	.probe37(d[4]), // input wire [15:0]  probe37 
//	.probe38(d[5]), // input wire [15:0]  probe38 
//	.probe39(d[6]), // input wire [15:0]  probe39 
//	.probe40(d[7]), // input wire [15:0]  probe40 
//	.probe41(d[8]) // input wire [15:0]  probe41
//);


initial
begin
    ena = 1;
    wea = 0;
    flg = 0;
    d[0] = 0;
    d[1] = 0;
    d[2] = 0;
    d[3] = 0;
    d[4] = 0;
    d[5] = 0;
    d[6] = 0;
    d[7] = 0;
    d[8] = 0;
end

always @ (posedge clock)
begin
    
    if(reset)
    begin
        flg = 0;
    end
    else
    begin
    
    flg = flg + 1;
    if(flg == 1 || flg == 2)
    begin
        flg = flg + 0;
        d[0] = 0;
        d[1] = 0;
        d[2] = 0;
        d[3] = 0;
        d[4] = 0;
        d[5] = 0;
        d[6] = 0;
        d[7] = 0;
        d[8] = 0;
    end
    else
    begin
         if(flg <= 11)
         begin
            inp1[flg-3] = data;
         end
         else if(flg <= 20)
         begin
            inp2[flg-12] = data;
         end
         
         if(flg == 21)
         begin
            a00 <= 0; a10 <= 0; a20 <= 0; a30 <= 0; a40 <= 0;
	        b00 <= 0; b01 <= 0; b02 <= 0; b03 <= 0; b04 <= 0;
	        c00 <= 0; c01 <= 0; c02 <= 0; c10 <= 0; c20 <= 0;
         end
         else if(flg == 22)
         begin
            a00 <= inp1[0]; a10 <= inp1[1]; a20 <= inp1[2]; a30 <= 0; a40 <= 0;
	        b00 <= inp2[0]; b01 <= inp2[3]; b02 <= inp2[6]; b03 <= 0; b04 <= 0;
         end
         else if(flg == 23)
         begin
            a00 <= 0; a10 <= inp1[3]; a20 <= inp1[4]; a30 <= inp1[5]; a40 <= 0;
	        b00 <= 0; b01 <= inp2[1]; b02 <= inp2[4]; b03 <= inp2[7]; b04 <= 0;
         end
         else if(flg == 24)
         begin
            a00 <= 0; a10 <= 0; a20 <= inp1[6]; a30 <= inp1[7]; a40 <= inp1[8];
	        b00 <= 0; b01 <= 0; b02 <= inp2[2]; b03 <= inp2[5]; b04 <= inp2[8];
         end
         else if(flg == 25)
         begin
            a00 <= 0; a10 <= 0; a20 <= 0; a30 <= 0; a40 <= 0;
	        b00 <= 0; b01 <= 0; b02 <= 0; b03 <= 0; b04 <= 0;
         end
         else if(flg == 26)
         begin
            a00 <= 0; a10 <= 0; a20 <= 0; a30 <= 0; a40 <= 0;
	        b00 <= 0; b01 <= 0; b02 <= 0; b03 <= 0; b04 <= 0;
//	        d[2] <= c35; d[1] <= c45; d[0] <= c55; d[3] <= c54; d[6] <= c53;
         end
         else if(flg == 27)
         begin
            a00 <= 0; a10 <= 0; a20 <= 0; a30 <= 0; a40 <= 0;
	        b00 <= 0; b01 <= 0; b02 <= 0; b03 <= 0; b04 <= 0;
	        d[2] <= c35; d[1] <= c45; d[0] <= c55; d[3] <= c54; d[6] <= c53;
//            d[5] <= c45; d[4] <= c55; d[7] <= c54;
         end
         else if(flg == 28)
         begin
            a00 <= 0; a10 <= 0; a20 <= 0; a30 <= 0; a40 <= 0;
	        b00 <= 0; b01 <= 0; b02 <= 0; b03 <= 0; b04 <= 0;
	        d[5] <= c45; d[4] <= c55; d[7] <= c54;
//             d[8] <= c55;
         end
         else if(flg == 29)
         begin
            a00 <= 0; a10 <= 0; a20 <= 0; a30 <= 0; a40 <= 0;
	        b00 <= 0; b01 <= 0; b02 <= 0; b03 <= 0; b04 <= 0;
	        d[8] <= c55;
         end
         else
         begin
            a00 <= 0; a10 <= 0; a20 <= 0; a30 <= 0; a40 <= 0;
	        b00 <= 0; b01 <= 0; b02 <= 0; b03 <= 0; b04 <= 0;
         end
         
    end 
    end
    
    cc53 <= c53 ;cc54 <= c54; cc55 <= c55; cc35 <= c35; cc45 <= c45;
   
end

endmodule
