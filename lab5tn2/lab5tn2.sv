module streetA(light_highway, C, clk, rst_n, outled);

parameter HGRE=2'b00, // Highway green and farm red

HYEL = 2'b01,// Highway yellow and farm red

HRED=2'b10;// Highway red and farm green

input C, // sensor

clk, // clock = 50 MHz

rst_n; // reset active low

output reg[2:0] light_highway; // output of lights

reg[27:0] count=0, red= 9, green = 5, count_delay=3, temp=0;

output reg[6:0] outled = ~7'b0111111;

reg delay3s1=0,delay5s=0,delay9s=0,YELLOW_count_en1=0,GREEN_count_en1=0,RED_count_en1=0;

wire clk_enable; // clock enable signal for 1s

reg[1:0] state, next_state;

// next state

always @(posedge clk or negedge rst_n)

begin

if(~rst_n)

state <= 2'b00;

else

state <= next_state;

end

// FSM

always @(*)

begin

case(state)

HGRE: begin // Green on highway and red on farm way

RED_count_en1=0;

YELLOW_count_en1=0;

GREEN_count_en1=1;

light_highway = 3'b001;

if(delay5s) next_state = HYEL;

else next_state =HGRE;

end

HYEL: begin// yellow on highway and red on farm way

light_highway = 3'b010;

GREEN_count_en1=0;

YELLOW_count_en1=1;

RED_count_en1=0;

if(delay3s1) next_state = HRED;

// yellow for 3s, then red

else next_state = HYEL;

end

HRED: begin// red on highway and green on farm way

light_highway = 3'b100;

GREEN_count_en1=0;

YELLOW_count_en1=0;

RED_count_en1=1;

if(delay9s) next_state = HGRE;

else next_state =HRED;

end

endcase 

end


always @(posedge clk)

begin

if(clk_enable==1) begin

if(RED_count_en1) begin

red <= red - 1;

if((count_delay == 0)&& RED_count_en1)

begin

delay3s1=0;

delay5s=0;

delay9s=1;

red<=9;

end

end

else if(GREEN_count_en1) begin

green <= green -1;

if ((green == 0) && GREEN_count_en1)

begin 

delay3s1 = 0;

delay5s=1;

delay9s=0;

green <= 5;

end

end

else if(YELLOW_count_en1)

count_delay <=count_delay - 1;

if((count_delay == 0)&& YELLOW_count_en1)

begin

delay3s1=1;

delay5s=0;

delay9s=0;

count_delay<= 3;

end

end

else

begin

delay3s1=0;

delay5s=0;

delay9s=0;

end

end

// create 1s clock enable
always @(posedge clk_enable) begin 
if(GREEN_count_en1) temp <= green;
if(YELLOW_count_en1) temp <= count_delay;
if(RED_count_en1) temp <= red;
	case (temp)
		0: outled = ~7'b0111111;
		1: outled = ~7'b0110000;
		2: outled = ~7'b1011011;
		3: outled = ~7'b1001111;
		4:	outled = ~7'b1100110;
		5: outled = ~7'b1101101;
		6: outled = ~7'b1111101;
		7: outled = ~7'b0000111;
		8: outled = ~7'b1111111;
		9: outled = ~7'b1101111;
		default: outled = ~7'b0111111;
 	endcase
end

always @(posedge clk)

begin

count <=count + 1;

if(count == 50000000) // for testbench

count <= 0;

end

assign clk_enable = count==50000000 ? 1: 0; // 50,000,000 for 50MHz running on FPGA

endmodule 

module streetB(farm_highway, C, clk, rst_n, outled);

parameter FGRE=2'b00, // Highway green and farm red

FYEL = 2'b01,// Highway yellow and farm red

FRED=2'b10;// Highway red and farm green

input C, // sensor

clk, // clock = 50 MHz

rst_n; // reset active low
output reg[2:0] farm_highway; // output of lights

reg[27:0] count=0, red= 9, green = 5, count_delay=3, temp=0;

output reg[6:0] outled = ~7'b0111111;

reg delay3s1=0,delay5s=0,delay9s=0,YELLOW_count_en1=0,GREEN_count_en1=0,RED_count_en1=0;

wire clk_enable; // clock enable signal for 1s

reg[1:0] state, next_state;

// next state

always @(posedge clk or negedge rst_n)

begin

if(~rst_n)

state <= 2'b10;

else

state <= next_state;

end

// FSM

always @(*)

begin

case(state)

FGRE: begin // Green on highway and red on farm way

RED_count_en1=0;

YELLOW_count_en1=0;

GREEN_count_en1=1;

farm_highway = 3'b001;

if(delay5s) next_state = FYEL;

else next_state =FGRE;

end

FYEL: begin// yellow on highway and red on farm way

farm_highway = 3'b010;

GREEN_count_en1=0;

YELLOW_count_en1=1;

RED_count_en1=0;

if(delay3s1) next_state = FRED;

// yellow for 3s, then red

else next_state = FYEL;

end

FRED: begin// red on highway and green on farm way

farm_highway = 3'b100;

GREEN_count_en1=0;

YELLOW_count_en1=0;

RED_count_en1=1;

if(delay9s) next_state = FGRE;

else next_state =FRED;

end

endcase 

end


always @(posedge clk)

begin

if(clk_enable==1) begin

if(RED_count_en1) begin

red <= red - 1;

if((count_delay == 0)&& RED_count_en1)

begin

delay3s1=0;

delay5s=0;

delay9s=1;

red<=9;

end

end

else if(GREEN_count_en1) begin

green <= green -1;

if ((green == 0) && GREEN_count_en1)

begin 

delay3s1 = 0;

delay5s=1;

delay9s=0;

green <= 5;

end

end

else if(YELLOW_count_en1)

count_delay <=count_delay - 1;

if((count_delay == 0)&& YELLOW_count_en1)

begin

delay3s1=1;

delay5s=0;

delay9s=0;

count_delay<= 3;

end

end

else

begin

delay3s1=0;

delay5s=0;

delay9s=0;

end

end

// create 1s clock enable
always @(posedge clk_enable) begin 
if(GREEN_count_en1) temp <= green;
if(YELLOW_count_en1) temp <= count_delay;
if(RED_count_en1) temp <= red;
	case (temp)
		0: outled = ~7'b0111111;
		1: outled = ~7'b0110000;
		2: outled = ~7'b1011011;
		3: outled = ~7'b1001111;
		4:	outled = ~7'b1100110;
		5: outled = ~7'b1101101;
		6: outled = ~7'b1111101;
		7: outled = ~7'b0000111;
		8: outled = ~7'b1111111;
		9: outled = ~7'b1101111;
		default: outled = ~7'b0111111;
 	endcase
end

always @(posedge clk)

begin

count <=count + 1;

if(count == 50000000) // for testbench

count <= 0;

end

assign clk_enable = count==50000000 ? 1: 0; // 50,000,000 for 50MHz running on FPGA

endmodule 

module lab5tn2(light_highway, farm_highway, C, clk, rst_n, outled0, outled1);

input logic C;

output reg[2:0] light_highway, farm_highway;

input clk,rst_n;

output reg[6:0] outled0, outled1;

streetA streetA(
 .light_highway(light_highway),
 .C(C),
 .rst_n(rst_n),
 .outled(outled0));
 
streetB streetB(
 .farm_highway(farm_highway),
 .C(C),
 .rst_n(rst_n),
 .outled(outled1));
endmodule