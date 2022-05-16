module main(
	input clk_count,rst_n,count,
	input p0,p1,p2,p3,zd_r,
	
	output reg zd,
	output reg s0,s1,s2,s3,
	output reg en_s0,en_s1,en_s2,en_s3	
);
//clk_count时钟信号；rst_n重置信号；count答题有效信号；p0~3四组抢答按键输入信号；zd_r来自record的中断信号（1有效，0无效）；
//zd来自main的中断信号；s0~3抢答成功信号；en_s0~3抢答有效保持信号。
always @ (posedge clk_count) begin
	if (!rst_n) begin s0=0;s1=0;s2=0;s3=0;zd=0; end
	else begin
		//抢答有效闪灯
		if ((p0==1)&(count == 0)) begin zd=1; s0=1; end
		else if ((p1==1)&(count == 0)) begin zd=1; s1=1; end
		else if ((p2==1)&(count == 0)) begin zd=1; s2=1; end
		else if ((p3==1)&(count == 0)) begin zd=1; s3=1; end
		else begin s0=0;s1=0;s2=0;s3=0;zd=0; end
		//抢答有效保持
		if ((s0 == 1)&(s1 == 0)&(s2 == 0)&(s2 == 0)) begin en_s0<=1; end
		else if ((s0 == 0)&(s1 == 1)&(s2 == 0)&(s3 == 0)) begin en_s1<=1; end
		else if ((s0 == 0)&(s1 == 0)&(s2 == 1)&(s3 == 0)) begin en_s2<=1; end
		else if ((s0 == 0)&(s1 == 0)&(s2 == 0)&(s3 == 1)) begin en_s3<=1; end
		else begin zd=0; end
		//重置抢答有效保持信号
		if ((en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)&(zd_r == 1)) begin en_s0<=0; end
		else if ((en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)&(zd_r == 1)) begin en_s1<=0; end
		else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)&(zd_r == 1)) begin en_s2<=0; end
		else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)&(zd_r == 1)) begin en_s3<=0; end
	end

end
	
endmodule
/*
always @ (posedge s0 or posedge s1 or posedge s2 or posedge s3) begin
	if (!rst_n) begin s0=0;s1=0;s2=0;s3=0;zd=0; end
	else begin
		if (s0==1) begin 
			if (answer == 1) begin zd=1; end
			else begin zd=1; end
		
	end
end
*/