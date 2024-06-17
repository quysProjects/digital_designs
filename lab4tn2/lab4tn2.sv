module lab4tn2 (
input logic [3:0] A_i,
input logic [3:0] B_i,
input logic [0:0] sel_i,
output logic [3:0] S_o,
output logic [0:0] C_o
);
logic [4:0] A_temp;
logic [4:0] B_temp;
logic [4:0] S_temp;
assign A_temp = {1'b0, A_i};
assign B_temp = {1'b0, B_i};
always_comb begin : proc_add

	case (sel_i)
 1'b0 : S_temp = (A_temp + B_temp);
 1'b1 : S_temp = (A_temp - B_temp);
	endcase
 end
always_comb begin : proc_assign
S_o = S_temp[3:0];
C_o = S_temp[4];
end
endmodule : lab4tn2