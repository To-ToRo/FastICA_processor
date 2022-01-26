module QR(
go_QR,clk_QR,
C11,C12,C13,C14,C21,C22,C23,C24,C31,C32,C33,C34,C41,C42,C43,C44,
Q11,Q12,Q13,Q14,Q21,Q22,Q23,Q24,Q31,Q32,Q33,Q34,Q41,Q42,Q43,Q44,
R11,R12,R13,R14,R21,R22,R23,R24,R31,R32,R33,R34,R41,R42,R43,R44);

input go_QR,clk_QR;
input [63:0] C11,C12,C13,C14,C21,C22,C23,C24,C31,C32,C33,C34,C41,C42,C43,C44;
output reg [63:0] Q11,Q12,Q13,Q14,Q21,Q22,Q23,Q24,Q31,Q32,Q33,Q34,Q41,Q42,Q43,Q44;
output reg [63:0] R11,R12,R13,R14,R21,R22,R23,R24,R31,R32,R33,R34,R41,R42,R43,R44;

reg [63:0] a1 [0:3];
reg [63:0] a2 [0:3];
reg [63:0] a3 [0:3];
reg [63:0] a4 [0:3];

reg [63:0] u1 [0:3];
reg [63:0] u2 [0:3];
reg [63:0] u3 [0:3];
reg [63:0] u4 [0:3];

reg [63:0] e1 [0:3];
reg [63:0] e2 [0:3];
reg [63:0] e3 [0:3];
reg [63:0] e4 [0:3];

reg [4:0] state, next_state;

reg [63:0] X [0:3];
reg [63:0] Y [0:3];
reg [63:0] t1,t2,t3;
reg [63:0] r1,r2,r3,r4;

reg [63:0] m1 [0:3];
reg [63:0] m2 [0:3];
reg [63:0] d1 [0:3];
reg [63:0] d2 [0:3];
reg [63:0] s1;
wire [63:0] m3 [0:3];
wire [63:0] d3 [0:3];
wire [63:0] s2;

QR_mul QR_mul1(m1[0],m2[0],m3[0]);
QR_mul QR_mul2(m1[1],m2[1],m3[1]);
QR_mul QR_mul3(m1[2],m2[2],m3[2]);
QR_mul QR_mul4(m1[3],m2[3],m3[3]);
divider QR_div1(d1[0],d2[0],d3[0]);
divider QR_div2(d1[1],d2[1],d3[1]);
divider QR_div3(d1[2],d2[2],d3[2]);
divider QR_div4(d1[3],d2[3],d3[3]);
sqrt QR_sqrt(s1,s2);

always @(posedge clk_QR or negedge go_QR) 
    if (!go_QR) state <= 5'b00000;
    else state <= next_state;

