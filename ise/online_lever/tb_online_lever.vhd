--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:37:37 03/01/2018
-- Design Name:   
-- Module Name:   E:/FPGA/26online_lever/ise/online_lever/tb_online_lever.vhd
-- Project Name:  online_lever
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: spi_ce
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
 
ENTITY tb_online_lever IS
END tb_online_lever;
 
ARCHITECTURE behavior OF tb_online_lever IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT spi_ce
    PORT(
         sclk : IN  std_logic;
         rst_n : IN  std_logic;
         key_in : IN  std_logic;
         cs_n : OUT  std_logic;
         sck : OUT  std_logic;
         sdi : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sclk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal key_in : std_logic := '0';

 	--Outputs
   signal cs_n : std_logic;
   signal sck : std_logic;
   signal sdi : std_logic;

   -- Clock period definitions
   constant sclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spi_ce PORT MAP (
          sclk => sclk,
          rst_n => rst_n,
          key_in => key_in,
          cs_n => cs_n,
          sck => sck,
          sdi => sdi
        );

   -- Clock process definitions
   sclk_process :process
   begin
		sclk <= '0';
		wait for sclk_period/2;
		sclk <= '1';
		wait for sclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for sclk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
