--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:42:03 10/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Jagannath Paudel/Documents/fpga/alarm/test.vhd
-- Project Name:  alarm
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: code
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports o	f the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT code
    PORT(
         clk : IN  std_logic;
         keysin : IN  std_logic_vector(3 downto 0);
         led_out : OUT  std_logic_vector(2 downto 0);
         rst : IN  std_logic;
         armed_led_out : OUT  std_logic;
         disarmed_led_out : OUT  std_logic;
         alarm_out : OUT  std_logic;
         sensor : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal keysin : std_logic_vector(3 downto 0) := (others => '0');
   signal rst : std_logic := '0';
   signal sensor : std_logic := '0';

 	--Outputs
   signal led_out : std_logic_vector(2 downto 0);
   signal armed_led_out : std_logic;
   signal disarmed_led_out : std_logic;
   signal alarm_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: code PORT MAP (
          clk => clk,
          keysin => keysin,
          led_out => led_out,
          rst => rst,
          armed_led_out => armed_led_out,
          disarmed_led_out => disarmed_led_out,
          alarm_out => alarm_out,
          sensor => sensor
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst<='1';
      wait for 500 ns;	
		rst<='0';
		sensor<='0';
		wait for 600 ns;
		sensor<='1';
		keysin<="0100";
		wait for 500 ns;
		keysin<="0000";
		wait for 500 ns;
		keysin<="1000";
		wait for 500 ns;
		keysin<="0000";
		wait for 500 ns;
		keysin<="1000";
		wait for 500 ns;
		keysin<="0000";
		wait for 500 ns;
		keysin<="0001";
		wait for 500 ns;
		keysin<="0000";
		wait for 500 ns;
		
		
		

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
