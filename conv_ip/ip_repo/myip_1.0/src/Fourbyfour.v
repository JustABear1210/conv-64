module Fourbyfour( 
	clk, 
	op_st,
	rst,	
	a0, a1, a2, a3,
	dout,
	st_out, done
);

input clk, op_st, rst;
input signed [15:0] a0, a1, a2, a3;
output wire signed [63:0] dout;
output wire done;
output reg st_out;
		
(* keep = "true" *) wire signed [19:0] kernel0_out [3:0];
wire kernel_st_out, kernel_done;
assign done = kernel_done;
always @(posedge clk ) begin 
	st_out <= kernel_st_out;
end
Kernel kernel_00( clk, op_st, rst, a0, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10, 8'd11, 8'd12, 8'd13, 8'd14, 8'd15, 8'd16, kernel0_out[0], kernel_st_out, kernel_done);
Kernel kernel_01( clk, op_st, rst, a1, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10, 8'd11, 8'd12, 8'd13, 8'd14, 8'd15, 8'd16, kernel0_out[1]);
Kernel kernel_02( clk, op_st, rst, a2, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10, 8'd11, 8'd12, 8'd13, 8'd14, 8'd15, 8'd16, kernel0_out[2]);
Kernel kernel_03( clk, op_st, rst, a3, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10, 8'd11, 8'd12, 8'd13, 8'd14, 8'd15, 8'd16, kernel0_out[3]);
//***************************************************************************************
	
(* keep = "true" *) wire signed [19:0] kernel1_out [3:0];
Kernel kernel_10( clk, op_st, rst, a0, 8'd17, 8'd18, 8'd19, 8'd20, 8'd21, 8'd22, 8'd23, 8'd24, 8'd25, 8'd26, 8'd27, 8'd28, 8'd29, 8'd30, 8'd31, 8'd32, kernel1_out[0]);
Kernel kernel_11( clk, op_st, rst, a1, 8'd17, 8'd18, 8'd19, 8'd20, 8'd21, 8'd22, 8'd23, 8'd24, 8'd25, 8'd26, 8'd27, 8'd28, 8'd29, 8'd30, 8'd31, 8'd32, kernel1_out[1]);
Kernel kernel_12( clk, op_st, rst, a2, 8'd17, 8'd18, 8'd19, 8'd20, 8'd21, 8'd22, 8'd23, 8'd24, 8'd25, 8'd26, 8'd27, 8'd28, 8'd29, 8'd30, 8'd31, 8'd32, kernel1_out[2]);
Kernel kernel_13( clk, op_st, rst, a3, 8'd17, 8'd18, 8'd19, 8'd20, 8'd21, 8'd22, 8'd23, 8'd24, 8'd25, 8'd26, 8'd27, 8'd28, 8'd29, 8'd30, 8'd31, 8'd32, kernel1_out[3]);
//***************************************************************************************

(* keep = "true" *) wire signed [19:0] kernel2_out [3:0];
Kernel kernel_20( clk, op_st, rst, a0, 8'd33, 8'd34, 8'd35, 8'd36, 8'd37, 8'd38, 8'd39, 8'd40, 8'd41, 8'd42, 8'd43, 8'd44, 8'd45, 8'd46, 8'd47, 8'd48, kernel2_out[0]);
Kernel kernel_21( clk, op_st, rst, a1, 8'd33, 8'd34, 8'd35, 8'd36, 8'd37, 8'd38, 8'd39, 8'd40, 8'd41, 8'd42, 8'd43, 8'd44, 8'd45, 8'd46, 8'd47, 8'd48, kernel2_out[1]);
Kernel kernel_22( clk, op_st, rst, a2, 8'd33, 8'd34, 8'd35, 8'd36, 8'd37, 8'd38, 8'd39, 8'd40, 8'd41, 8'd42, 8'd43, 8'd44, 8'd45, 8'd46, 8'd47, 8'd48, kernel2_out[2]);
Kernel kernel_23( clk, op_st, rst, a3, 8'd33, 8'd34, 8'd35, 8'd36, 8'd37, 8'd38, 8'd39, 8'd40, 8'd41, 8'd42, 8'd43, 8'd44, 8'd45, 8'd46, 8'd47, 8'd48, kernel2_out[3]);
//***************************************************************************************

(* keep = "true" *) wire signed [19:0] kernel3_out [3:0];
Kernel kernel_30( clk, op_st, rst, a0, 8'd49, 8'd50, 8'd51, 8'd52, 8'd53, 8'd54, 8'd55, 8'd56, 8'd57, 8'd58, 8'd59, 8'd60, 8'd61, 8'd62, 8'd63, 8'd64, kernel3_out[0]);
Kernel kernel_31( clk, op_st, rst, a1, 8'd49, 8'd50, 8'd51, 8'd52, 8'd53, 8'd54, 8'd55, 8'd56, 8'd57, 8'd58, 8'd59, 8'd60, 8'd61, 8'd62, 8'd63, 8'd64, kernel3_out[1]);
Kernel kernel_32( clk, op_st, rst, a2, 8'd49, 8'd50, 8'd51, 8'd52, 8'd53, 8'd54, 8'd55, 8'd56, 8'd57, 8'd58, 8'd59, 8'd60, 8'd61, 8'd62, 8'd63, 8'd64, kernel3_out[2]);
Kernel kernel_33( clk, op_st, rst, a3, 8'd49, 8'd50, 8'd51, 8'd52, 8'd53, 8'd54, 8'd55, 8'd56, 8'd57, 8'd58, 8'd59, 8'd60, 8'd61, 8'd62, 8'd63, 8'd64, kernel3_out[3]);
//***************************************************************************************

reg en;
(* keep = "true" *) reg signed [19:0] tempdout0, tempdout1, tempdout2, tempdout3;
always @ ( posedge clk or posedge rst) begin
	if ( rst ) begin
		tempdout0 <= 20'd0;
		tempdout1 <= 20'd0;
		tempdout2 <= 20'd0;
		tempdout3 <= 20'd0;
		en = 1'b0;
    end	
	
	else if ( op_st == 1'b1 && en == 1'b0 ) begin 
		en <= 1'b1;
	end
	
	else if ( en == 1'b1 ) begin 
		tempdout0 <= ( kernel_st_out == 1'b1 && done == 1'b0 ) ? kernel0_out[0] + kernel0_out[1] + kernel0_out[2] + kernel0_out[3] : 20'd0;
		tempdout1 <= ( kernel_st_out == 1'b1 && done == 1'b0 ) ? kernel1_out[0] + kernel1_out[1] + kernel1_out[2] + kernel1_out[3] : 20'd0;
		tempdout2 <= ( kernel_st_out == 1'b1 && done == 1'b0 ) ? kernel2_out[0] + kernel2_out[1] + kernel2_out[2] + kernel2_out[3] : 20'd0;
		tempdout3 <= ( kernel_st_out == 1'b1 && done == 1'b0 ) ? kernel3_out[0] + kernel3_out[1] + kernel3_out[2] + kernel3_out[3] : 20'd0;
				
	end
	
end

assign dout = {tempdout0[19:4],tempdout1[19:4],tempdout2[19:4],tempdout3[19:4]};


endmodule