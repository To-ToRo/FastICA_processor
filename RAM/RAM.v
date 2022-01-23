module RAM(
    input wire clk,
    input wire GO,
    input wire RW,
    input wire [13:0] addr,
    input wire signed [25:0] Z1_in,
    input wire signed [25:0] Z2_in,
    input wire signed [25:0] Z3_in,
    input wire signed [25:0] Z4_in,
/*
    input wire signed [15:0] C11_in,
	input wire signed [15:0] C12_in,
	input wire signed [15:0] C13_in,
	input wire signed [15:0] C14_in,
	input wire signed [15:0] C21_in,
	input wire signed [15:0] C22_in,
	input wire signed [15:0] C23_in,
	input wire signed [15:0] C24_in,
	input wire signed [15:0] C31_in,
	input wire signed [15:0] C32_in,
	input wire signed [15:0] C33_in,
	input wire signed [15:0] C34_in,
	input wire signed [15:0] C41_in,
	input wire signed [15:0] C42_in,
	input wire signed [15:0] C43_in,
	input wire signed [15:0] C44_in,

    output wire signed [15:0] C11_out,
	output wire signed [15:0] C12_out,
	output wire signed [15:0] C13_out,
	output wire signed [15:0] C14_out,
	output wire signed [15:0] C21_out,
	output wire signed [15:0] C22_out,
	output wire signed [15:0] C23_out,
	output wire signed [15:0] C24_out,
	output wire signed [15:0] C31_out,
	output wire signed [15:0] C32_out,
	output wire signed [15:0] C33_out,
	output wire signed [15:0] C34_out,
	output wire signed [15:0] C41_out,
	output wire signed [15:0] C42_out,
	output wire signed [15:0] C43_out,
	output wire signed [15:0] C44_out,

    input wire signed [25:0] V11_in, V12_in, V13_in, V14_in; 
    input wire signed [25:0] V21_in, V22_in, V23_in, V24_in; 
    input wire signed [25:0] V31_in, V32_in, V33_in, V34_in; 
    input wire signed [25:0] V41_in, V42_in, V43_in, V44_in; 

    output wire signed [25:0] V11_out,V12_out,V13_out,V14_out;
    output wire signed [25:0] V21_out,V22_out,V23_out,V24_out;
    output wire signed [25:0] V31_out,V32_out,V33_out,V34_out;
    output wire signed [25:0] V41_out,V42_out,V43_out,V44_out;
*/

    output reg signed [25:0] Z1_out, 
    output reg signed [25:0] Z2_out,
    output reg signed [25:0] Z3_out,
    output reg signed [25:0] Z4_out
);

reg signed [25:0] RAM_Z1[0:127];
reg signed [25:0] RAM_Z2[0:127];
reg signed [25:0] RAM_Z3[0:127];
reg signed [25:0] RAM_Z4[0:127];
reg [7:0] cnt;

always @ (posedge clk)
begin
    if (GO)  begin
        if (RW) begin
            if(cnt==128) begin
                cnt<=0;
            end
            else begin
                RAM_Z1[cnt] <= Z1_in;
                RAM_Z2[cnt] <= Z2_in;
                RAM_Z3[cnt] <= Z3_in;
                RAM_Z4[cnt] <= Z4_in;
                Z1_out <= Z1_in; 
                Z2_out <= Z2_in;
                Z3_out <= Z3_in;
                Z4_out <= Z4_in;
                cnt<=cnt+1;
            end
        end 
        else begin
            if(cnt==128) begin
                cnt<=0;
            end
            Z1_out <= RAM_Z1[cnt]; 
            Z2_out <= RAM_Z2[cnt];
            Z3_out <= RAM_Z3[cnt];
            Z4_out <= RAM_Z4[cnt];
            cnt<=cnt+1;
        end
    end
    else begin
         cnt<=0;
    end
end


endmodule