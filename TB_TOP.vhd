--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:21:05 10/10/2016
-- Design Name:   
-- Module Name:   C:/Users/Jagannath Paudel/Documents/fpga/alarm/TB_TOP.vhd
-- Project Name:  alarm
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_TOP IS
END TB_TOP;
 
ARCHITECTURE behavior OF TB_TOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clkin : IN  std_logic;
         keysin : IN  std_logic_vector(3 downto 0);
         rstin : IN  std_logic;
         sensor : IN  std_logic;
         led_out : OUT  std_logic_vector(2 downto 0);
         armed_led_out : OUT  std_logic;
         disarmed_led_out : OUT  std_logic;
         alarm_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clkin : std_logic := '0';
   signal keysin : std_logic_vector(3 downto 0) := (others => '0');
   signal rstin : std_logic := '0';
   signal sensor : std_logic := '0';

 	--Outputs
   signal led_out : std_logic_vector(2 downto 0);
   signal armed_led_out : std_logic;
   signal disarmed_led_out : std_logic;
   signal alarm_out : std_logic;

   -- Clock period definitions
   constant clkin_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clkin => clkin,
          keysin => keysin,
          rstin => rstin,
          sensor => sensor,
          led_out => led_out,
          armed_led_out => armed_led_out,
          disarmed_led_out => disarmed_led_out,
          alarm_out => alarm_out
        );

   -- Clock process definitions
   clkin_process :process
   begin
		clkin <= '0';
		wait for clkin_period/2;
		clkin <= '1';
		wait for clkin_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		RSTIN<='1';
		wait for 500 ns;
		rstin<='0';
      
      

      wait for clkin_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
