
module Kernel 
( 	clk, op_st, rst, in_a, 
	c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, 
	dout, start_out, done
);

input clk, op_st, rst;
input signed [15:0] in_a;
input  signed [7:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;

output reg signed [19:0] dout;
output reg start_out;
output reg done;

reg signed [15:0] a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15;
reg signed [13:0] m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15;
reg signed [15:0] p0, p1, p2, p3;

reg en;	//enable 
reg [5:0] count; // have 17 times output
(* keep = "true" *) reg signed [19:0] temp_dout;

always @ ( posedge clk or posedge rst ) begin
	if ( rst ) begin
        dout <= 20'd0 ;
		en <= 1'b0;
		start_out <= 1'b0;
		done <= 1'b0;
    end	

	else if ( op_st == 1'b1 && en == 1'b0 ) begin 
		en <= 1'b1;
	end
	
	else if ( en == 1'b1 ) begin 	
		if ( count >= 6'd20  && count <= 6'd37 )begin 
			if ( count == 6'd37 ) begin // done 
				en <= 1'b0;
				done <= 1'b1;
				start_out <= 1'b0;
			end 
			
			else begin 
				start_out <= 1'b1;
				dout <= temp_dout;
			end
		end
	end 
end

always @ ( posedge clk or posedge rst ) begin 
	if ( rst ) begin 
		count <= 6'd0;
		temp_dout <= 20'd0;
	end 
	
	else if ( en == 1'b1 ) begin 
		count <= count + 1'b1;
		
		a15 <= a14;
		a14 <= a13;
		a13 <= a12;
		a12 <= a11;
	
		a11 <= a10;
		a10 <= a9;
		a9 <= a8;
		a8 <= a7;
		
		a7 <= a6;
		a6 <= a5;
		a5 <= a4;
		a4 <= a3;
		
		a3 <= a2;
		a2 <= a1;
		a1 <= a0;
		a0 <= in_a;
		// *******************
		m0 <= a0*c15; 
		m1 <= a1*c14;
		m2 <= a2*c13;
		m3 <= a3*c12;
		
		m4 <= a4*c11;
		m5 <= a5*c10;
		m6 <= a6*c9;
		m7 <= a7*c8;
		
		m8 <= a8*c7;
		m9 <= a9*c6;
		m10 <= a10*c5;
		m11 <= a11*c4;
		
		m12 <= a12*c3;
		m13 <= a13*c2;
		m14 <= a14*c1;
		m15 <= a15*c0;
		
		p0 <= m0 + m1 + m2 + m3;
		p1 <= m4 + m5 + m6 + m7;
		p2 <= m8 + m9 + m10 + m11;
		p3 <= m12 + m13 + m14 + m15;
		
		temp_dout <= p0 + p1 + p2 + p3;	
	end
end

endmodule