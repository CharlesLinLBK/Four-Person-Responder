// 抢答器秒计时的时钟模块, 偶数分频器

`define C 0 // 偶数 n 分频, C = n/2 - 1; 

module frequency(
	input clk, rst_n,
	
	output reg clk_count
);

reg [3:0] cnt;

always @ ( posedge clk or negedge rst_n ) begin
		if ( !rst_n)begin
				cnt <= 0;
				clk_count <= 0;
			end
		else begin
				if ( cnt < `C )
					cnt <= cnt + 4'b0001;
				else begin
					cnt <= 0;
					clk_count <= ~clk_count;
				end
			end
	
end	

endmodule
