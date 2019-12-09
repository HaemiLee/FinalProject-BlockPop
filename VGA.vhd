library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY VGA IS
PORT(
CLOCK_24: IN STD_LOGIC_VECTOR(1 downto 0);
VGA_HS,VGA_VS:OUT STD_LOGIC;
SW: STD_LOGIC_VECTOR(1 downto 0);
KEY: STD_LOGIC_VECTOR(3 DOWNTO 0);
VGA_R,VGA_B,VGA_G: OUT STD_LOGIC_VECTOR(3 downto 0);
--pointsinner : out unsigned(11 downto 0);
hex1 : out std_LOGIC_VECTOR(6 downto 0);
hex2 : out std_LOGIC_VECTOR( 6 downto 0);
hex3 : out std_logic_VECTOR( 6 downto 0)
);
END VGA;


ARCHITECTURE MAIN OF VGA IS
SIGNAL VGACLK,RESET:STD_LOGIC;
signal pointsinner: unsigned(11 downto 0);
 COMPONENT SYNC IS
 PORT(
	CLK: IN STD_LOGIC;
	HSYNC: OUT STD_LOGIC;
	VSYNC: OUT STD_LOGIC;
	R: OUT STD_LOGIC_VECTOR(3 downto 0);
	G: OUT STD_LOGIC_VECTOR(3 downto 0);
	B: OUT STD_LOGIC_VECTOR(3 downto 0);
	KEYS: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
   S: IN STD_LOGIC_VECTOR(1 downto 0);
	points: out unsigned(11 downto 0)
	);
END COMPONENT SYNC;

component sevenSegmentDriver is
port(
	a : in std_LOGIC_VECTOR(3 downto 0);
	result : out std_LOGIC_VECTOR(6 downto 0)


);
end component sevenSegmentDriver;
	


    component pll is
        port (
            clkout_clk : out std_logic;        -- clk
            clkin_clk  : in  std_logic := 'X'; -- clk
            rst_reset  : in  std_logic := 'X'  -- reset
        );
	 END COMPONENT pll;
 BEGIN
 
 C: pll PORT MAP (VGACLK,CLOCK_24(0),RESET);
 C1: SYNC PORT MAP(VGACLK,VGA_HS,VGA_VS,VGA_R,VGA_G,VGA_B,KEY,SW, points => pointsinner);
 h1: sevenSegmentDriver port map(a => std_LOGIC_VECTOR(pointsinner(11 downto 8)), result => hex1);
 h2: sevenSegmentDriver port map(a => std_LOGIC_VECTOR(pointsinner(7 downto 4)), result => hex2);
 h3: sevenSegmentDriver port map(a => std_LOGIC_VECTOR(pointsinner(3 downto 0)), result => hex3);
 
 
 END MAIN;
 