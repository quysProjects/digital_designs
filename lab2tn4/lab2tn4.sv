module LS151 (
input logic a,b,c,
input logic Sn,
output logic Y
);
logic[2:0]	ABC;
assign ABC={a,b,c};
logic[7:0] D;
assign D=8'b10010110;
always_comb begin : lab2tn3
if	(Sn=='b1) 
Y=1;
else 
case(ABC)
	3'b000 :Y=D[0];
	3'b001 :Y=D[1];
	3'b010 :Y=D[2];
	3'b011 :Y=D[3];
	3'b100 :Y=D[4];
	3'b101 :Y=D[5];
	3'b110 :Y=D[6];
	3'b111 :Y=D[7];
endcase
end
endmodule
module lab2tn4(a_in,b_in,c_in,x,y,z,Sn,final_res,Y_out);
input y,x,z,Sn;
output a_in,b_in,c_in,final_res,Y_out;
assign a_in=x;
assign b_in=y;
assign c_in=z;
LS151 icLS151(.Sn(1'b0),.a(x),.b(y),.c(z),.Y(Y_out));
assign final_res=Y_out;
endmodule
