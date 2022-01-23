module Eigen_Conditioning_Block(
En_eig,
CLK_eig,
E11,E12,E13,E14,
E21,E22,E23,E24,
E31,E32,E33,E34,
E41,E42,E43,E44,
D11,D12,D13,D14,
D21,D22,D23,D24,
D31,D32,D33,D34,
D41,D42,D43,D44,
E_T11,E_T12,E_T13,E_T14,
E_T21,E_T22,E_T23,E_T24,
E_T31,E_T32,E_T33,E_T34,
E_T41,E_T42,E_T43,E_T44,
D_inv_sqrt11,D_inv_sqrt12,D_inv_sqrt13,D_inv_sqrt14,
D_inv_sqrt21,D_inv_sqrt22,D_inv_sqrt23,D_inv_sqrt24,
D_inv_sqrt31,D_inv_sqrt32,D_inv_sqrt33,D_inv_sqrt34,
D_inv_sqrt41,D_inv_sqrt42,D_inv_sqrt43,D_inv_sqrt44
);

input En_eig,CLK_eig;
input [63:0] E11,E12,E13,E14,E21,E22,E23,E24,E31,E32,E33,E34,E41,E42,E43,E44;
input [63:0] D11,D12,D13,D14,D21,D22,D23,D24,D31,D32,D33,D34,D41,D42,D43,D44;
output reg signed [63:0] E_T11,E_T12,E_T13,E_T14,E_T21,E_T22,E_T23,E_T24,E_T31,E_T32,E_T33,E_T34,E_T41,E_T42,E_T43,E_T44;
output reg signed [63:0] D_inv_sqrt11,D_inv_sqrt12,D_inv_sqrt13,D_inv_sqrt14;
output reg signed [63:0] D_inv_sqrt21,D_inv_sqrt22,D_inv_sqrt23,D_inv_sqrt24;
output reg signed [63:0] D_inv_sqrt31,D_inv_sqrt32,D_inv_sqrt33,D_inv_sqrt34;
output reg signed [63:0] D_inv_sqrt41,D_inv_sqrt42,D_inv_sqrt43,D_inv_sqrt44;

reg signed [63:0] d1 [0:3];
reg signed [63:0] d2 [0:3];
wire signed [63:0] d3 [0:3];
divider Eig_div1(d1[0],d2[0],d3[0]);
divider Eig_div2(d1[1],d2[1],d3[1]);
divider Eig_div3(d1[2],d2[2],d3[2]);
divider Eig_div4(d1[3],d2[3],d3[3]);

reg [63:0] s1 [0:3];
wire [63:0] s2 [0:3];
sqrt Eig_sqrt1(s1[0],s2[0]);
sqrt Eig_sqrt2(s1[1],s2[1]);
sqrt Eig_sqrt3(s1[2],s2[2]);
sqrt Eig_sqrt4(s1[3],s2[3]);
reg [2:0] cnt;

always @(posedge CLK_eig) 
begin
    if(En_eig) begin
        E_T11 <= E11; E_T12 <= E21; E_T13 <= E31; E_T14 <= E41;
        E_T21 <= E12; E_T22 <= E22; E_T23 <= E32; E_T24 <= E42;
        E_T31 <= E13; E_T32 <= E23; E_T33 <= E33; E_T34 <= E43;
        E_T41 <= E14; E_T42 <= E24; E_T43 <= E34; E_T44 <= E44;   
        
        //d3[0] = 1 / D11
        d1[0] <= 64'b0000000000000000000000000000000100000000000000000000000000000000;
        d2[0] <= D11; 
        
        //d3[1] = 1 / D22
        d1[1] <= 64'b0000000000000000000000000000000100000000000000000000000000000000;
        d2[1] <= D22;

        //d3[2] = 1 / D33
        d1[2] <= 64'b0000000000000000000000000000000100000000000000000000000000000000;
        d2[2] <= D33;
        
        //d3[3] = 1 / D44
        d1[3] <= 64'b0000000000000000000000000000000100000000000000000000000000000000;
        d2[3] <= D44;       
        
        s1[0] <= d3[0]; // s2[0] = (1 / D11)^(0.5)
        s1[1] <= d3[1]; // s2[1] = (1 / D22)^(0.5)
        s1[2] <= d3[2]; // s2[2] = (1 / D33)^(0.5)
        s1[3] <= d3[3]; // s2[3] = (1 / D44)^(0.5)
        
        if(cnt == 1) begin
            D_inv_sqrt11 <= 0;
            D_inv_sqrt22 <= 0; 
            D_inv_sqrt33 <= 0; 
            D_inv_sqrt44 <= 0; 
        end
        else begin
            D_inv_sqrt11 <= s2[0];
            D_inv_sqrt22 <= s2[1]; 
            D_inv_sqrt33 <= s2[2]; 
            D_inv_sqrt44 <= s2[3]; 
        end
        D_inv_sqrt12 <= 0; 
        D_inv_sqrt13 <= 0; 
        D_inv_sqrt14 <= 0;
             
        D_inv_sqrt21 <= 0;
        
        D_inv_sqrt23 <= 0;
        D_inv_sqrt24 <= 0;
             
        D_inv_sqrt31 <= 0;
        D_inv_sqrt32 <= 0;

        D_inv_sqrt34 <= 0;
              
        D_inv_sqrt41 <= 0;
        D_inv_sqrt42 <= 0;
        D_inv_sqrt43 <= 0;
        cnt<=cnt+1;
       
    end
    else begin
        E_T11 <= 0; E_T12 <= 0; E_T13 <= 0; E_T14 <= 0;
        E_T21 <= 0; E_T22 <= 0; E_T23 <= 0; E_T24 <= 0;
        E_T31 <= 0; E_T32 <= 0; E_T33 <= 0; E_T34 <= 0;
        E_T41 <= 0; E_T42 <= 0; E_T43 <= 0; E_T44 <= 0;   

        d1[0] <= 0;
        d2[0] <= 0; 
        d1[1] <= 0;
        d2[1] <= 0;
        d1[2] <= 0;
        d2[2] <= 0;
        d1[3] <= 0;
        d2[3] <= 0;
       
        s1[0] <= 0;
        s1[1] <= 0;
        s1[2] <= 0;
        s1[3] <= 0; 
        
        D_inv_sqrt11 <= 0;
        D_inv_sqrt12 <= 0; 
        D_inv_sqrt13 <= 0; 
        D_inv_sqrt14 <= 0;
            
        D_inv_sqrt21 <= 0;
        D_inv_sqrt22 <= 0;
        D_inv_sqrt23 <= 0;
        D_inv_sqrt24 <= 0;
           
        D_inv_sqrt31 <= 0;
        D_inv_sqrt32 <= 0;
        D_inv_sqrt33 <= 0;
        D_inv_sqrt34 <= 0;
           
        D_inv_sqrt41 <= 0;
        D_inv_sqrt42 <= 0;
        D_inv_sqrt43 <= 0;
        D_inv_sqrt44 <= 0;
        cnt<=0;
    end        
end
endmodule