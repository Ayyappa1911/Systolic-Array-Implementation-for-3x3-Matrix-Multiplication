`timescale  10us/1ps

//Implementation of the processing element

module PE(a,b,c,a1,b1,out,clock);

parameter n = 31;
parameter e = 8;
parameter m = 23;

input [n:0] a,b,c; 
output  [n:0] a1,b1;
reg [n:0] a1,b1;
input clock;

output [n:0] out;
reg [n:0] out;

// Slice function is similar to that we have in python
// to know what are the bits existing from index a to index b (a > b)
//  ex :- for a 32 bit no what are the bits takinf position from 5 to 12 (Here, a = 12  and b = 5) 
function [n:0]slice(input [n:0] inp, a,b);
    integer i;
    begin
        slice = 0;
        for(i = 0;i<a-b+1;i = i + 1)
        begin
            slice[i] = 1;
        end
        slice = slice << b;
        slice = slice & inp;
        slice = slice >> b;
    end
endfunction

// N is the total no of bits, e is the no of exponent bits, and m is the no of mantissa bits for the given inputs.
// fadd iss used to add the given IEEE-754 no's(expexted to work for all the data types similar to IEEE-754 half precision but only having N<=32. 
function [n:0] fadd(input [n:0] N,e,m,inp1,inp2);

    reg [n:0] out;

    integer s1,s2;
    integer exp1,exp2;
    reg [n:0] man1,man2;

    integer os;
    integer oexp;
    reg[n:0] oman;

    integer flag,i,flg;

begin

    s1 = inp1[N-1];
    s2 = inp2[N-1];

    exp1 = slice(inp1,N-2,m);
    exp2 = slice(inp2,N-2,m);

    exp1 = exp1 + 1 - (2**(e-1));
    exp2 = exp2 + 1 - (2**(e-1));

    man1 = 32'b00000000000000000000000000000001 << (m);
    man1 = man1 + slice(inp1,m-1,0);
    man2 = 32'b00000000000000000000000000000001 << (m);
    man2 = man2 + slice(inp2,m-1,0);

    oman = 0;
    if(s1 == s2)
    begin
        os = s1;
        if(exp1-exp2 >= 0)
        begin
            oexp = exp1;
            man2 = man2 >> (exp1-exp2);
            oman = man1+man2;
        end
        else
        begin
            oexp = exp2;
            man1 = man1 >> (exp2-exp1);
            oman = man1+man2;
        end

        flag = oman[0]; 

        if((slice(oman,m+1,m)) > 1)
        begin
            oexp = oexp + 1;
            oman = ( oman >> 1 );
        end

        if(flag)
        begin
            oman = oman + 1;
            if((slice(oman,m+1,m)) > 1)
            begin
                oexp = oexp + 1;
                oman = ( oman >> 1 );
            end
        end
        
        out = 0;
        out[N-1] = os;
        out = out + ((oexp -1 + (2**(e-1))) << m);
        out = out + slice(oman,m-1,0);

    end
    else
    begin

        // if inputs are having same mag and opp sign.
        if(slice(inp1,N-2,0) == slice(inp2,N-2,0))
        begin
            out = 0;
        end
        else
        begin
            if(exp1-exp2 >= 0)
            begin
                oexp = exp1;
                man2 = man2 >> (exp1-exp2);
            end
            else
            begin
                oexp = exp2;
                man1 = man1 >> (exp2-exp1);
            end

            if(man1 >= man2)
            begin
                os = s1;
                oman = man1-man2;
            end
            else
            begin
                os = s2;
                oman = man2-man1;
            end

            flag = -1;
            
            flg = 1;
            for(i = m ;i > -1;i = i-1)
            begin
                if(flg)
                begin
                    flag = flag + 1;
                end
                if(oman[i] == 1)
                begin
                      flg = 0;
                end
            end


            oexp = oexp - flag;
            oman = oman << flag; 

            out = 0;
            out[N-1] = os;
            out = out + ((oexp -1 + (2**(e-1))) << m);
            out = out + slice(oman,m-1,0);
        end
    end

    //zero cases.
    if(slice(inp1,N-2,0) == 0)
    begin
        out = inp2;
    end
    if(slice(inp2,N-2,0) == 0)
    begin
        out = inp1;
    end

    fadd = out;

end

endfunction


// N is the total no of bits, e is the no of exponent bits, and m is the no of mantissa bits for the given inputs.
// fmul iss used to multiply the given IEEE-754 no's(expexted to work for all the data types similar to IEEE-754 half precision but only having N<=32.  
function [n:0] fmul(input [n:0] N,e,m,inp1,inp2);

    reg [n:0] out;

    integer s1,s2;
    integer exp1,exp2;
    reg [n:0] man1,man2;

    integer os;
    integer oexp;
    reg[47:0] oman;
    reg[24:0] tmp;

    integer l1,l2,i,ol;

    integer flag;
    integer flg;

begin

    s1 = inp1[N-1];
    s2 = inp2[N-1];

    exp1 = slice(inp1,N-2,m);
    exp2 = slice(inp2,N-2,m);

    exp1 = exp1 + 1 - (2**(e-1));
    exp2 = exp2 + 1 - (2**(e-1));

    man1 = 32'b00000000000000000000000000000001 << (m);
    man1 = man1 + slice(inp1,m-1,0);
    man2 = 32'b00000000000000000000000000000001 << (m);
    man2 = man2 + slice(inp2,m-1,0);


    if((slice(inp1,N-2,0) == 0) || (slice(inp2,N-2,0) == 0)) //if any of the inputs is zero.
    begin
        out = 0;
    end
    else
    begin
        oman = 0;
        if(s1 == s2)
        begin
            os = 0;
        end
        else
        begin
            os = 1;
        end

        oexp = exp1+exp2;

        l1 = -1;
        l2 = -1;
        flg = 1;
        for(i=0;i<m+1;i = i+1)
        begin
            if(flg)
            begin
                 l1 = l1 + 1;
            end
            if(man1[i] == 1)
            begin
                flg = 0;
            end
        end
        
        flg = 1;
        for(i = 0;i< m+1;i = i+1)
        begin
            if(flg)
            begin
                l2 = l2 + 1;
            end
            if(man2[i] == 1)
            begin
                  flg = 0;
            end
            
        end

        man1 = man1 >> l1;
        man2 = man2 >> l2;

        oman = man1*man2;

        ol = -1;
        flg = 1;
        for(i = 2*m+1;i>-1;i = i -1)
        begin
            if(flg)
            begin
                ol = ol + 1;
            end
            if(oman[i] == 1)
            begin
                  flg = 0;
            end
        end

        oexp = oexp + l1+l2 - ol +1;    

        tmp = 0;
        tmp[m+1] = 0;
        flag = 0;
        if(oman[m+1-ol] == 1)
        begin
            flag = 1;
        end


        if(2*m+2-ol >= m+1)
        begin
            oman = oman >> m+1-ol;
            for(i = 0; i< m+1;i = i +1)
            begin
                tmp[i] = oman[i];
            end
            if(flag == 1)
            begin
                tmp = tmp + 1;
            end

            if(tmp[m+1] == 1)
            begin
                tmp = tmp >> 1;
                oexp = oexp + 1;
            end
        end
        else
        begin
            for(i = 0; i< m+1;i = i +1)
            begin
                tmp[i] = oman[i];
            end
            tmp = tmp << ol -m-1; 
        end

        out = 0;
        out[N-1] = os;
        out = out + ((oexp -1 + (2**(e-1))) << m);
        out = out + slice(tmp,m-1,0);
    end

    fmul = out;
    
end

endfunction



// For this model the functionality of the PE is not changed with the change in data type.
// a, b is passed through PE as a regester and another output c+a*b is calculated for each clock cycle.

//For programming it on FPGA. It is preferred to use posedge clock as the FPGA has only either posedge clock triggered Flipflops or negedge triggered Flipflops.
// If clock is used while synthesis in FPGA IT cannot allocate any FLIPFlops to the PE's and data flow in the systolic array observed is not same as expected.  

always @(posedge clock)
begin
	a1 <= a;
	b1 <= b;
    out <= fadd(n+1,e,m,c,fmul(n+1,e,m,a,b));
end

endmodule
