module SQRT1(x,y);

input [25:0] x;
output wire [25:0] y;

wire [127:0] x1;
reg [127:0] y1;
reg [127:0] a;
reg [63:0] q;
reg [65:0] left,right,r;
integer i;

assign x1 = x <<< 83;
assign y = y1[60:35];

//assign y1 = x1 ** 0.5;
always @(*)
begin
    //initialize all the variables.
    a = x1;
    q = 0;
    i = 0;
    left = 0;   //input to adder/sub
    right = 0;  //input to adder/sub
    r = 0;      //remainder
    //run the calculations for 64 iterations
    for(i=0;i<64;i=i+1) begin 
        right = {q,r[65],1'b1};
        left = {r[63:0],a[127:126]};
        a = {a[125:0],2'b0};    //left shift by 2 bits
        if (r[65] == 1) //add if r is negative
            r = left + right;
        else    //subtract if r is positive
            r = left - right;
        q = {q[62:0],!r[65]};
    end
    y1 = q;   //final assignment of output
end 

endmodule