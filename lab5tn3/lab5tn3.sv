module lab5tn3(
	input clk,
	output reg lcd_e,lcd_rs,lcd_on,lcd_rw,lcd_blon,
	output reg [7:0] data);
	
	integer j = 1;
	reg[7:0] Datas [1:37];
  assign lcd_on = 1;
  assign lcd_rw = 0;
assign lcd_blon = 1;
	always @(posedge clk) begin
Datas[1]   =  8'h38;    //-- control instruction : configure - 2 lines, 5x7 matrix --
Datas[2]   =  8'h0C;    //-- control instruction : Display on, cursor off --
Datas[3]   =  8'h06;    //-- control instruction : Increment cursor : shift cursor to right --
Datas[4]   =  8'h01;    //-- control instruction : clear display screen --
Datas[5]   =  8'h80;    //-- control instruction : force cursor to begin at first line --

Datas[6]   =  8'h54;    //-- T --
Datas[7]   =  8'h68;    //-- h --
Datas[8]   =  8'h69;    //-- i --
Datas[9]   =  8'h20;    //--   --
Datas[10]  =  8'h6E;    //-- n --
Datas[11]  =  8'h67;    //-- g --
Datas[12]  =  8'h68;    //-- h --
Datas[13]  =  8'h69;    //-- i --
Datas[14]  =  8'h65;    //-- e --
Datas[15]  =  8'h6D;    //-- m --
Datas[16]  =  8'h20;    //--   --
Datas[17]  =  8'h35;    //-- 5 --

Datas[18]  =  8'h20;    //--   --
Datas[19]  =  8'h4B;    //-- K --
Datas[20]  =  8'h54;    //-- T --
Datas[21]  =  8'h53;    //-- S --
Datas[22]  = 8'hC1;		

Datas[23]  = 8'h42;		//-- B --
Datas[24]  = 8'h4D;		//-- M -- 
Datas[25]  = 8'h20;		//--   -- 
Datas[26]  = 8'h44;		//-- D -- 
Datas[27]  = 8'h69;		//-- i -- 
Datas[28]  = 8'h65;		//-- e -- 
Datas[29]  = 8'h6E;		//-- n -- 
Datas[30]  = 8'h20;		//--   -- 
Datas[31]  = 8'h54;		//-- T --
Datas[32]  = 8'h75;		//-- u --
Datas[33]  = 8'h20;		//--   --
Datas[34]  = 8'h44;		//-- D -- 
Datas[35]  = 8'h48;		//-- H -- 
Datas[36]  = 8'h42;		//-- B --
Datas[37]  = 8'h4B;		//-- K --      
end
integer i = 0; //

always @(posedge clk) begin

//-- Delay for writing data  
  if (i <= 100000) begin
  i = i + 1; lcd_e = 1;
  data = Datas[j];
  end
  
  else if (i > 100000 & i < 2000000) begin
  i = i + 1; lcd_e = 0;
  end
  
  else if (i == 2000000) begin
  j = j + 1; i = 0;
  end
  else i = 0;
  
 //-- LCD_RS signal should be set to 0 for writing commands and to 1 for writing data

  if (j <= 5 )
    lcd_rs = 0;  
  else if (j > 5 & j< 22)
    lcd_rs = 1;
  else if (j == 22)
	 lcd_rs = 0;
  else if (j > 22 & j< 38)
    lcd_rs = 1;
 // else if (j == 38)
  //  lcd_rs = 0;
  else if (j > 38) begin 
    lcd_rs = 1;
    j = 5;
    end
  else
   lcd_rs = 1;
  //else if (j > 27) begin 
   // lcd_rs = 1;
  ///  j = 5;
  //end
end
endmodule
