module QR_decomposition(
GO_QR,CLK_QR,
cov11,cov12,cov13,cov14,cov21,cov22,cov23,cov24,cov31,cov32,cov33,cov34,cov41,cov42,cov43,cov44,
E11,E12,E13,E14,E21,E22,E23,E24,E31,E32,E33,E34,E41,E42,E43,E44,
D11,D12,D13,D14,D21,D22,D23,D24,D31,D32,D33,D34,D41,D42,D43,D44,
BUSY_QR);

input GO_QR,CLK_QR;
input [15:0] cov11,cov12,cov13,cov14,cov21,cov22,cov23,cov24,cov31,cov32,cov33,cov34,cov41,cov42,cov43,cov44;
output reg [63:0] E11,E12,E13,E14,E21,E22,E23,E24,E31,E32,E33,E34,E41,E42,E43,E44;
output reg [63:0] D11,D12,D13,D14,D21,D22,D23,D24,D31,D32,D33,D34,D41,D42,D43,D44;
output reg BUSY_QR;

reg [4:0] state, next_state;
reg clk_loop;
reg [63:0] U11,U12,U13,U14,U21,U22,U23,U24,U31,U32,U33,U34,U41,U42,U43,U44;
reg [63:0] u11,u12,u13,u14,u21,u22,u23,u24,u31,u32,u33,u34,u41,u42,u43,u44;
reg [63:0] temp;
reg signed [63:0] R [0:3];
reg [63:0] U [0:3][0:3];
integer m, n, l;

reg go_QR;
wire clk_QR;
reg [63:0] C11,C12,C13,C14,C21,C22,C23,C24,C31,C32,C33,C34,C41,C42,C43,C44;
wire [63:0] Q11,Q12,Q13,Q14,Q21,Q22,Q23,Q24,Q31,Q32,Q33,Q34,Q41,Q42,Q43,Q44;
wire [63:0] R11,R12,R13,R14,R21,R22,R23,R24,R31,R32,R33,R34,R41,R42,R43,R44;
reg [63:0] X11 [0:1],X12 [0:1],X13 [0:1],X14 [0:1],X21 [0:1],X22 [0:1],X23 [0:1],X24 [0:1],X31 [0:1],X32 [0:1],X33 [0:1],X34 [0:1],X41 [0:1],X42 [0:1],X43 [0:1],X44 [0:1];
reg [63:0] Y11 [0:1],Y12 [0:1],Y13 [0:1],Y14 [0:1],Y21 [0:1],Y22 [0:1],Y23 [0:1],Y24 [0:1],Y31 [0:1],Y32 [0:1],Y33 [0:1],Y34 [0:1],Y41 [0:1],Y42 [0:1],Y43 [0:1],Y44 [0:1];
wire [63:0] Z11 [0:1],Z12 [0:1],Z13 [0:1],Z14 [0:1],Z21 [0:1],Z22 [0:1],Z23 [0:1],Z24 [0:1],Z31 [0:1],Z32 [0:1],Z33 [0:1],Z34 [0:1],Z41 [0:1],Z42 [0:1],Z43 [0:1],Z44 [0:1];

QR QR1(go_QR,clk_QR,
C11,C12,C13,C14,C21,C22,C23,C24,C31,C32,C33,C34,C41,C42,C43,C44,
Q11,Q12,Q13,Q14,Q21,Q22,Q23,Q24,Q31,Q32,Q33,Q34,Q41,Q42,Q43,Q44,
R11,R12,R13,R14,R21,R22,R23,R24,R31,R32,R33,R34,R41,R42,R43,R44);

Multiplier Multiplier1(
X11[0],X12[0],X13[0],X14[0],X21[0],X22[0],X23[0],X24[0],X31[0],X32[0],X33[0],X34[0],X41[0],X42[0],X43[0],X44[0],
Y11[0],Y12[0],Y13[0],Y14[0],Y21[0],Y22[0],Y23[0],Y24[0],Y31[0],Y32[0],Y33[0],Y34[0],Y41[0],Y42[0],Y43[0],Y44[0],
Z11[0],Z12[0],Z13[0],Z14[0],Z21[0],Z22[0],Z23[0],Z24[0],Z31[0],Z32[0],Z33[0],Z34[0],Z41[0],Z42[0],Z43[0],Z44[0]);

