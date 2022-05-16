// 抢答器的倒计时计数器模块
module counter(
	input clk_count, rst_n,zd,zd_r,
	output reg[7:0] q,
	output reg count
);

//clk_count时钟信号；rst_n复位信号；zd来自main模块的中断信号；zd_r来自record的中断信号；
//q输出倒计时时间；count倒计时重置控制(1重置倒计时，0继续或开始倒计时)。

always@(posedge clk_count or negedge rst_n)
	if(~rst_n) begin q='h0f; count='h0; end
//rst_n为低电平该电路复位，q置0fh，count置0
else
	if (!zd & !zd_r) begin
			if(q == 0) q='h0f;//15秒倒计时结束，q置30h
			else q=q - 'h01;
			if(q == 'h0) count=1;//15秒倒计时结束，count置1
			else count=0;
		end
	else begin count = 1;q = 'h0f; end//中断信号生效，重置倒计时

endmodule
