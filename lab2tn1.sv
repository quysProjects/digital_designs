module lab2tn1(
  input x,y,z,
  output f,a,b,c
);
  assign f = (~x) & y & z | ~(x & y) & z | x & y ;
  assign a = x;
  assign b = y;
  assign c = z;

endmodule


