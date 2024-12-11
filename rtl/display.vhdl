-- Project      : 
-- Design       : 
-- Verification : 
-- Reviewers    : 
-- Module       : display.vhdl
-- Parent       : none
-- Children     : none
-- Description  : LCD Controller

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY display IS
	PORT (
		clk		: IN std_logic;
		reset	: IN std_logic;
		lcd_rs	: OUT std_logic; --register select
		lcd_rw	: OUT std_logic; --read/wrtie
		lcd_e	: OUT std_logic; --enable
		lcd_db	: INOUT std_logic_vector(7 DOWNTO 0)
	);
END ENTITY;