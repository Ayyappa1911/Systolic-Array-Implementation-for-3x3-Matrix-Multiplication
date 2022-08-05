
`timescale  10us/1ps

//Implementation of the processing element

module PE(a,b,c,a1,b1,out,clock);

parameter n = 15;
parameter e = 5;
parameter m = 10;

input [n:0] a,b,c; 
output  [n:0] a1,b1;
reg [n:0] a1,b1;
input clock;

output [n:0] out;
reg [n:0] out;

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

        // if(exp1 == exp2 && man1 == man2) // if inputs are having same mag and opp sign.
        // if(inp1[30:0] == inp2[30:0])
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



always @(posedge clock)
begin
	a1 <= a;
	b1 <= b;
	out <= fadd(n+1,e,m,c,fmul(n+1,e,m,a,b));
end

endmodule

