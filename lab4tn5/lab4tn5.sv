module lab4tn5(
		input logic x,clk,rst,
		output logic z
);
integer i=0;
logic out;
always_ff@(posedge clk) begin: pro
i <= i + 1;
if (i==2) begin
		out <= ~out;
		i <= 0;
		end
end
parameter s0=3'b000,s1=3'b001,s2=3'b010,
			 s3=3'b011,s4=3'b100,s5=3'b101,s6=3'b110;
logic [2:0] pre;
logic [2:0] next;
always@(posedge out) begin
	if (rst) begin
			pre <=s0;
			end
	else pre <=next;
	end
always@(pre or x) begin
case(pre)
	s0: if(x) next =s1;
		 else next = s6;
	s1: if(x) next =s3;
		 else next = s2;
	s2: if(x) next =s4;
		 else next = s1;	 
	s3: if(x) next =s5;
		 else next = s4;
	s4: if(x) next =s6;
		 else next = s3;
	s5: if(x) next =s1;
		 else next = s6;
	s6: if(x) next =s5;
		 else next = s2;
	default: next= s0;
endcase
end 
always@(*) begin
		if (pre==s5) z='1;
		else z='0;
end 
endmodule

module w5(
		input logic [1:0] SW,
		input logic CLOCK_50,
		output logic [1:0]LEDR
);
lab4tn5 lab(
		.x(SW[1]),
		.Z(LEDR[1]),
		.clk(CLOCK_50)
);
endmodule