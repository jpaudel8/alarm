library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity code is
    Port ( clk : in  STD_LOGIC;
           keysin : in  STD_LOGIC_VECTOR (3 downto 0);
           led_out : out  STD_LOGIC_VECTOR (2 downto 0);
           rst : in  STD_LOGIC;
           armed_led_out : out  STD_LOGIC;
           disarmed_led_out : out  STD_LOGIC;
			  alarm_out :out std_logic;
			  sensor: in std_logic);
end code;

architecture Behavioral of code is
type state_type is (armed,c1,c2,c3,w1,w2,w3,disarmed,arming); 
   signal state, next_state : state_type; 
   
   signal armed_led,disarmed_led : std_logic;  
   signal led : std_logic_vector(2 downto 0);
   signal alarmed : std_logic;
   signal Q1, Q2, Q3,keys : std_logic_vector(3 downto 0);
	

begin

SYNC_PROC : process (clk)
   begin
      if (clk'event and clk = '1') then
         if (rst = '1') then
            state <= armed;
            disarmed_led_out <='0';
				armed_led_out<='1';
				led_out<="000";
         else
			
            disarmed_led_out<=disarmed_led;
				armed_led_out<=armed_led;
				led_out<=led;
			
            state <= next_state;
            
         end if;        
      end if;
   end process;
	
	
process(clk)
begin
   if (clk'event and clk = '1') then
      if (rst = '1') then
         Q1 <= "0000";
         Q2 <= "0000";
         Q3 <= "0000"; 
      else
         Q1 <= keysin;
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
   end if;
end process;
 
keys <= Q1 and Q2 and (not Q3);
 
	
	
	
	process (clk)
		begin
			if (clk'event and clk = '1') then
				if (rst='1') then
					alarmed <='0';
				elsif (state=disarmed) or (state=arming) then
					alarmed<='0';
				else
					if (sensor='1') then
						alarmed<='1';
					end if;
				end if;
			end if;
	end process;
	
 
   
   OUTPUT_DECODE: process  (state)
   begin
      if state = armed then
         armed_led<='1';
			disarmed_led<='0';
			led<="000";
		
		elsif (state = c1) or (state = w1) then
			armed_led<='1';
			disarmed_led<='0';
			led<="001";
		elsif (state = c2) or (state = w2) then
			armed_led<='1';
			disarmed_led<='0';
			led<="010";
		elsif (state = c3) or (state = w3) then
			armed_led<='1';
			disarmed_led<='0';
			led<="100";
		elsif state = arming then
			armed_led<='0';
			disarmed_led<='1';
			led<="000";
		elsif state = disarmed then
			armed_led<='0';
			disarmed_led<='1';
			led<="000";
		
		
      else
         armed_led<='1';
			disarmed_led<='0';
			led<="000";
      end if;
   end process;
 
   NEXT_STATE_DECODE: process (state,keys)
   begin
       next_state <= state;  
       case (state) is
         when armed =>
            if keys = "0100" then
               next_state <= c1;
				elsif keys = "0000" then
					next_state <= armed;
				else 
					next_state <=w1;
            end if;
				
			when c1 =>
            if keys = "1000" then
               next_state <= c2;
				elsif keys = "0000" then
					next_state <= c1;
				else 
					next_state <=w2;
            end if;
				
			when c2 =>
            if keys = "1000" then
               next_state <= c3;
				elsif keys = "0000" then
					next_state <= c2;
				else 
					next_state <=w3;
            end if;
				
			when c3 =>
            if keys = "0001" then
               next_state <= disarmed;
				elsif keys = "0000" then
					next_state <= c3;
				else 
					next_state <=armed;
            end if;
				
			when disarmed =>
            if keys = "0001" then
					next_state<=arming;
				elsif keys = "0000" then
					next_state<=disarmed;
				else
					next_state<=disarmed;
            end if;
				
			when arming =>
            if keys = "1000" then
               next_state <= armed;
				elsif keys = "0000" then
					next_state <= arming;
				else 
					next_state <=disarmed;
            end if;
				
			when w1 =>
				if keys /= "0000" then
					 next_state <= w2;
				end if;
				
			when w2 =>
				if keys /= "0000" then
					 next_state <= w3;
				end if;
				
			when w3 =>
				if keys /= "0000" then
					 next_state <= armed;
				end if;
				
			
			
			
			
				
         
         when others =>
            next_state <= armed;
      end case;      
   end process;

				
alarm_out<=alarmed;

end Behavioral;