always @(*)
begin
    if (state == 5'b00000) next_state = 5'b00001;
    else if (state == 5'b00001) //a1, a2, a3, a4, u1
        begin  
            a1[0] = C11; a1[1] = C21; a1[2] = C31; a1[3] = C41;
            a2[0] = C12; a2[1] = C22; a2[2] = C32; a2[3] = C42;
            a3[0] = C13; a3[1] = C23; a3[2] = C33; a3[3] = C43;
            a4[0] = C14; a4[1] = C24; a4[2] = C34; a4[3] = C44;
                       
            u1[0] = a1[0];
            u1[1] = a1[1]; 
            u1[2] = a1[2];
            u1[3] = a1[3];
            next_state = 5'b00010;
        end
    else if (state == 5'b00010) //u1[0]*a2[0] + u1[1]*a2[1] + u1[2]*a2[2] + u1[3]*a2[3]
        begin
            m1[0] = u1[0];
            m2[0] = a2[0];
            m1[1] = u1[1];
            m2[1] = a2[1];
            m1[2] = u1[2];
            m2[2] = a2[2];
            m1[3] = u1[3];
            m2[3] = a2[3];
            t1 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b00011;
        end
    else if (state == 5'b00011) //r1 = u1[0]**2 + u1[1]**2 + u1[2]**2 + u1[3]**2
        begin
            //m1[0] = u1[0];
            m2[0] = u1[0];
            //m1[1] = u1[1];
            m2[1] = u1[1];
            //m1[2] = u1[2];
            m2[2] = u1[2];
            //m1[3] = u1[3];
            m2[3] = u1[3];
            r1 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b00100;
        end
    else if (state == 5'b00100) //u2[0], u2[1], u2[2], u2[3]
        begin
            m1[0] = t1;
            m2[0] = u1[0];
            d1[0] = m3[0];
            d2[0] = r1;
            u2[0] = a2[0] - d3[0];
            
            m1[1] = t1;
            m2[1] = u1[1];
            d1[1] = m3[1];
            d2[1] = r1;
            u2[1] = a2[1] - d3[1];
            
            m1[2] = t1;
            m2[2] = u1[2];
            d1[2] = m3[2];
            d2[2] = r1;
            u2[2] = a2[2] - d3[2];
            
            m1[3] = t1;
            m2[3] = u1[3];
            d1[3] = m3[3];
            d2[3] = r1;
            u2[3] = a2[3] - d3[3];
            
            /*
            d1[0] = t1;
            d2[0] = r1; // d3[0] = (u1[0]*a2[0] + u1[1]*a2[1] + u1[2]*a2[2] + u1[3]*a2[3])/(u1[0]**2 + u1[1]**2 + u1[2]**2 + u1[3]**2)
            //m1[0] = u1[0];
            m2[0] = d3[0];
            u2[0] = a2[0] - m3[0];
            //m1[1] = u1[1];
            m2[1] = d3[0];
            u2[1] = a2[1] - m3[1];
            //m1[2] = u1[2];
            m2[2] = d3[0];
            u2[2] = a2[2] - m3[2];
            //m1[3] = u1[3];
            m2[3] = d3[0];
            u2[3] = a2[3] - m3[3];
            */
            next_state = 5'b00101;
        end
    else if (state == 5'b00101) //u1[0]*a3[0] + u1[1]*a3[1] + u1[2]*a3[2] + u1[3]*a3[3]
        begin
            m1[0] = a3[0];
            //m2[0] = u1[0];
            m1[1] =  a3[1];
            //m2[1] = u1[1];
            m1[2] = a3[2];
            //m2[2] = u1[2];
            m1[3] = a3[3];
            //m2[3] = u1[3];
            t1 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b00110;
        end
    else if (state == 5'b00110) //u2[0]*a3[0] + u2[1]*a3[1] + u2[2]*a3[2] + u2[3]*a3[3]
        begin
            //m1[0] = a3[0];
            m2[0] = u2[0];
            //m1[1] = a3[1];
            m2[1] = u2[1];
            //m1[2] = a3[2];
            m2[2] = u2[2];
            //m1[3] = a3[3];
            m2[3] = u2[3];
            t2 = m3[0] + m3[1] + m3[2] + m3[3]; //error..
            next_state = 5'b00111;
        end
    else if(state == 5'b00111) //r2 = u2[0]**2 + u2[1]**2 + u2[2]**2 + u2[3]**2
        begin
            m1[0] = u2[0];
            //m2[0] = u2[0];
            m1[1] = u2[1];
            //m2[1] = u2[1];
            m1[2] = u2[2];
            //m2[2] = u2[2];
            m1[3] = u2[3];
            //m2[3] = u2[3];
            r2 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b01000;
        end
    else if(state == 5'b01000) //u3[0], u3[1]
        begin
            m1[0] = t1;
            m2[0] = u1[0];
            d1[0] = m3[0];
            //d2[0] = r1;
            
            m1[1] = t2;
            m2[1] = u2[0];
            d1[1] = m3[1];
            d2[1] = r2;
            
            u3[0] = a3[0] - d3[0] - d3[1];
            
            m1[2] = t1;
            m2[2] = u1[1];
            d1[2] = m3[2];
            //d2[2] = r1;
            
            m1[3] = t2;
            m2[3] = u2[1];
            d1[3] = m3[3];
            d2[3] = r2;
            
            u3[1] = a3[1] - d3[2] - d3[3];
            
            /*
            d1[0] = t1;
            d2[0] = r1; //d3[0] = (u1[0]*a3[0] + u1[1]*a3[1] + u1[2]*a3[2] + u1[3]*a3[3])/(u1[0]**2 + u1[1]**2 + u1[2]**2 + u1[3]**2)
            m1[0] = d3[0];
            m2[0] = u1[0];
            X[0] = m3[0];
            m1[1] = d3[0];
            m2[1] = u1[1];
            X[1] = m3[1];
            m1[2] = d3[0];
            m2[2] = u1[2];
            X[2] = m3[2];
            m1[3] = d3[0];
            m2[3] = u1[3];
            X[3] = m3[3];
            */
            next_state = 5'b01001;
        end
    else if(state == 5'b01001) //u3[2], u3[3]
        begin     
            //m1[0] = t1;
            m2[0] = u1[2];
            d1[0] = m3[0];
            //d2[0] = r1;
            
            //m1[1] = t2;
            m2[1] = u2[2];
            d1[1] = m3[1];
            //d2[1] = r2;
            
            u3[2] = a3[2] - d3[0] - d3[1];
            
            //m1[2] = t1;
            m2[2] = u1[3];
            d1[2] = m3[2];
            //d2[2] = r1;
            
            //m1[3] = t2;
            m2[3] = u2[3];
            d1[3] = m3[3];
            //d2[3] = r2;
            
            u3[3] = a3[3] - d3[2] - d3[3];
            
            /*
            d1[0] = t2;
            d2[0] = r2; //d3[0] = (u2[0]*a3[0] + u2[1]*a3[1] + u2[2]*a3[2] + u2[3]*a3[3])/(u2[0]**2 + u2[1]**2 + u2[2]**2 + u2[3]**2)
            m1[0] = d3[0];
            m2[0] = u2[0];
            m1[1] = d3[0];
            m2[1] = u2[1];
            m1[2] = d3[0];
            m2[2] = u2[2];
            m1[3] = d3[0];
            m2[3] = u2[3];
            
            u3[0] = a3[0] - X[0] - m3[0];
            u3[1] = a3[1] - X[1] - m3[1];
            u3[2] = a3[2] - X[2] - m3[2];
            u3[3] = a3[3] - X[3] - m3[3];
            */
            next_state = 5'b01010;
        end
    else if(state == 5'b01010) //u1[0]*a4[0] + u1[1]*a4[1] + u1[2]*a4[2] + u1[3]*a4[3]
        begin     
            m1[0] = u1[0];
            m2[0] = a4[0];
            m1[1] = u1[1];
            m2[1] = a4[1];
            m1[2] = u1[2];
            m2[2] = a4[2];
            m1[3] = u1[3];
            m2[3] = a4[3];
            t1 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b01011;
        end
    else if(state == 5'b01011) //u2[0]*a4[0] + u2[1]*a4[1] + u2[2]*a4[2] + u2[3]*a4[3]
        begin     
            m1[0] = u2[0];
            //m2[0] = a4[0];
            m1[1] = u2[1];
            //m2[1] = a4[1];
            m1[2] = u2[2];
            //m2[2] = a4[2];
            m1[3] = u2[3];
            //m2[3] = a4[3];
            t2 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b01100;
        end
    else if(state == 5'b01100) //u3[0]*a4[0] + u3[1]*a4[1] + u3[2]*a4[2] + u3[3]*a4[3]
        begin     
            m1[0] = u3[0];
            //m2[0] = a4[0];
            m1[1] = u3[1];
            //m2[1] = a4[1];
            m1[2] = u3[2];
            //m2[2] = a4[2];
            m1[3] = u3[3];
            //m2[3] = a4[3];
            t3 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b01101;
        end
    else if(state == 5'b01101) //r3 = u3[0]**2 + u3[1]**2 + u3[2]**2 + u3[3]**2
        begin     
            //m1[0] = u3[0];
            m2[0] = u3[0];
            //m1[1] = u3[1];
            m2[1] = u3[1];
            //m1[2] = u3[2];
            m2[2] = u3[2];
            //m1[3] = u3[3];
            m2[3] = u3[3];
            r3 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b01110;
        end
    else if(state == 5'b01110) 
        begin 
            m1[0] = t1;
            m2[0] = u1[0];
            d1[0] = m3[0];
            //d2[0] = r1;
            X[0] = d3[0];
            
            m1[1] = t1;
            m2[1] = u1[1];
            d1[1] = m3[1];
            d2[1] = r1;
            X[1] = d3[1];
            
            m1[2] = t1;
            m2[2] = u1[2];
            d1[2] = m3[2];
            //d2[2] = r1;
            X[2] = d3[2];
            
            m1[3] = t1;
            m2[3] = u1[3];
            d1[3] = m3[3];
            d2[3] = r1;
            X[3] = d3[3];
            
            /*    
            d1[0] = t1;
            d2[0] = r1; //d3[0] = (u1[0]*a4[0] + u1[1]*a4[1] + u1[2]*a4[2] + u1[3]*a4[3])/(u1[0]**2 + u1[1]**2 + u1[2]**2 + u1[3]**2)
            m1[0] = d3[0];
            m2[0] = u1[0];
            X[0] = m3[0];
            m1[1] = d3[0];
            m2[1] = u1[1];
            X[1] = m3[1];
            m1[2] = d3[0];
            m2[2] = u1[2];
            X[2] = m3[2];
            m1[3] = d3[0];
            m2[3] = u1[3];
            X[3] = m3[3];
            */
            next_state = 5'b01111;
        end
    else if(state == 5'b01111) 
        begin     
            m1[0] = t2;
            m2[0] = u2[0];
            d1[0] = m3[0];
            d2[0] = r2;
            Y[0] = d3[0];
            
            m1[1] = t2;
            m2[1] = u2[1];
            d1[1] = m3[1];
            d2[1] = r2;
            Y[1] = d3[1];
            
            m1[2] = t2;
            m2[2] = u2[2];
            d1[2] = m3[2];
            d2[2] = r2;
            Y[2] = d3[2];
            
            m1[3] = t2;
            m2[3] = u2[3];
            d1[3] = m3[3];
            d2[3] = r2;
            Y[3] = d3[3];
            
            /*
            d1[0] = t2;
            d2[0] = r2; //d3[0] = (u2[0]*a4[0] + u2[1]*a4[1] + u2[2]*a4[2] + u2[3]*a4[3])/(u2[0]**2 + u2[1]**2 + u2[2]**2 + u2[3]**2)
            m1[0] = d3[0];
            m2[0] = u2[0];
            Y[0] = m3[0];
            m1[1] = d3[0];
            m2[1] = u2[1];
            Y[1] = m3[1];
            m1[2] = d3[0];
            m2[2] = u2[2];
            Y[2] = m3[2];
            m1[3] = d3[0];
            m2[3] = u2[3];
            Y[3] = m3[3];
            */
            next_state = 5'b10000;
        end
    else if(state == 5'b10000) //u4[0], u4[1], u4[2], u4[3]
        begin     
            m1[0] = t3;
            m2[0] = u3[0];
            d1[0] = m3[0];
            d2[0] = r3;
            
            m1[1] = t3;
            m2[1] = u3[1];
            d1[1] = m3[1];
            d2[1] = r3;
            
            m1[2] = t3;
            m2[2] = u3[2];
            d1[2] = m3[2];
            d2[2] = r3;
            
            m1[3] = t3;
            m2[3] = u3[3];
            d1[3] = m3[3];
            d2[3] = r3;
            
            u4[0] = a4[0] - X[0] - Y[0] - d3[0];
            u4[1] = a4[1] - X[1] - Y[1] - d3[1];
            u4[2] = a4[2] - X[2] - Y[2] - d3[2];
            u4[3] = a4[3] - X[3] - Y[3] - d3[3];
            
            /*
            d1[0] = t3;
            d2[0] = r3; //d3[0] = (u3[0]*a4[0] + u3[1]*a4[1] + u3[2]*a4[2] + u3[3]*a4[3])/(u3[0]**2 + u3[1]**2 + u3[2]**2 + u3[3]**2)
            m1[0] = d3[0];
            m2[0] = u3[0];
            m1[1] = d3[0];
            m2[1] = u3[1];
            m1[2] = d3[0];
            m2[2] = u3[2];
            m1[3] = d3[0];
            m2[3] = u3[3];
            
            u4[0] = a4[0] - X[0] - Y[0] - m3[0];
            u4[1] = a4[1] - X[1] - Y[1] - m3[1];
            u4[2] = a4[2] - X[2] - Y[2] - m3[2];
            u4[3] = a4[3] - X[3] - Y[3] - m3[3];
            */
            next_state = 5'b10001;
        end
    else if(state == 5'b10001) //e1[0], e1[1], e1[2], e1[3]
        begin     
            s1 = r1;
            d1[0] = u1[0];
            d1[1] = u1[1];
            d1[2] = u1[2];
            d1[3] = u1[3];
            d2[0] = s2;
            d2[1] = s2;
            d2[2] = s2;
            d2[3] = s2;

            e1[0] = d3[0];
            e1[1] = d3[1];
            e1[2] = d3[2];
            e1[3] = d3[3];
            next_state = 5'b10010;
        end
    else if(state == 5'b10010) //e2[0], e2[1], e2[2], e2[3]
        begin     
            s1 = r2;
            d1[0] = u2[0];
            d1[1] = u2[1];
            d1[2] = u2[2];
            d1[3] = u2[3];
            d2[0] = s2;
            d2[1] = s2;
            d2[2] = s2;
            d2[3] = s2;

            e2[0] = d3[0];
            e2[1] = d3[1];
            e2[2] = d3[2];
            e2[3] = d3[3];
            next_state = 5'b10011;
        end                
    else if(state == 5'b10011) //e3[0], e3[1], e3[2], e3[3]
        begin     
            s1 = r3;
            d1[0] = u3[0];
            d1[1] = u3[1];
            d1[2] = u3[2];
            d1[3] = u3[3];
            d2[0] = s2;
            d2[1] = s2;
            d2[2] = s2;
            d2[3] = s2;

            e3[0] = d3[0];
            e3[1] = d3[1];
            e3[2] = d3[2];
            e3[3] = d3[3];
            next_state = 5'b10100;
        end      
    else if(state == 5'b10100) //e4[0], e4[1], e4[2], e4[3]
        begin     
            m1[0] = u4[0];
            m2[0] = u4[0];
            m1[1] = u4[1];
            m2[1] = u4[1];
            m1[2] = u4[2];
            m2[2] = u4[2];
            m1[3] = u4[3];
            m2[3] = u4[3];
            r4 = m3[0] + m3[1] + m3[2] + m3[3];
            
            s1 = r4;
            d1[0] = u4[0];
            d1[1] = u4[1];
            d1[2] = u4[2];
            d1[3] = u4[3];
            d2[0] = s2;
            d2[1] = s2;
            d2[2] = s2;
            d2[3] = s2;

            e4[0] = d3[0];
            e4[1] = d3[1];
            e4[2] = d3[2];
            e4[3] = d3[3];
            next_state = 5'b10101;
        end      
    else if(state == 5'b10101) //Q
        begin     
            Q11 = e1[0]; Q21 = e1[1]; Q31 = e1[2]; Q41 = e1[3];
            Q12 = e2[0]; Q22 = e2[1]; Q32 = e2[2]; Q42 = e2[3];           
            Q13 = e3[0]; Q23 = e3[1]; Q33 = e3[2]; Q43 = e3[3];
            Q14 = e4[0]; Q24 = e4[1]; Q34 = e4[2]; Q44 = e4[3];    
                    
            next_state = 5'b10110;
        end      
    else if(state == 5'b10110) //R11
        begin     
            m1[0] = a1[0];
            m2[0] = e1[0];
            m1[1] = a1[1];
            m2[1] = e1[1];
            m1[2] = a1[2];
            m2[2] = e1[2];
            m1[3] = a1[3];
            m2[3] = e1[3]; 
            R11 = m3[0] + m3[1] + m3[2] + m3[3];    
            next_state = 5'b10111;
        end      
    else if(state == 5'b10111) //R12
        begin     
            m1[0] = a2[0];
            //m2[0] = e1[0];
            m1[1] = a2[1];
            //m2[1] = e1[1];
            m1[2] = a2[2];
            //m2[2] = e1[2];
            m1[3] = a2[3];
            //m2[3] = e1[3]; 
            R12 = m3[0] + m3[1] + m3[2] + m3[3];    
            next_state = 5'b11000;
        end 
    else if(state == 5'b11000) //R13
        begin     
            m1[0] = a3[0];
            //m2[0] = e1[0];
            m1[1] = a3[1];
            //m2[1] = e1[1];
            m1[2] = a3[2];
            //m2[2] = e1[2];
            m1[3] = a3[3];
            //m2[3] = e1[3]; 
            R13 = m3[0] + m3[1] + m3[2] + m3[3]; 
            next_state = 5'b11001;
        end 
    else if(state == 5'b11001) //R14
        begin     
            m1[0] = a4[0];
            //m2[0] = e1[0];
            m1[1] = a4[1];
            //m2[1] = e1[1];
            m1[2] = a4[2];
            //m2[2] = e1[2];
            m1[3] = a4[3];
            //m2[3] = e1[3]; 
            R14 = m3[0] + m3[1] + m3[2] + m3[3]; 
            next_state = 5'b11010;
        end 
    else if(state == 5'b11010) //R21, R22
        begin     
            R21 = 64'b0;
            m1[0] = a2[0];
            m2[0] = e2[0];
            m1[1] = a2[1];
            m2[1] = e2[1];
            m1[2] = a2[2];
            m2[2] = e2[2];
            m1[3] = a2[3];
            m2[3] = e2[3]; 
            R22 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b11011;
        end 
    else if(state == 5'b11011) //R23
        begin     
            m1[0] = a3[0];
            //m2[0] = e2[0];
            m1[1] = a3[1];
            //m2[1] = e2[1];
            m1[2] = a3[2];
            //m2[2] = e2[2];
            m1[3] = a3[3];
            //m2[3] = e2[3]; 
            R23 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b11100;
        end 
    else if(state == 5'b11100) //R24
        begin     
            m1[0] = a4[0];
            //m2[0] = e2[0];
            m1[1] = a4[1];
            //m2[1] = e2[1];
            m1[2] = a4[2];
            //m2[2] = e2[2];
            m1[3] = a4[3];
            //m2[3] = e2[3]; 
            R24 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b11101;
        end 
    else if(state == 5'b11101) //R31, R32, R33
        begin     
            R31 = 64'b0;
            R32 = 64'b0;
            m1[0] = a3[0];
            m2[0] = e3[0];
            m1[1] = a3[1];
            m2[1] = e3[1];
            m1[2] = a3[2];
            m2[2] = e3[2];
            m1[3] = a3[3];
            m2[3] = e3[3]; 
            R33 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b11110;
        end 
    else if(state == 5'b11110) //R34
        begin     
            m1[0] = a4[0];
            //m2[0] = e3[0];
            m1[1] = a4[1];
            //m2[1] = e3[1];
            m1[2] = a4[2];
            //m2[2] = e3[2];
            m1[3] = a4[3];
            //m2[3] = e3[3]; 
            R34 = m3[0] + m3[1] + m3[2] + m3[3];
            next_state = 5'b11111;
        end 
    else if(state == 5'b11111) //R41, R42, R43, R44
        begin     
            R41 = 64'b0;
            R42 = 64'b0;
            R43 = 64'b0;
            //m1[0] = a4[0];
            m2[0] = e4[0];
            //m1[1] = a4[1];
            m2[1] = e4[1];
            //m1[2] = a4[2];
            m2[2] = e4[2];
            //m1[3] = a4[3];
            m2[3] = e4[3]; 
            R44 = m3[0] + m3[1] + m3[2] + m3[3];
        end 
end
endmodule