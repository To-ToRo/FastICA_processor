module COVAR_Controller(
	input wire GO,
	input wire CLK,
	
	output reg COV_busy,
	output reg CLK_Multi,
	output reg CLK_add_div,
	output reg En_Multi,
	output reg En_add_div
);

assign CLK_Multi = CLK;
assign CLK_add_div =CLK;

parameter S0 =0 ,  S1=1, S2=2, S3=3, S4=4;
reg [3:0] state;
reg [7:0] cnt;

always @ (posedge CLK or negedge GO) begin
	if(!GO) begin
		cnt<=0;
		state <= S0;
		En_Multi    <= 0;
		En_add_div  <= 0;
		COV_busy <= 1;
	end
	else begin
		case(state)
			S0:
				begin
					state <= S1;
					En_Multi    <= 1;
					En_add_div  <= 0;
				end
			S1:
				begin
					if(cnt == 127) begin
						cnt<=0;
						En_Multi  <= 0;
						En_add_div <= 1	;
						state <=S2;
					end	
					else begin
						En_Multi <= 1;
						En_add_div <= 1;
						cnt <= cnt+1;
					end
				end
			S2:
				begin
					state <=S3;
					En_Multi    <= 0;
					En_add_div  <= 1;
				end
			S3:
				begin
					state<=S4;
					En_Multi    <= 0;
					En_add_div  <= 1;
				end		
			S4:
				begin
					En_Multi    <= 0;
					En_add_div  <= 0;
					COV_busy <= 0;

				end

		endcase
	end
end
endmodule
