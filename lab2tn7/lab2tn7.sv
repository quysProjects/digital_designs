module LS138(
input logic G2a,G2b,G1,a,b,c,d,
output logic[7:0] Y
);
logic[2:0] temp;
assign temp={G2a,G2b,G1};
logic[2:0] abc;
assign abc={a,b,c};

always_comb begin :LS138
if		(temp==3'b001)

case(abc)

	3'b000:	Y=8'b11111110;
	3'b001:	Y=8'b11111101;
	3'b010:	Y=8'b11111011;
	3'b011:	Y=8'b11110111;
	3'b100:	Y=8'b11101111;
	3'b101:	Y=8'b11011111;
	3'b110:	Y=8'b10111111;
	3'b111:	Y=8'b01111111;
	
endcase


else
			Y=8'b11111111;

end

endmodule


module lab2tn7(res,x,y,z,w,a,b,c,d,final_res);
input x,y,z,w;
output a,b,c,d,final_res; 
output logic[7:0] res;
assign a = x;
assign b = y;
assign c = z;
assign d = w;

LS138	 icLS138 (.G2a(1'b0),.G2b(1'b0),.G1(1'b1),.a(x),.b(y),.c(z),.d(w),.Y(res));
assign final_res = (((~(res[0]))&w)|((~(res[1]))&w)|((~(res[2]))&w)|((~(res[3]))&w)|((~(res[6]))&(~w))|((~(res[5]))&(~w))|(~(res[7]))&(~w));
endmodule
