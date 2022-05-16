module responder(
	input clk_count,rst_n,
	input p0,p1,p2,p3,
	input answer,
	
	output wire[7:0] q,
	output wire s0,s1,s2,s3,
	output wire[3:0] figure0,figure1,figure2,figure3	
);

	wire count;
	wire zd;
	wire zd_r;
	wire en_s0;
	wire en_s1;
	wire en_s2;
	wire en_s3;

always @ (clk_count) begin
	counter counter(.out(count),.out(q),.in(clk_count).in(rst_n),.)
	
endmodule
