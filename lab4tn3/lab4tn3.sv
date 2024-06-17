module lab4tn3(
  input logic clk,
  input logic rst,
  input logic [3:0] bcd_input,
  output logic [6:0] led7_doan_output
);

  logic [6:0] decoded_output;

  lab4tn3_wrapper decoder(
    .bcd_input(bcd_input),
    .led7_doan_output(decoded_output)
  );

  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      led7_doan_output <= 7'b1111111;
    else
      led7_doan_output <= decoded_output;
  end
endmodule
module lab4tn3_wrapper(
  input logic [3:0] bcd_input,
  output logic [6:0] led7_doan_output
);

  always_comb begin
    case (bcd_input)
      4'b0000: led7_doan_output = 7'b1000000; // 0
      4'b0001: led7_doan_output = 7'b1111001; // 1
      4'b0010: led7_doan_output = 7'b0100100; // 2
      4'b0011: led7_doan_output = 7'b0110000; // 3
      4'b0100: led7_doan_output = 7'b0011001; // 4
      4'b0101: led7_doan_output = 7'b0010010; // 5
      4'b0110: led7_doan_output = 7'b0000010; // 6
      4'b0111: led7_doan_output = 7'b1111000; // 7
      4'b1000: led7_doan_output = 7'b0000000; // 8
      4'b1001: led7_doan_output = 7'b0010000; // 9
      default: led7_doan_output = 7'b1111111; // Display nothing if invalid input
    endcase
  end
endmodule
