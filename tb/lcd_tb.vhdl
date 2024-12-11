-- Project      : 
-- Design       : 
-- Verification : 
-- Reviewers    : 
-- Module       : lcd_tb.vhdl
-- Parent       : none
-- Children     : display.vhdl
-- Description  : Functional verification of display module

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lcd_tb IS
END ENTITY lcd_tb;

ARCHITECTURE lcd_tb_arch OF lcd_tb IS

  CONSTANT CLK_FREQ : REAL := 100.0e6; -- 100 MHz
  CONSTANT PERIOD   : TIME := 1.0/CLK_FREQ * 1.0e9 ns;

  -- expected commands
  CONSTANT COMMAND_0 : STD_LOGIC_VECTOR := "00110100";
  CONSTANT COMMAND_1 : STD_LOGIC_VECTOR := "00001000";
  CONSTANT COMMAND_2 : STD_LOGIC_VECTOR := "00001100";
  CONSTANT COMMAND_3 : STD_LOGIC_VECTOR := "00000001";
  CONSTANT COMMAND_4 : STD_LOGIC_VECTOR := "00110001";
  CONSTANT COMMAND_5 : STD_LOGIC_VECTOR := "00111010";
  CONSTANT COMMAND_6 : STD_LOGIC_VECTOR := "00110101";

  COMPONENT display IS
    PORT (
      clk     : IN    STD_LOGIC;
      reset   : IN    STD_LOGIC;
      lcd_rs  : OUT   STD_LOGIC;
      lcd_rw  : OUT   STD_LOGIC;
      lcd_e   : OUT   STD_LOGIC;
      lcd_db  : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

  SIGNAL clk    : STD_LOGIC := '0';
  SIGNAL reset  : STD_LOGIC;
  SIGNAL lcd_rs : STD_LOGIC;
  SIGNAL lcd_rw : STD_LOGIC;
  SIGNAL lcd_e  : STD_LOGIC;
  SIGNAL lcd_db : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
  -- unit under test
  uut : display
  PORT MAP(
            clk     => clk,
            reset   => reset,
            lcd_rs  => lcd_rs,
            lcd_rw  => lcd_rw,
            lcd_e   => lcd_e,
            lcd_db  => lcd_db);

  clk <= NOT clk AFTER PERIOD/2.0;

  reset_gen : PROCESS
  BEGIN
    reset <= '0';
    WAIT FOR PERIOD;
    reset <= '1';
    WAIT;
  END PROCESS;

  verification_proc : PROCESS
  BEGIN
    -- check received commands
    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_0) REPORT "Not the expected command" SEVERITY warning;

    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_1) REPORT "Not the expected command" SEVERITY warning;

    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_3) REPORT "Not the expected command" SEVERITY warning;

    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_2) REPORT "Not the expected command" SEVERITY warning;

    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_4) REPORT "Not the expected command" SEVERITY warning;

    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_5) REPORT "Not the expected command" SEVERITY warning;

    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_0) REPORT "Not the expected command" SEVERITY warning;

    WAIT UNTIL rising_edge(lcd_rw);
    ASSERT (lcd_e = '1') REPORT "enable not high" SEVERITY warning;

    ASSERT (lcd_db = COMMAND_6) REPORT "Not the expected command" SEVERITY warning;

    WAIT FOR 100 ns;
    -- Force testbench to stop when the transmission is finished.
    REPORT "Testbench finished!" SEVERITY failure;
  END PROCESS verification_proc;
END ARCHITECTURE lcd_tb_arch;