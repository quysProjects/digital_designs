module lab2tn2(
  input x,y,z,
  output f,a,b,c
);
  assign f = (~x&~y)|(~y&~z)|(y&z);
  assign a = x;
  assign b = y;
  assign c = z;
  
endmodule
