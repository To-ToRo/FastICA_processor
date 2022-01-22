module moduleName (
    input clk_norm,
    input en_norm,

    input signed [25:0] w_in11, w_in12, w_in13, w_in14,
    input signed [25:0] w_in21, w_in22, w_in23, w_in24,
    input signed [25:0] w_in31, w_in32, w_in33, w_in34,
    input signed [25:0] w_in41, w_in42, w_in43, w_in44,

    output reg signed [25:0] w_out11, w_out12, w_out13, w_out14,
    output reg signed [25:0] w_out21, w_out22, w_out23, w_out24,
    output reg signed [25:0] w_out31, w_out32, w_out33, w_out34,
    output reg signed [25:0] w_out41, w_out42, w_out43, w_out44
);


    
endmodule