Multiplier Multiplier2(
X11[1],X12[1],X13[1],X14[1],X21[1],X22[1],X23[1],X24[1],X31[1],X32[1],X33[1],X34[1],X41[1],X42[1],X43[1],X44[1],
Y11[1],Y12[1],Y13[1],Y14[1],Y21[1],Y22[1],Y23[1],Y24[1],Y31[1],Y32[1],Y33[1],Y34[1],Y41[1],Y42[1],Y43[1],Y44[1],
Z11[1],Z12[1],Z13[1],Z14[1],Z21[1],Z22[1],Z23[1],Z24[1],Z31[1],Z32[1],Z33[1],Z34[1],Z41[1],Z42[1],Z43[1],Z44[1]);

assign clk_QR = CLK_QR;

integer k;
always @(posedge CLK_QR) 
begin
    if(!GO_QR) begin
        k = 0;
        clk_loop = 0;
    end
    else begin
        k = k + 1;
        if(k == 16) begin
            k = 0;
            clk_loop = ~ clk_loop;
        end
    end
end

always @(posedge clk_loop or negedge GO_QR) 
    if (!GO_QR) state <= 5'b00000;
    else state <= next_state;

always @(*)
begin
    if (state == 5'b00000) 
        begin
            go_QR <= 0;
            BUSY_QR <= 1; 
            next_state <= 5'b00001;
        end
    else if (state == 5'b00001)
        begin    
            //QR decomposition (i=1)
            go_QR = 1;
            C11 = (cov11<<<48)>>>24; C12 = (cov12<<<48)>>>24; C13 = (cov13<<<48)>>>24; C14 = (cov14<<<48)>>>24;
            C21 = (cov21<<<48)>>>24; C22 = (cov22<<<48)>>>24; C23 = (cov23<<<48)>>>24; C24 = (cov24<<<48)>>>24;
            C31 = (cov31<<<48)>>>24; C32 = (cov32<<<48)>>>24; C33 = (cov33<<<48)>>>24; C34 = (cov34<<<48)>>>24; 
            C41 = (cov41<<<48)>>>24; C42 = (cov42<<<48)>>>24; C43 = (cov43<<<48)>>>24; C44 = (cov44<<<48)>>>24;
                        
            next_state = 5'b00010;
        end
    else if (state == 5'b00010)
        begin
            go_QR = 0;
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // Q를 저장 (U = Q)
            U11 = Q11; U12 = Q12; U13 = Q13; U14 = Q14;
            U21 = Q21; U22 = Q22; U23 = Q23; U24 = Q24;
            U31 = Q31; U32 = Q32; U33 = Q33; U34 = Q34;
            U41 = Q41; U42 = Q42; U43 = Q43; U44 = Q44;              
                  
            next_state = 5'b00011;
        end
    else if(state == 5'b00011)
        begin     
            //QR decomposition (i=2)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b00100;
        end 
    else if(state == 5'b00100)
        begin     
            go_QR = 0;
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = U11; X12[1] = U12; X13[1] = U13; X14[1] = U14;
            X21[1] = U21; X22[1] = U22; X23[1] = U23; X24[1] = U24;
            X31[1] = U31; X32[1] = U32; X33[1] = U33; X34[1] = U34;
            X41[1] = U41; X42[1] = U42; X43[1] = U43; X44[1] = U44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            u11 = Z11[1]; u12 = Z12[1]; u13 = Z13[1]; u14 = Z14[1];
            u21 = Z21[1]; u22 = Z22[1]; u23 = Z23[1]; u24 = Z24[1];
            u31 = Z31[1]; u32 = Z32[1]; u33 = Z33[1]; u34 = Z34[1];
            u41 = Z41[1]; u42 = Z42[1]; u43 = Z43[1]; u44 = Z44[1];    
                        
            next_state = 5'b00101;
        end     
    else if(state == 5'b00101)
        begin   
            //QR decomposition (i=3)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b00110;
        end   
    else if(state == 5'b00110)
        begin       
            go_QR = 0;  
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = u11; X12[1] = u12; X13[1] = u13; X14[1] = u14;
            X21[1] = u21; X22[1] = u22; X23[1] = u23; X24[1] = u24;
            X31[1] = u31; X32[1] = u32; X33[1] = u33; X34[1] = u34;
            X41[1] = u41; X42[1] = u42; X43[1] = u43; X44[1] = u44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            U11 = Z11[1]; U12 = Z12[1]; U13 = Z13[1]; U14 = Z14[1];
            U21 = Z21[1]; U22 = Z22[1]; U23 = Z23[1]; U24 = Z24[1];
            U31 = Z31[1]; U32 = Z32[1]; U33 = Z33[1]; U34 = Z34[1];
            U41 = Z41[1]; U42 = Z42[1]; U43 = Z43[1]; U44 = Z44[1];    
            
            next_state = 5'b00111;
        end        
    else if(state == 5'b00111)
        begin         
            //QR decomposition (i=4)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b01000;
        end        
    else if(state == 5'b01000)
        begin       
            go_QR = 0;  
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = U11; X12[1] = U12; X13[1] = U13; X14[1] = U14;
            X21[1] = U21; X22[1] = U22; X23[1] = U23; X24[1] = U24;
            X31[1] = U31; X32[1] = U32; X33[1] = U33; X34[1] = U34;
            X41[1] = U41; X42[1] = U42; X43[1] = U43; X44[1] = U44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            u11 = Z11[1]; u12 = Z12[1]; u13 = Z13[1]; u14 = Z14[1];
            u21 = Z21[1]; u22 = Z22[1]; u23 = Z23[1]; u24 = Z24[1];
            u31 = Z31[1]; u32 = Z32[1]; u33 = Z33[1]; u34 = Z34[1];
            u41 = Z41[1]; u42 = Z42[1]; u43 = Z43[1]; u44 = Z44[1];    
            
            next_state = 5'b01001;
        end        
    else if(state == 5'b01001)
        begin         
            //QR decomposition (i=5)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            next_state = 5'b01010;
        end        
    else if(state == 5'b01010)
        begin      
            go_QR = 0;   
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = u11; X12[1] = u12; X13[1] = u13; X14[1] = u14;
            X21[1] = u21; X22[1] = u22; X23[1] = u23; X24[1] = u24;
            X31[1] = u31; X32[1] = u32; X33[1] = u33; X34[1] = u34;
            X41[1] = u41; X42[1] = u42; X43[1] = u43; X44[1] = u44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            U11 = Z11[1]; U12 = Z12[1]; U13 = Z13[1]; U14 = Z14[1];
            U21 = Z21[1]; U22 = Z22[1]; U23 = Z23[1]; U24 = Z24[1];
            U31 = Z31[1]; U32 = Z32[1]; U33 = Z33[1]; U34 = Z34[1];
            U41 = Z41[1]; U42 = Z42[1]; U43 = Z43[1]; U44 = Z44[1];    
            
            next_state = 5'b01011;
        end           
    else if(state == 5'b01011)
        begin         
            //QR decomposition (i=6)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b01100;
        end        
    else if(state == 5'b01100)
        begin      
            go_QR = 0;   
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = U11; X12[1] = U12; X13[1] = U13; X14[1] = U14;
            X21[1] = U21; X22[1] = U22; X23[1] = U23; X24[1] = U24;
            X31[1] = U31; X32[1] = U32; X33[1] = U33; X34[1] = U34;
            X41[1] = U41; X42[1] = U42; X43[1] = U43; X44[1] = U44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            u11 = Z11[1]; u12 = Z12[1]; u13 = Z13[1]; u14 = Z14[1];
            u21 = Z21[1]; u22 = Z22[1]; u23 = Z23[1]; u24 = Z24[1];
            u31 = Z31[1]; u32 = Z32[1]; u33 = Z33[1]; u34 = Z34[1];
            u41 = Z41[1]; u42 = Z42[1]; u43 = Z43[1]; u44 = Z44[1];    
            
            next_state = 5'b01101;
        end        
    else if(state == 5'b01101)
        begin         
            //QR decomposition (i=7)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b01110;
        end        
    else if(state == 5'b01110)
        begin    
            go_QR = 0;     
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = u11; X12[1] = u12; X13[1] = u13; X14[1] = u14;
            X21[1] = u21; X22[1] = u22; X23[1] = u23; X24[1] = u24;
            X31[1] = u31; X32[1] = u32; X33[1] = u33; X34[1] = u34;
            X41[1] = u41; X42[1] = u42; X43[1] = u43; X44[1] = u44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            U11 = Z11[1]; U12 = Z12[1]; U13 = Z13[1]; U14 = Z14[1];
            U21 = Z21[1]; U22 = Z22[1]; U23 = Z23[1]; U24 = Z24[1];
            U31 = Z31[1]; U32 = Z32[1]; U33 = Z33[1]; U34 = Z34[1];
            U41 = Z41[1]; U42 = Z42[1]; U43 = Z43[1]; U44 = Z44[1];  
            
            next_state = 5'b01111;
        end        
    else if(state == 5'b01111)
        begin         
            //QR decomposition (i=8)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b10000;
        end        
    else if(state == 5'b10000)
        begin       
            go_QR = 0;  
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = U11; X12[1] = U12; X13[1] = U13; X14[1] = U14;
            X21[1] = U21; X22[1] = U22; X23[1] = U23; X24[1] = U24;
            X31[1] = U31; X32[1] = U32; X33[1] = U33; X34[1] = U34;
            X41[1] = U41; X42[1] = U42; X43[1] = U43; X44[1] = U44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            u11 = Z11[1]; u12 = Z12[1]; u13 = Z13[1]; u14 = Z14[1];
            u21 = Z21[1]; u22 = Z22[1]; u23 = Z23[1]; u24 = Z24[1];
            u31 = Z31[1]; u32 = Z32[1]; u33 = Z33[1]; u34 = Z34[1];
            u41 = Z41[1]; u42 = Z42[1]; u43 = Z43[1]; u44 = Z44[1];  
            
            next_state = 5'b10001;    
        end               
    else if(state == 5'b10001)
        begin         
            //QR decomposition (i=9)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b10010;    
        end              
    else if(state == 5'b10010)
        begin        
            go_QR = 0; 
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = u11; X12[1] = u12; X13[1] = u13; X14[1] = u14;
            X21[1] = u21; X22[1] = u22; X23[1] = u23; X24[1] = u24;
            X31[1] = u31; X32[1] = u32; X33[1] = u33; X34[1] = u34;
            X41[1] = u41; X42[1] = u42; X43[1] = u43; X44[1] = u44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            U11 = Z11[1]; U12 = Z12[1]; U13 = Z13[1]; U14 = Z14[1];
            U21 = Z21[1]; U22 = Z22[1]; U23 = Z23[1]; U24 = Z24[1];
            U31 = Z31[1]; U32 = Z32[1]; U33 = Z33[1]; U34 = Z34[1];
            U41 = Z41[1]; U42 = Z42[1]; U43 = Z43[1]; U44 = Z44[1];  
            
            next_state = 5'b10011;    
        end              
    else if(state == 5'b10011)
        begin         
            //QR decomposition (i=10)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b10100;    
        end              
    else if(state == 5'b10100)
        begin         
            go_QR = 0;
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = U11; X12[1] = U12; X13[1] = U13; X14[1] = U14;
            X21[1] = U21; X22[1] = U22; X23[1] = U23; X24[1] = U24;
            X31[1] = U31; X32[1] = U32; X33[1] = U33; X34[1] = U34;
            X41[1] = U41; X42[1] = U42; X43[1] = U43; X44[1] = U44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            u11 = Z11[1]; u12 = Z12[1]; u13 = Z13[1]; u14 = Z14[1];
            u21 = Z21[1]; u22 = Z22[1]; u23 = Z23[1]; u24 = Z24[1];
            u31 = Z31[1]; u32 = Z32[1]; u33 = Z33[1]; u34 = Z34[1];
            u41 = Z41[1]; u42 = Z42[1]; u43 = Z43[1]; u44 = Z44[1];  
            
            next_state = 5'b10101;    
        end             
    else if(state == 5'b10101)
        begin         
            //QR decomposition (i=11)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0]; 
            
            next_state = 5'b10110;    
        end        
    else if(state == 5'b10110)
        begin         
            go_QR = 0;
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = u11; X12[1] = u12; X13[1] = u13; X14[1] = u14;
            X21[1] = u21; X22[1] = u22; X23[1] = u23; X24[1] = u24;
            X31[1] = u31; X32[1] = u32; X33[1] = u33; X34[1] = u34;
            X41[1] = u41; X42[1] = u42; X43[1] = u43; X44[1] = u44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            U11 = Z11[1]; U12 = Z12[1]; U13 = Z13[1]; U14 = Z14[1];
            U21 = Z21[1]; U22 = Z22[1]; U23 = Z23[1]; U24 = Z24[1];
            U31 = Z31[1]; U32 = Z32[1]; U33 = Z33[1]; U34 = Z34[1];
            U41 = Z41[1]; U42 = Z42[1]; U43 = Z43[1]; U44 = Z44[1];
            
            next_state = 5'b10111;    
        end        
    else if(state == 5'b10111)
        begin         
            //QR decomposition (i=12)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0];
            
            next_state = 5'b11000;    
        end
    else if(state == 5'b11000)
        begin         
            go_QR = 0;
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = U11; X12[1] = U12; X13[1] = U13; X14[1] = U14;
            X21[1] = U21; X22[1] = U22; X23[1] = U23; X24[1] = U24;
            X31[1] = U31; X32[1] = U32; X33[1] = U33; X34[1] = U34;
            X41[1] = U41; X42[1] = U42; X43[1] = U43; X44[1] = U44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            u11 = Z11[1]; u12 = Z12[1]; u13 = Z13[1]; u14 = Z14[1];
            u21 = Z21[1]; u22 = Z22[1]; u23 = Z23[1]; u24 = Z24[1];
            u31 = Z31[1]; u32 = Z32[1]; u33 = Z33[1]; u34 = Z34[1];
            u41 = Z41[1]; u42 = Z42[1]; u43 = Z43[1]; u44 = Z44[1];  
            
            next_state = 5'b11001;    
        end        
    else if(state == 5'b11001)
        begin         
            //QR decomposition (i=13)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0];
            
            next_state = 5'b11010;    
        end                                      
    else if(state == 5'b11010)
        begin       
            go_QR = 0;  
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = u11; X12[1] = u12; X13[1] = u13; X14[1] = u14;
            X21[1] = u21; X22[1] = u22; X23[1] = u23; X24[1] = u24;
            X31[1] = u31; X32[1] = u32; X33[1] = u33; X34[1] = u34;
            X41[1] = u41; X42[1] = u42; X43[1] = u43; X44[1] = u44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            U11 = Z11[1]; U12 = Z12[1]; U13 = Z13[1]; U14 = Z14[1];
            U21 = Z21[1]; U22 = Z22[1]; U23 = Z23[1]; U24 = Z24[1];
            U31 = Z31[1]; U32 = Z32[1]; U33 = Z33[1]; U34 = Z34[1];
            U41 = Z41[1]; U42 = Z42[1]; U43 = Z43[1]; U44 = Z44[1];
            
            next_state = 5'b11011;
        end        
    else if(state == 5'b11011)
        begin         
            //QR decomposition (i=14)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0];
            
            next_state = 5'b11100;
        end        
    else if(state == 5'b11100)
        begin         
            go_QR = 0;
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = U11; X12[1] = U12; X13[1] = U13; X14[1] = U14;
            X21[1] = U21; X22[1] = U22; X23[1] = U23; X24[1] = U24;
            X31[1] = U31; X32[1] = U32; X33[1] = U33; X34[1] = U34;
            X41[1] = U41; X42[1] = U42; X43[1] = U43; X44[1] = U44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            u11 = Z11[1]; u12 = Z12[1]; u13 = Z13[1]; u14 = Z14[1];
            u21 = Z21[1]; u22 = Z22[1]; u23 = Z23[1]; u24 = Z24[1];
            u31 = Z31[1]; u32 = Z32[1]; u33 = Z33[1]; u34 = Z34[1];
            u41 = Z41[1]; u42 = Z42[1]; u43 = Z43[1]; u44 = Z44[1];  
            
            next_state = 5'b11101;
        end        
    else if(state == 5'b11101)
        begin         
            //QR decomposition (i=15)
            go_QR = 1;
            C11 = Z11[0]; C12 = Z12[0]; C13 = Z13[0]; C14 = Z14[0];
            C21 = Z21[0]; C22 = Z22[0]; C23 = Z23[0]; C24 = Z24[0];
            C31 = Z31[0]; C32 = Z32[0]; C33 = Z33[0]; C34 = Z34[0]; 
            C41 = Z41[0]; C42 = Z42[0]; C43 = Z43[0]; C44 = Z44[0];
            
            next_state = 5'b11110;
        end        
    else if(state == 5'b11110)
        begin         
            go_QR = 0;
            //행렬곱 RQ 구하기
            X11[0] = R11; X12[0] = R12; X13[0] = R13; X14[0] = R14;
            X21[0] = R21; X22[0] = R22; X23[0] = R23; X24[0] = R24;
            X31[0] = R31; X32[0] = R32; X33[0] = R33; X34[0] = R34;
            X41[0] = R41; X42[0] = R42; X43[0] = R43; X44[0] = R44;
            Y11[0] = Q11; Y12[0] = Q12; Y13[0] = Q13; Y14[0] = Q14;
            Y21[0] = Q21; Y22[0] = Q22; Y23[0] = Q23; Y24[0] = Q24;
            Y31[0] = Q31; Y32[0] = Q32; Y33[0] = Q33; Y34[0] = Q34;
            Y41[0] = Q41; Y42[0] = Q42; Y43[0] = Q43; Y44[0] = Q44; 
            
            // U = UQ
            X11[1] = u11; X12[1] = u12; X13[1] = u13; X14[1] = u14;
            X21[1] = u21; X22[1] = u22; X23[1] = u23; X24[1] = u24;
            X31[1] = u31; X32[1] = u32; X33[1] = u33; X34[1] = u34;
            X41[1] = u41; X42[1] = u42; X43[1] = u43; X44[1] = u44;
            Y11[1] = Q11; Y12[1] = Q12; Y13[1] = Q13; Y14[1] = Q14;
            Y21[1] = Q21; Y22[1] = Q22; Y23[1] = Q23; Y24[1] = Q24;
            Y31[1] = Q31; Y32[1] = Q32; Y33[1] = Q33; Y34[1] = Q34;
            Y41[1] = Q41; Y42[1] = Q42; Y43[1] = Q43; Y44[1] = Q44;              
            U11 = Z11[1]; U12 = Z12[1]; U13 = Z13[1]; U14 = Z14[1];
            U21 = Z21[1]; U22 = Z22[1]; U23 = Z23[1]; U24 = Z24[1];
            U31 = Z31[1]; U32 = Z32[1]; U33 = Z33[1]; U34 = Z34[1];
            U41 = Z41[1]; U42 = Z42[1]; U43 = Z43[1]; U44 = Z44[1];
            
            next_state = 5'b11111;
        end        
    else if(state == 5'b11111) // sorting
        begin                 
            R[0] = R11;
            R[1] = R22;
            R[2] = R33;
            R[3] = R44;       
            
            U[0][0] = U11;
            U[0][1] = U12;
            U[0][2] = U13;
            U[0][3] = U14;
            U[1][0] = U21;
            U[1][1] = U22;
            U[1][2] = U23;
            U[1][3] = U24;
            U[2][0] = U31;
            U[2][1] = U32;
            U[2][2] = U33;
            U[2][3] = U34;
            U[3][0] = U41;
            U[3][1] = U42;
            U[3][2] = U43;
            U[3][3] = U44;

            for (m = 0; m < 3; m = m + 1) begin
                for (n = 0 ; n < 3 - m; n = n + 1) begin
                    if (R[n] > R[n + 1]) begin
                        temp = R[n];
                        R[n] = R[n + 1];
                        R[n + 1] = temp;

                        for (l = 0; l < 4; l = l + 1) begin
                            temp = U[l][n];
                            U[l][n] = U[l][n + 1];
                            U[l][n + 1] = temp;  
                        end
                    end
                end
            end
            
            D11 = R[0];
            D12 = 64'b0;
            D13 = 64'b0;
            D14 = 64'b0;
            D21 = 64'b0;
            D22 = R[1];
            D23 = 64'b0;
            D24 = 64'b0;
            D31 = 64'b0;
            D32 = 64'b0;
            D33 = R[2];
            D34 = 64'b0;
            D41 = 64'b0;
            D42 = 64'b0;
            D43 = 64'b0;
            D44 = R[3];
           
            E11 = U[0][0];
            E12 = U[0][1];
            E13 = U[0][2];
            E14 = U[0][3];
            E21 = U[1][0]; 
            E22 = U[1][1]; 
            E23 = U[1][2];
            E24 = U[1][3]; 
            E31 = U[2][0]; 
            E32 = U[2][1]; 
            E33 = U[2][2]; 
            E34 = U[2][3]; 
            E41 = U[3][0]; 
            E42 = U[3][1]; 
            E43 = U[3][2];
            E44 = U[3][3];
            
            BUSY_QR =0;
        end                                         
end        
endmodule