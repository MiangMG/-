// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : 1598491517@qq.com
// File   : tb_sequence_data.v
// Create : 2022-05-06 19:44:08
// Revise : 2022-05-06 19:58:05
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

module tb_sequence_data();

reg clk,rst_n,data_in;
reg [5:0]N;
reg [4:0]M;
wire detec_pluse;

initial begin
	clk = 1'b1;
	rst_n =1'b0;
	data_in = 1'b0;
	N = 6'b000011;  //3组111，3组000
	M = 5'b00100;  //4个连续序列
	#200  rst_n = 1'b1;
	#17  data_in =0;
	#30  data_in =1;
	#50  data_in = 0;
	#30 data_in = 1;//start
	#30 data_in = 0;
	#30 data_in = 1;
	#30 data_in = 0;//M=1
	#30 data_in = 1;//start
	#30 data_in = 0;
	#30 data_in = 1;
	#30 data_in = 0;//M=2
	#30 data_in = 1;//start
	#30 data_in = 0;
	#30 data_in = 1;
	#30 data_in = 0;//M=3
	#30 data_in = 1;//start
	#30 data_in = 0;
	#30 data_in = 1;
	#30 data_in = 0;//M=4
	#30 data_in = 1;//start
	#30 data_in = 0;
	#30 data_in = 1;
	#30 data_in = 0;//M=1
	#30 data_in = 1;//start
	#30 data_in = 0;
	#20 data_in = 1;
	#30 data_in = 0;//M=0
end
always #5 clk=~clk;

	sequence_detectorMN inst_sequence_detectorMN (
			.clk         (clk),
			.rst_n       (rst_n),
			.data_in     (data_in),
			.M           (M),
			.N           (N),
			.detec_pluse (detec_pluse)
		);



endmodule