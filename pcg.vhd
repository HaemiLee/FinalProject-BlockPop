library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

PACKAGE MY IS
PROCEDURE SQ(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER;SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC; signal visible : in std_logic; signal counter : in INTEGER );
PROCEDURE SQF(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER;SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC; signal visible : in std_logic);
END MY;

PACKAGE BODY MY IS
PROCEDURE SQ(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER;SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC; signal visible : in  std_logic; signal counter : in INTEGER ) IS
BEGIN
 --IF(Xcur>Xpos AND Xcur<(Xpos+50) AND Ycur>Ypos AND Ycur<(Ypos+50))THEN
 IF(Xcur>Xpos AND Xcur<(Xpos+100) AND Ycur>Ypos AND Ycur<(Ypos+100))THEN
	if (visible = '1') then	
		RGB <= "1111";
		DRAW<='0';
	else
	RGB<="0000";
	 DRAW<='1';
	end if; 
	ELSE
	 RGB <= "1111";
	 DRAW<='0';
 END IF;
 
 
 
 
 
 --visible = 0 CAN SEE IT
	--if(visible = '0') then 
--	 RGB<="0000";
	-- DRAW<='1';
--	else
--	RGB <= "1111";
--	DRAW<='0';
--	end if; 
--	ELSE
	 --RGB <= "1111";
	 --DRAW<='0';
-- END IF;
 
END SQ;

PROCEDURE SQF(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER;SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC; signal visible : in  std_logic) IS
BEGIN
 --IF(Xcur>Xpos AND Xcur<(Xpos+50) AND Ycur>Ypos AND Ycur<(Ypos+50))THEN
 IF(Xcur>Xpos AND Xcur<(Xpos+50) AND Ycur>Ypos AND Ycur<(Ypos+50))THEN
	if(visible = '0') then 
	 RGB<="0000";
	 DRAW<='1';
	else
	RGB <= "1111";
	DRAW<='0';
	end if; 
	ELSE
	 RGB <= "1111";
	 DRAW<='0';
 END IF;
 
END SQF;


END MY;