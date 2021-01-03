module tb_parking_system;

  reg clk;
  reg reset_n;
  reg sensor_entrance;
  reg sensor_exit;
  reg [3:0] password_1;
  reg [3:0] password_2;
  reg [7:0] password_3;
  reg [7:0] password_4;
  reg [3:0] password_5;
  reg [3:0] password_6;
  reg [3:0] password_7;
  

 
  wire GREEN_LED;
  wire RED_LED;
  wire [6:0] HEX_1;
  wire [6:0] HEX_2;


  parking_system uut (
  .clk(clk), 
  .reset_n(reset_n), 
  .sensor_entrance(sensor_entrance), 
  .sensor_exit(sensor_exit), 
  .password_1(password_1), 
  .password_2(password_2),
  .password_3(password_3),
  .password_4(password_4),
  .password_5(password_5),
  .password_6(password_6),
  .password_7(password_7), 
  .GREEN_LED(GREEN_LED), 
  .RED_LED(RED_LED), 
  .HEX_1(HEX_1), 
 .HEX_2(HEX_2)
 );

 initial begin
 
 $dumpfile("tb_parking_system.vcd");
 $dumpvars(0,tb_parking_system);

clk =0; 
reset_n=1;

#1 reset_n=0; sensor_entrance = 1;

#5 clk=1;reset_n=1;
#1 clk=0; 

#10 sensor_entrance = 1;

clk=1;
password_1=2;
password_2=6;
password_3=84;
password_4=65;
password_5=6;
password_6=6;
password_7=1;

#1 clk=0;
#1 clk=1;





#10 $finish;
end
 
      
endmodule