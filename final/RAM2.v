module RAM2(
    input wire clk ,
    input wire En  ,
    input wire R_w2  ,
    input wire [13:0] addr,
    input wire signed [25:0] data1,
    input wire signed [25:0] data2,
    input wire signed [25:0] data3,
    input wire signed [25:0] data4,
    output reg signed [25:0] q1, 
    output reg signed [25:0] q2,
    output reg signed [25:0] q3,
    output reg signed [25:0] q4
);

reg signed [25:0] RAM_Z1[0:127];
reg signed [25:0] RAM_Z2[0:127];
reg signed [25:0] RAM_Z3[0:127];
reg signed [25:0] RAM_Z4[0:127];
reg [7:0]cnt;
//R_w1이 1이면
always @ (posedge clk)
begin
    if (En)  begin
        if (R_w2) begin
            if(cnt==128) begin
                cnt<=0;
            end
            else begin
                /* create file of Z_DATA
                if(cnt == 127) begin
                    $writememh("INPUT1.txt",RAM_Z1);
                    $writememh("INPUT2.txt",RAM_Z2);
                    $writememh("INPUT3.txt",RAM_Z3);
                    $writememh("INPUT4.txt",RAM_Z4);
                end
                */
                RAM_Z1[cnt] <= data1;
                RAM_Z2[cnt] <= data2;
                RAM_Z3[cnt] <= data3;
                RAM_Z4[cnt] <= data4;
                q1 <= data1; 
                q2 <= data2;
                q3 <= data3;
                q4 <= data4;
                cnt<=cnt+1;
            end
        end 
        else begin
            if(cnt==128) begin
                cnt<=0;
            end
            q1 <= RAM_Z1[cnt]; 
            q2 <= RAM_Z2[cnt];
            q3 <= RAM_Z3[cnt];
            q4 <= RAM_Z4[cnt];
            cnt<=cnt+1;
        end
    end
    else begin
         cnt<=0;
    end
end


endmodule