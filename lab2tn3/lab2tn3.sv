module lab2tn3(
  input x,y,z,
  output f,a,b,c
);
  assign f = x & (~y);
  assign a = x;
  assign b = y;
  assign c = z;
  
endmodule