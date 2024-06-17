module lab4tn1(
input A,
input B,
input Ci,
output S,
output Co);
assign S = A ^ B ^ Ci;
assign Co=(A&B)|(A&Ci)|(B&Ci);
endmodule