`timescale 100ps/1ps

module TB_FASTICA;
    reg clk_fast;
    reg go_fast;

    reg signed [25:0] z1, z2, z3, z4;

    wire signed [25:0] w11_in, w12_in, w13_in, w14_in;
    wire signed [25:0] w21_in, w22_in, w23_in, w24_in;
    wire signed [25:0] w31_in, w32_in, w33_in, w34_in;
    wire signed [25:0] w41_in, w42_in, w43_in, w44_in;

    wire fast_busy;
    wire signed [25:0] w11_out, w12_out, w13_out, w14_out;
    wire signed [25:0] w21_out, w22_out, w23_out, w24_out;
    wire signed [25:0] w31_out, w32_out, w33_out, w34_out;
    wire signed [25:0] w41_out, w42_out, w43_out, w44_out;

   FASTICA ONE_UNIT_FASTICA (
        .clk_fast(clk_fast),
        .go_fast(go_fast),

        .z1(z1), .z2(z2), .z3(z3), .z4(z4),

        .w11_in(w11_in), .w12_in(w12_in), .w13_in(w13_in), .w14_in(w14_in),
        .w21_in(w21_in), .w22_in(w22_in), .w23_in(w23_in), .w24_in(w24_in),
        .w31_in(w31_in), .w32_in(w32_in), .w33_in(w33_in), .w34_in(w34_in),
        .w41_in(w41_in), .w42_in(w42_in), .w43_in(w43_in), .w44_in(w44_in),

        .fast_busy(fast_busy),

        .w11_out(w11_out), .w12_out(w12_out), .w13_out(w13_out), .w14_out(w14_out),
        .w21_out(w21_out), .w22_out(w22_out), .w23_out(w23_out), .w24_out(w24_out),
        .w31_out(w31_out), .w32_out(w32_out), .w33_out(w33_out), .w34_out(w34_out),
        .w41_out(w41_out), .w42_out(w42_out), .w43_out(w43_out), .w44_out(w44_out)
   );

   initial begin
       clk_fast = 1'b0;
       go_fast = 1'b0;
       z1 = 26'd8200;
       z2 = 26'd8200;
       z3 = 26'd8200;
       z4 = 26'd8200;

       #10 go_fast = 1'b1;
   end

   assign #10 clk_fast = ~clk_fast;

   always @(posedge clk_fast) begin
       z1 <= z1 + 26'd8200;
       z2 <= z2 + 26'd8200;
       z3 <= z3 + 26'd8200;
       z4 <= z4 + 26'd8200;
   end

endmodule