module record(
	input clk_count,rst_n,true,false,
	input en_s0,en_s1,en_s2,en_s3,
	
	output reg zd_r,
	output reg [1:0] EDA_ps0,EDA_ps1,EDA_ps2,EDA_ps3,
	output reg [3:0] EDA_fs0,EDA_fs1,EDA_fs2,EDA_fs3
);
//true答题正确输入信号；false答题错误输入信号；en_s0~3答题有效保持信号；
//zd_r来自record的中断信号；EDA_f0~3各个队伍分数输出信号。
reg [3:0] EDA_f0,EDA_f1,EDA_f2,EDA_f3;
always @ (posedge clk_count) begin
	if (!rst_n) begin
		EDA_f0=4'b0000;EDA_f1=4'b0000;EDA_f2=4'b0000;EDA_f3=4'b0000;zd_r<=0;
		EDA_ps0=2'b00;EDA_ps1=2'b01;EDA_ps2=2'b10;EDA_ps3=2'b11;
		end
	else begin
		//分数计算累计函数
		if ((en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)&(true == 1)&(false == 0)) begin EDA_f0=EDA_f0+6'b000001;zd_r<=1; end			//p0答对
		else if ((en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)&(true == 1)&(false == 0)) begin EDA_f1=EDA_f1+6'b000001;zd_r<=1; end	//p1答对
		else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)&(true == 1)&(false == 0)) begin EDA_f2=EDA_f2+6'b000001;zd_r<=1; end	//p2答对
		else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)&(true == 1)&(false == 0)) begin EDA_f3=EDA_f3+6'b000001;zd_r<=1; end	//p3答对
		else if ((en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)&(true == 0)&(false == 1)) begin EDA_f0=EDA_f0+6'b000000;zd_r<=1; end	//p0答错
		else if ((en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)&(true == 0)&(false == 1)) begin EDA_f1=EDA_f1+6'b000000;zd_r<=1; end	//p1答错
		else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)&(true == 0)&(false == 1)) begin EDA_f2=EDA_f2+6'b000000;zd_r<=1; end	//p2答错
		else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)&(true == 0)&(false == 1)) begin EDA_f3=EDA_f3+6'b000000;zd_r<=1; end	//p3答错
		else begin EDA_f0=EDA_f0+6'b000000;EDA_f1=EDA_f1+6'b000000;EDA_f2=EDA_f2+6'b000000;EDA_f3=EDA_f3+6'b000000;zd_r<=0; end					//其他情况
		EDA_fs0=EDA_f0; EDA_fs1=EDA_f1; EDA_fs2=EDA_f2; EDA_fs3=EDA_f3;
		//{EDA_ps0,EDA_fs0}=EDA_f0; {EDA_ps1,EDA_fs1}=EDA_f1; {EDA_ps2,EDA_fs2}=EDA_f2; {EDA_ps3,EDA_fs3}=EDA_f3;
	end
end
endmodule

//input s0,s1,s2,s3,
//output reg [1:0] tof
//en_s0<=1'b0;en_s1<=1'b0;en_s2<=1'b0;en_s3<=1'b0;
//begin EDA_f0=EDA_f0+6'b000000;EDA_f1=EDA_f1+6'b000000;EDA_f2=EDA_f2+6'b000000;EDA_f3=EDA_f3+6'b000000;zd_r<=0; end
//else begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0; end
/*		
		tof<={true,false};
		case(tof)
		2'b10: begin 
			if ((en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f0=EDA_f0+6'b000001;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f1=EDA_f1+6'b000001;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)) begin EDA_f2=EDA_f2+6'b000001;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)) begin EDA_f3=EDA_f3+6'b000001;zd_r<=1; end
			else begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
			end
		2'b01: begin
			if ((en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f0=EDA_f0+6'b000000;zd_r<=0; end
			else if ((en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f1=EDA_f1+6'b000000;zd_r<=0; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)) begin EDA_f2=EDA_f2+6'b000000;zd_r<=0; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)) begin EDA_f3=EDA_f3+6'b000000;zd_r<=0; end
			else begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
			end
		2'b00: begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
		default: begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
		endcase
		
		if ((true == 1)&(false == 0)) begin 
			if ((en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f0=EDA_f0+6'b000001;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f1=EDA_f1+6'b000001;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)) begin EDA_f2=EDA_f2+6'b000001;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)) begin EDA_f3=EDA_f3+6'b000001;zd_r<=1; end
			else begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
			end
		else if ((true == 0)&(false == 1)) begin
			if ((en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f0=EDA_f0+6'b000000;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f1=EDA_f1+6'b000000;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)) begin EDA_f2=EDA_f2+6'b000000;zd_r<=1; end
			else if ((en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)) begin EDA_f3=EDA_f3+6'b000000;zd_r<=1; end
			else begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
			end
		else if ((!true)&(!false)) begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
		else begin tof<=2'b00; end
		end
		if ((true == 1)&(false == 0)&(en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f0=EDA_f0+6'b000001;zd_r<=1; end
		else if ((true == 1)&(false == 0)&(en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f1=EDA_f1+6'b000001;zd_r<=1; end
		else if ((true == 1)&(false == 0)&(en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)) begin EDA_f2=EDA_f2+6'b000001;zd_r<=1; end
		else if ((true == 1)&(false == 0)&(en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)) begin EDA_f3=EDA_f3+6'b000001;zd_r<=1; end
		else if ((!true)&(!false)) begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
		else begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
		if ((true == 0)&(false == 1)&(en_s0 == 1)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f0=EDA_f0+6'b000000;zd_r<=1; end
		else if ((true == 0)&(false == 1)&(en_s0 == 0)&(en_s1 == 1)&(en_s2 == 0)&(en_s3 == 0)) begin EDA_f1=EDA_f1+6'b000000;zd_r<=1; end
		else if ((true == 0)&(false == 1)&(en_s0 == 0)&(en_s1 == 0)&(en_s2 == 1)&(en_s3 == 0)) begin EDA_f2=EDA_f2+6'b000000;zd_r<=1; end
		else if ((true == 0)&(false == 1)&(en_s0 == 0)&(en_s1 == 0)&(en_s2 == 0)&(en_s3 == 1)) begin EDA_f3=EDA_f3+6'b000000;zd_r<=1; end
		else if ((!true)&(!false)) begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
		else begin EDA_f0=EDA_f0+0;EDA_f1=EDA_f1+0;EDA_f2=EDA_f2+0;EDA_f3=EDA_f3+0;zd_r<=0; end
		end
		*/