// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : 1598491517@qq.com
// File   : sequence_detectorMN.v
// Create : 2022-05-06 18:13:50
// Revise : 2022-05-06 20:09:39
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module sequence_detectorMN(
		input clk,
		input rst_n,
		input data_in,
		input [5:0]N,
		input [4:0]M,
		output reg detec_pluse
	);
reg [6:0] count_in_A;
reg [11:0] count_in_all_A;
reg [2:0] state;
parameter S0_1 = 1,S0_0 = 2,S1_1 = 3,S1_0 = 4;

always @(posedge clk)begin
	if(!rst_n)begin
		state<=S0_1;
		count_in_A<= 'd0;
		count_in_all_A <= 'd0;
	end
	else begin
		case (state)
		S0_1: begin
			if((data_in==1'b1)&&(count_in_A<N-1))begin
				count_in_A <= count_in_A+1;
				state<=S0_1;
			end
			else if ((data_in==1'b0)&&(count_in_A<N-1)) begin
				count_in_A <= 'd0;
				state<=S0_1;
			end
			else if ((data_in==1'b1)&&(count_in_A==N-1))begin
				count_in_A <= 'd0;
				state<=S0_0;
			end
			else if ((data_in==1'b0)&&(count_in_A==N-1)) begin
				count_in_A <= 'd0;
				state<=S0_1;
			end
		end
		S0_0: begin
			if((data_in==1'b0)&&(count_in_A<N-1))begin
				count_in_A <= count_in_A+1;
				state<=S0_0;
			end
			else if ((data_in==1'b1)&&(count_in_A<N-1)) begin
				count_in_A <= 'd0;
				state<=S0_1;
			end
			else if ((data_in==1'b0)&&(count_in_A==N-1))begin
				count_in_A <= 'd0;
				count_in_all_A <= 'd1;
				state<=S1_1;
			end
			else if ((data_in==1'b1)&&(count_in_A==N-1))begin
				count_in_A <= 'd0;
				state<=S0_1;

			end
		end
		S1_1: begin
			if((data_in==1'b1)&&(count_in_A<N-1))begin
				count_in_A <= count_in_A+1;
				state<=S1_1;
			end
			else if ((data_in==1'b0)&&(count_in_A<N-1)) begin
				count_in_A <= 'd0;
				count_in_all_A <= 'd0;
				state<=S0_1;
			end
			else if ((data_in==1'b1)&&(count_in_A==N-1))begin
				count_in_A <= 'd0;
				state<=S1_0;
			end
			else if ((data_in==1'b0)&&(count_in_A==N-1)) begin
				count_in_A <= 'd0;
				count_in_all_A <= 'd0;
				state<=S0_1;
			end
		end
		S1_0: begin
			if((data_in==1'b0)&&(count_in_A<N-1))begin
				count_in_A <= count_in_A+1;
				state<=S1_0;
			end
			else if ((data_in==1'b1)&&(count_in_A<N-1)) begin
				count_in_A <= 'd0;
				count_in_all_A <= 'd0;
				state<=S0_1;
			end
			else if ((data_in==1'b0)&&(count_in_A==N-1))begin
				count_in_A <= 'd0;
				count_in_all_A <= count_in_all_A+'d1;
				state<=S1_1;
			end
			else if ((data_in==1'b1)&&(count_in_A==N-1))begin
				count_in_A <= 'd0;
				count_in_all_A <= 'd0;
				state<=S0_1;
			end
		end
		endcase
	end
end

always@(posedge clk)begin
	if (!rst_n)begin
		detec_pluse<=1'b0;
	end
	else if((count_in_all_A==M-1)&&(state==S1_0)&&(data_in==1'b0)&&(count_in_A==N-1))begin
		detec_pluse<=1'b1;
		count_in_all_A<=1'b0;
	end
	else begin
		detec_pluse<=1'b0;
	end
end

endmodule