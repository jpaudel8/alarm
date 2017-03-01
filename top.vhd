----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:25:44 10/09/2016 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    
	 
PORT(
		clkin : IN std_logic;
		keysin : IN std_logic_vector(3 downto 0);
		rstin : IN std_logic;
		sensor : IN std_logic;          
		led_out : OUT std_logic_vector(2 downto 0);
		armed_led_out : OUT std_logic;
		disarmed_led_out : OUT std_logic;
		alarm_out : OUT std_logic
		);	 
	 
end top;

architecture Behavioral of top is


	COMPONENT code
	PORT(
		clk : IN std_logic;
		keysin : IN std_logic_vector(3 downto 0);
		rst : IN std_logic;
		sensor : IN std_logic;          
		led_out : OUT std_logic_vector(2 downto 0);
		armed_led_out : OUT std_logic;
		disarmed_led_out : OUT std_logic;
		alarm_out : OUT std_logic
		);
	END COMPONENT;
	
	

	COMPONENT myclock
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		CLK2X_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;	
	signal rst,clk,locked :std_logic;

begin




Inst_myclock: myclock PORT MAP(
		CLKIN_IN => clkin,
		RST_IN => rstin,
		CLKIN_IBUFG_OUT =>open ,
		CLK0_OUT => open,
		CLK2X_OUT =>clk ,
		LOCKED_OUT => locked
	);

rst<=rstin or (not locked);


Inst_code: code PORT MAP(
		clk => clk,
		keysin => keysin,
		led_out => led_out,
		rst =>rst ,
		armed_led_out => armed_led_out,
		disarmed_led_out => disarmed_led_out,
		alarm_out => alarm_out,
		sensor => sensor
	);


end Behavioral;

