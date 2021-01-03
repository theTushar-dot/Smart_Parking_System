module parking_system( 
                input clk,reset_n,
 input sensor_entrance, sensor_exit, 
 input [3:0] password_1, password_2,password_5,password_6,password_7,
 input [7:0] password_3, password_4,
 output wire GREEN_LED,RED_LED,
 output reg [6:0] HEX_1, HEX_2
    );
 parameter IDLE = 3'b000, WAIT_PASSWORD = 3'b001, WRONG_PASS = 3'b010, RIGHT_PASS = 3'b011,STOP = 3'b100;

 reg[2:0] current_state, next_state;
 reg[31:0] counter_wait;
 reg red_tmp,green_tmp;

 always @(posedge clk or negedge reset_n)
 begin
 if(~reset_n) 
 current_state = IDLE;
 else
 current_state = next_state;
 end

 always @(posedge clk or negedge reset_n) 
 begin
 if(~reset_n) 
 counter_wait <= 0;
 else if(current_state==WAIT_PASSWORD)
 counter_wait <= counter_wait + 1;
 else 
 counter_wait <= 0;
 end
 
 always @(*)
 begin
 case(current_state)
 IDLE: begin
         if(sensor_entrance == 1)
 next_state = WAIT_PASSWORD;
 else
 next_state = IDLE;
 end
 WAIT_PASSWORD: begin
 if(counter_wait == 3)
 next_state = WAIT_PASSWORD;
 else 
 begin
 if((password_1==4'b0010)&&(password_2==4'b0110)&&(password_3==8'b01010100)&&(password_4==8'b01000001)&&(password_5==4'b0110)&&(password_6==4'b0110)&&(password_7==4'b0001))
 next_state = RIGHT_PASS;
 else
 next_state = WRONG_PASS;
 end
 end
 WRONG_PASS: begin
 if((password_1==4'b0010)&&(password_2==4'b0110)&&(password_3==8'b01010100)&&(password_4==8'b01000001)&&(password_5==4'b0110)&&(password_6==4'b0110)&&(password_7==4'b0001))
 next_state = RIGHT_PASS;
 else
 next_state = WRONG_PASS;
 end
 RIGHT_PASS: begin
 if(sensor_entrance==1 && sensor_exit == 1)
 next_state = STOP;
 else if(sensor_exit == 1)
 next_state = IDLE;
 else
 next_state = RIGHT_PASS;
 end
 STOP: begin
 if((password_1==4'b0010)&&(password_2==4'b0110)&&(password_3==8'b01010100)&&(password_4==8'b01000001)&&(password_5==4'b0110)&&(password_6==4'b0110)&&(password_7==4'b0001))
 next_state = RIGHT_PASS;
 else
 next_state = STOP;
 end
 default: next_state = IDLE;
 endcase
 end

 always @(posedge clk) begin 
 case(current_state)
 IDLE: begin
 green_tmp = 1'b0;
 red_tmp = 1'b0;
 HEX_1 = 7'b1111111; 
 HEX_2 = 7'b1111111; 
 end
 WAIT_PASSWORD: begin
 green_tmp = 1'b0;
 red_tmp = 1'b1;
 HEX_1 = 7'b000_0110; 
 HEX_2 = 7'b010_1011;  
 end
 WRONG_PASS: begin
 green_tmp = 1'b0;
 red_tmp = ~red_tmp;
 HEX_1 = 7'b000_0110; 
 HEX_2 = 7'b000_0110;  
 end
 RIGHT_PASS: begin
 green_tmp = ~green_tmp;
 red_tmp = 1'b0;
 HEX_1 = 7'b000_0010; 
 HEX_2 = 7'b100_0000; 
 end
 STOP: begin
 green_tmp = 1'b0;
 red_tmp = ~red_tmp;
 HEX_1 = 7'b001_0010; 
 HEX_2 = 7'b000_1100;  
 end
 endcase
 end
 assign RED_LED = red_tmp  ;
 assign GREEN_LED = green_tmp;

endmodule
