module lab4tn4(
		input logic clk,
		output logic out
);
integer i=0;
always_ff@(posedge clk)
begin
		i<=i+1;
		if (i==25000000) begin
					out <=~out;
					i<= 0;
		end
end
endmodule
