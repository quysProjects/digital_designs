module lab2tn1_wrapper(
  	input [2:0] SW,
  	output [2:0] LEDR,
 	output [0:0] LEDG
);

  lab2tn1 ilab2tn1(SW[2],SW[1],SW[0],LEDG,LEDR[2],LEDR[1],LEDR[0]);

endmodule