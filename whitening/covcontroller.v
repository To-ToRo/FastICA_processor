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

parameter S0 =0 ,  S1=1;
reg [1:0] state;
reg [6:0] cnt;

always @ (posedge CLK or negedge GO) begin
	if(!GO) begin
		cnt<=0;
		state <= S0;
		COV_busy	 <= 1;
		En_Multi      <= 0;
		En_add_div  <= 0;
	end
	else begin
		case(state)
			S0:
				begin
					if(cnt == 127) begin
						cnt<=0;
						state <=S1;
					end
					else begin
						En_Multi   <= 1;
						En_add_div <= 1;
						cnt <= cnt+1;
					end
				end
			S1:
				begin
					En_Multi   <= 0;
					En_add_div <= 0;
					COV_busy<=0;
				end
		endcase
	end
end
endmodule
