library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my.all;


ENTITY SYNC IS
PORT(
CLK: IN STD_LOGIC;
HSYNC: OUT STD_LOGIC;
VSYNC: OUT STD_LOGIC;
R: OUT STD_LOGIC_VECTOR(3 downto 0);
G: OUT STD_LOGIC_VECTOR(3 downto 0);
B: OUT STD_LOGIC_VECTOR(3 downto 0);
KEYS: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
S: IN STD_LOGIC_VECTOR(1 downto 0);
points: out unsigned(11 downto 0) --this is the counter of the points
);
END SYNC;


ARCHITECTURE MAIN OF SYNC IS
-----1280x1024 @ 60 Hz pixel clock 108 MHz

type state_type is (reset, sFetch, fire);

signal state: state_type;

SIGNAL RGB: STD_LOGIC_VECTOR(3 downto 0);

signal counter2, counter5, counter9, counter13, counter18: INTEGER RANGE 0 TO 3:= 0;

signal counter3, counter7
,counter11,counter14, counter17, counter20, counter21, counter23: INTEGER RANGE 0 TO 3:= 1; 

signal counter1, counter4, counter8, counter12, counter15, counter19, counter22: INTEGER RANGE 0 TO 3:= 2; 

signal counter6, counter10, counter16, counter24, counter25, counter26: INTEGER RANGE 0 TO 3:= 3;

signal visible1, visible2, visible3, visible4, visible5, visible6, visible7, visible8, visible9, visible10
,visible11, visible12, visible13, visible14, visible15, visible16, visible17, visible18, visible19, visible20, visible21, visible22, visible23
,visible24, visible25, visible26, visible27: STD_LOGIC:='0'; 

signal shoot: STD_LOGIC:='0';  -- 0= not ready to shoot 1=


signal speed: INTEGER:=5;

signal pointsin : unsigned(11 downto 0);

--SIGNAL SQ_X1,SQ_Y1: INTEGER RANGE 0 TO 1688:=550;-- starting location of blocks
SIGNAL SQ_X1: INTEGER RANGE 0 TO 1688:=400;-- starting location of blocks
SIGNAL SQ_Y1: INTEGER RANGE 0 TO 1688:=50;-- starting location of blocks
SIGNAL SQ_X2: 	INTEGER RANGE 0 TO 1688:=500;
SIGNAL SQ_Y2: INTEGER RANGE 0 TO 1688:=150;

SIGNAL SQ_X3: 	INTEGER RANGE 0 TO 1688:=600;
SIGNAL SQ_Y3: INTEGER RANGE 0 TO 1688:=50;

SIGNAL SQ_X4: 	INTEGER RANGE 0 TO 1688:=700;
SIGNAL SQ_Y4: INTEGER RANGE 0 TO 1688:=150;

SIGNAL SQ_X5: 	INTEGER RANGE 0 TO 1688:=800;
SIGNAL SQ_Y5: INTEGER RANGE 0 TO 1688:=50;

SIGNAL SQ_X6: 	INTEGER RANGE 0 TO 1688:=900;
SIGNAL SQ_Y6: INTEGER RANGE 0 TO 1688:=150;

SIGNAL SQ_X7: 	INTEGER RANGE 0 TO 1688:=1000;
SIGNAL SQ_Y7: INTEGER RANGE 0 TO 1688:=50;

SIGNAL SQ_X8: 	INTEGER RANGE 0 TO 1688:=1100;
SIGNAL SQ_Y8: INTEGER RANGE 0 TO 1688:=150;

SIGNAL SQ_X9: 	INTEGER RANGE 0 TO 1688:=1200;
SIGNAL SQ_Y9: INTEGER RANGE 0 TO 1688:=50;

SIGNAL SQ_X10: 	INTEGER RANGE 0 TO 1688:=1300;
SIGNAL SQ_Y10: INTEGER RANGE 0 TO 1688:=150;

SIGNAL SQ_X11: 	INTEGER RANGE 0 TO 1688:=1400;
SIGNAL SQ_Y11: INTEGER RANGE 0 TO 1688:=50;

SIGNAL SQ_X12: 	INTEGER RANGE 0 TO 1688:=1500;
SIGNAL SQ_Y12: INTEGER RANGE 0 TO 1688:=150;

SIGNAL SQ_X13: 	INTEGER RANGE 0 TO 1688:=1600;
SIGNAL SQ_Y13: INTEGER RANGE 0 TO 1688:=50;

SIGNAL SQ_X14: INTEGER RANGE 0 TO 1688:=400;-- starting location of blocks
SIGNAL SQ_Y14: INTEGER RANGE 0 TO 1688:=250;-- starting location of blocks

SIGNAL SQ_X15: 	INTEGER RANGE 0 TO 1688:=500;
SIGNAL SQ_Y15: INTEGER RANGE 0 TO 1688:=350;

SIGNAL SQ_X16: 	INTEGER RANGE 0 TO 1688:=600;
SIGNAL SQ_Y16: INTEGER RANGE 0 TO 1688:=250;

SIGNAL SQ_X17: 	INTEGER RANGE 0 TO 1688:=700;
SIGNAL SQ_Y17: INTEGER RANGE 0 TO 1688:=350;

SIGNAL SQ_X18: 	INTEGER RANGE 0 TO 1688:=800;
SIGNAL SQ_Y18: INTEGER RANGE 0 TO 1688:=250;

SIGNAL SQ_X19: 	INTEGER RANGE 0 TO 1688:=900;
SIGNAL SQ_Y19: INTEGER RANGE 0 TO 1688:=350;

SIGNAL SQ_X20: 	INTEGER RANGE 0 TO 1688:=1000;
SIGNAL SQ_Y20: INTEGER RANGE 0 TO 1688:=250;

SIGNAL SQ_X21: 	INTEGER RANGE 0 TO 1688:=1100;
SIGNAL SQ_Y21: INTEGER RANGE 0 TO 1688:=350;

SIGNAL SQ_X22: 	INTEGER RANGE 0 TO 1688:=1200;
SIGNAL SQ_Y22: INTEGER RANGE 0 TO 1688:=250;

SIGNAL SQ_X23: 	INTEGER RANGE 0 TO 1688:=1300;
SIGNAL SQ_Y23: INTEGER RANGE 0 TO 1688:=350;

SIGNAL SQ_X24: 	INTEGER RANGE 0 TO 1688:=1400;
SIGNAL SQ_Y24: INTEGER RANGE 0 TO 1688:=250;

SIGNAL SQ_X25: 	INTEGER RANGE 0 TO 1688:=1500;
SIGNAL SQ_Y25: INTEGER RANGE 0 TO 1688:=350;

SIGNAL SQ_X26: 	INTEGER RANGE 0 TO 1688:=1600;
SIGNAL SQ_Y26: INTEGER RANGE 0 TO 1688:=250;

SIGNAL SQ_X27: 	INTEGER RANGE 0 TO 1688:=1000;
SIGNAL SQ_Y27: INTEGER RANGE 0 TO 1688:=950;

SIGNAL OG_X: 	INTEGER RANGE 0 TO 1688:=1000;
SIGNAL OG_Y: INTEGER RANGE 0 TO 1688:=950;

SIGNAL hit: STD_LOGIC:='0';

SIGNAL dec: INTEGER:=15;




SIGNAL DRAW1,DRAW2,DRAW3, DRAW4, DRAW5, DRAW6, DRAW7,DRAW8, DRAW9 , DRAW10 , DRAW11 , DRAW12, DRAW13, 
DRAW14,DRAW15,DRAW16, DRAW17, DRAW18, DRAW19, DRAW20,DRAW21, DRAW22 , DRAW23 , DRAW24 , DRAW25, DRAW26, DRAW27 :STD_LOGIC:='0';--draws for each block 
SIGNAL HPOS: INTEGER RANGE 0 TO 1688:=0;
SIGNAL VPOS: INTEGER RANGE 0 TO 1066:=0;
BEGIN
SQ(HPOS,VPOS,SQ_X1,SQ_Y1,RGB,DRAW1, visible1, counter1);
SQ(HPOS,VPOS,SQ_X2,SQ_Y2,RGB,DRAW2,visible2, counter2);
SQ(HPOS,VPOS,SQ_X3,SQ_Y3,RGB,DRAW3, visible3, counter3);
SQ(HPOS,VPOS,SQ_X4,SQ_Y4,RGB,DRAW4, visible4, counter4);
SQ(HPOS,VPOS,SQ_X5,SQ_Y5,RGB,DRAW5, visible5, counter5);
SQ(HPOS,VPOS,SQ_X6,SQ_Y6,RGB,DRAW6, visible6, counter6);
SQ(HPOS,VPOS,SQ_X7,SQ_Y7,RGB,DRAW7, visible7, counter7);
SQ(HPOS,VPOS,SQ_X8,SQ_Y8,RGB,DRAW8, visible8, counter8);
SQ(HPOS,VPOS,SQ_X9,SQ_Y9,RGB,DRAW9, visible9, counter9);
SQ(HPOS,VPOS,SQ_X10,SQ_Y10,RGB,DRAW10, visible10, counter10);
SQ(HPOS,VPOS,SQ_X11,SQ_Y11,RGB,DRAW11, visible11, counter11);
SQ(HPOS,VPOS,SQ_X12,SQ_Y12,RGB,DRAW12, visible12, counter12);
SQ(HPOS,VPOS,SQ_X13,SQ_Y13,RGB,DRAW13, visible13, counter13);
SQ(HPOS,VPOS,SQ_X14,SQ_Y14,RGB,DRAW14, visible14, counter14);
SQ(HPOS,VPOS,SQ_X15,SQ_Y15,RGB,DRAW15,visible15, counter15);
SQ(HPOS,VPOS,SQ_X16,SQ_Y16,RGB,DRAW16, visible16, counter16);
SQ(HPOS,VPOS,SQ_X17,SQ_Y17,RGB,DRAW17, visible17, counter17);
SQ(HPOS,VPOS,SQ_X18,SQ_Y18,RGB,DRAW18, visible18, counter18);
SQ(HPOS,VPOS,SQ_X19,SQ_Y19,RGB,DRAW19, visible19, counter19);
SQ(HPOS,VPOS,SQ_X20,SQ_Y20,RGB,DRAW20, visible20, counter20);
SQ(HPOS,VPOS,SQ_X21,SQ_Y21,RGB,DRAW21, visible21, counter21);
SQ(HPOS,VPOS,SQ_X22,SQ_Y22,RGB,DRAW22, visible22, counter22);
SQ(HPOS,VPOS,SQ_X23,SQ_Y23,RGB,DRAW23, visible23, counter23);
SQ(HPOS,VPOS,SQ_X24,SQ_Y24,RGB,DRAW24, visible24, counter24);
SQ(HPOS,VPOS,SQ_X25,SQ_Y25,RGB,DRAW25, visible25, counter25);
SQ(HPOS,VPOS,SQ_X26,SQ_Y26,RGB,DRAW26, visible26, counter26);
SQF(HPOS,VPOS,SQ_X27,SQ_Y27,RGB,DRAW27, visible27);--shooting block 

 PROCESS(CLK)
 BEGIN
IF(CLK'EVENT AND CLK='1')THEN
	if(KEYS(3) = '0') then 
		state<=reset;
	else 
		--pointsin <= "000000000000";
		state<=sFetch;
	end if;
	
	case state is
		when reset => 
			visible1 <='0';
			visible2<='0';
			visible3<='0';
			visible4<='0';
			visible5<='0';
			visible6<='0';
			visible7<='0';
			visible8<='0';
			visible9<='0';
			visible10<='0';
			visible11<='0';
			visible12<='0';
			visible13<='0';
			visible14<='0';
			visible15<='0';
			visible16<='0';
			visible17<='0';
			visible18<='0';
			visible19<='0';
			visible20<='0';
			visible21<='0';
			visible22<='0';
			visible23<='0';
			visible24<='0';
			visible25<='0';
			visible26<='0';
			
			counter1<= 2;
			counter2<= 0;
			counter3<= 1;
			counter4<= 2;
			counter5<= 0;
			counter6<= 3;
			counter7<= 1;
			counter8<= 2;
			counter9<= 0;
			counter10<= 3;
			counter11<= 1;
			counter12<= 2;
			counter13<= 0;
			counter14<= 1;
			counter15<= 2;
			counter16<= 3;
			counter17<= 1;
			counter18<= 0;
			counter19<= 2;
			counter20<= 1;
			counter21<= 1;
			counter22<= 2;
			counter23<= 1;
			counter24<= 3;
			counter25<= 3;
			counter26<= 3;
			
			pointsin <= "000000000000";
		when sFetch=>

      IF(DRAW1='1')THEN 
		--blue = 4 hits
		  IF(counter1 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1');
		--red = 3
		ELSIF(counter1 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter1 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSIF(counter1 = 0)THEN
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
      END IF;
			--yellow
		IF(DRAW2='1')THEN
			IF(counter2 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter2 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter2 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		END IF;
		 
		IF(DRAW3='1')THEN
			IF(counter3 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter3 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter3 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		 END IF;
		 
		 IF(DRAW4='1')THEN
		  --blue = 4 hits
		 IF(counter4 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter4 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter4 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW5='1')THEN
		IF(counter5 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter5 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter5 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW6='1')THEN
		  --green = 2 hits
		IF(counter6 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter6 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter6 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW7='1')THEN
		 --red = 3
		IF(counter7 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter7 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter7 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW8='1')THEN
		 IF(counter8 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter8 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter8 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW9='1')THEN
		 IF(counter9 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter9 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter9 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW10='1')THEN
		  IF(counter10 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter10 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter10 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW11='1')THEN
		  IF(counter11 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter11 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter11 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW12='1')THEN
		IF(counter12 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter12 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter12 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
		IF(DRAW13='1')THEN
		 IF(counter13 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter13 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter13 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		end if;
      IF(DRAW14='1')THEN 
		  IF(counter14 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter14 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter14 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
      END IF;
		 IF(DRAW15='1')THEN
			--red = 3
		IF(counter15 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter15 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter15 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;	
		 END IF;
		 
		 IF(DRAW16='1')THEN
			IF(counter16 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter16 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter16	= 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		 END IF;
		 
		 IF(DRAW17='1')THEN
		  IF(counter17 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter17 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter17 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW18='1')THEN
		 IF(counter18 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter18 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter18 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW19='1')THEN
		  IF(counter19 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter19 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter19 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW20='1')THEN
		  IF(counter20 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter20 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter20 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW21='1')THEN
		  IF(counter21 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter21 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter21 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW22='1')THEN
		 --red = 3
		IF(counter22 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter22 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter22 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW23='1')THEN
		  IF(counter23 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter23 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter23 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW24='1')THEN
		 IF(counter24 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter24 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter24 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW25='1')THEN
		  IF(counter25 = 3)THEN
			R<=(others=>'0');
			G<=(others=>'0');
			B<=(others=>'1'); 
		ELSIF(counter25 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter25 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF; 
		end if;
		IF(DRAW26='1')THEN
		 IF(counter26 = 3)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0'); 
		ELSIF(counter26 = 2)THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
		--green = 2 hits
		ELSIF(counter26 = 1)THEN
			R<=(others=>'0');
			G<=(others=>'1');
			B<=(others=>'0');
		--yellow = 1 hit
		ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'0');
		END IF;
		end if;
		IF(DRAW27='1')THEN
		  IF(S(0)='1')THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'1');
			ELSE
			R<=(others=>'1');
			G<=(others=>'1');		
			B<=(others=>'1');	  
		end if; 
		end if;
		--background
		IF (DRAW1='0' AND DRAW2='0' AND DRAW3 = '0' and DRAW4 = '0' and DRAW5 = '0' and DRAW6 = '0' 
		and DRAW7 = '0' and DRAW8 = '0' and DRAW9 = '0' and DRAW10 = '0' and DRAW11 = '0' and DRAW12 = '0' and DRAW13 = '0'
		and DRAW14='0' AND DRAW15='0' AND DRAW16 = '0' and DRAW17 = '0' and DRAW18 = '0' and DRAW19 = '0' 
		and DRAW20 = '0' and DRAW21 = '0' and DRAW22 = '0' and DRAW23 = '0' and DRAW24 = '0' and DRAW25 = '0' and DRAW26 = '0' and DRAW27 = '0')THEN
		   R<=(others=>'0');
	      G<=(others=>'0');
	      B<=(others=>'0');
		
		END IF;
		IF(HPOS<1688)THEN
		HPOS<=HPOS+1;
		ELSE
		HPOS<=0;
		  IF(VPOS<1066)THEN
			  VPOS<=VPOS+1;
			  ELSE
			  VPOS<=0; 
				SQ_X1<=SQ_X1-4; --KEEP MOVING
				SQ_X2<=SQ_X2+3; 
				SQ_X3<=SQ_X3-4; 
				SQ_X4<=SQ_X4+3; 
				SQ_X5<=SQ_X5-4; 
				SQ_X6<=SQ_X6+3; 
				SQ_X7<=SQ_X7-4; 
				SQ_X8<=SQ_X8+3; 
				SQ_X9<=SQ_X9-4; 
				SQ_X10<=SQ_X10+3; 
				SQ_X11<=SQ_X11-4; 
				SQ_X12<=SQ_X12+3; 
				SQ_X13<=SQ_X13-4; 
				
				SQ_X14<=SQ_X14-4; --KEEP MOVING
				SQ_X15<=SQ_X15+3; 
				SQ_X16<=SQ_X16-4; 
				SQ_X17<=SQ_X17+3; 
				SQ_X18<=SQ_X18-4; 
				SQ_X19<=SQ_X19+3; 
				SQ_X20<=SQ_X20-4; 
				SQ_X21<=SQ_X21+3; 
				SQ_X22<=SQ_X22-4; 
				SQ_X23<=SQ_X23+3; 
				SQ_X24<=SQ_X24-4; 
				SQ_X25<=SQ_X25+3; 
				SQ_X26<=SQ_X26-4;
			      IF(S(1)='0')THEN
					    IF(KEYS(0)='0')THEN
						  SQ_X27<=SQ_X27+5;
						 END IF;
                   IF(KEYS(1)='0')THEN
						  SQ_X27<=SQ_X27-5;
						END IF;
						IF(KEYS(2)='0')THEN
							speed<=speed+5;
							if(speed>15)THEN
								speed<=5;
							end if;
						end if;
						 
					IF(S(0) ='1')THEN
						speed<=speed;
						state<=fire;
					else 
						hit<='0';
						state<=sFetch;
					END IF;
					--SWITCH CHANGE : shoot	
					else

					END IF;
						
		      END IF;
		END IF;
   IF((HPOS>0 AND HPOS<408) OR (VPOS>0 AND VPOS<42))THEN
	R<=(others=>'0');
	G<=(others=>'0');
	B<=(others=>'0');
	END IF;
   IF(HPOS>48 AND HPOS<160)THEN----HSYNC
	   HSYNC<='0';
	ELSE
	   HSYNC<='1';
	END IF;
   IF(VPOS>0 AND VPOS<4)THEN----------vsync
	   VSYNC<='0';
	ELSE
	
	
	

	   VSYNC<='1';
	END IF;
when fire=>
					IF(hit='0') then 
					  SQ_Y27<=SQ_Y27-speed;
					  if(SQ_Y27 <= 25) then
					  SQ_Y27<=OG_Y;
					  hit<='1';
					  state<=reset;
					  else
					  
					  end if;
					  if(visible1 = '0') then 
					  If ((SQ_X27 -25 > SQ_X1-100)) AND ((SQ_X27+25) < (SQ_X1 +100)) AND (SQ_Y27 > SQ_Y1-100) AND ((SQ_Y27) < (SQ_Y1 +100))  THEN
							counter1<= counter1-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter1 =  0) then 
								visible1 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible2 = '0') then 
					  If ((SQ_X27 -25 > SQ_X2-100)) AND ((SQ_X27+25) < (SQ_X2 +100)) AND (SQ_Y27 > SQ_Y2-100) AND ((SQ_Y27) < (SQ_Y2 +100))  THEN
							counter2<= counter2-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter2 =  0) then 
								visible2 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if; 
					if(visible3 = '0') then 
					  If ((SQ_X27-25 > SQ_X3-100)) AND ((SQ_X27+25) < (SQ_X3 +100)) AND (SQ_Y27 > SQ_Y3-100) AND ((SQ_Y27) < (SQ_Y3 +100))  THEN
						counter3<= counter3-1;
						pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter3 =  0) then 
								visible3 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
							
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible4 = '0') then 
					  If ((SQ_X27-25 > SQ_X4-100)) AND ((SQ_X27+25) < (SQ_X4 +100)) AND (SQ_Y27 > SQ_Y4-100) AND ((SQ_Y27) < (SQ_Y4 +100))  THEN
							counter4<= counter4-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter4 =  0) then 
								visible4 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible5 = '0') then 
					  If ((SQ_X27-25 > SQ_X5-100)) AND ((SQ_X27+25) < (SQ_X5 +100)) AND (SQ_Y27 > SQ_Y5-100) AND ((SQ_Y27) < (SQ_Y5+100))  THEN
							counter5<= counter5-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter5 =  0) then 
								visible5 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible6= '0') then 
					  If ((SQ_X27-25 > SQ_X6-100)) AND ((SQ_X27+25) < (SQ_X6 +100)) AND (SQ_Y27 > SQ_Y6-100) AND ((SQ_Y27) < (SQ_Y6 +100))  THEN
							counter6<= counter6-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter6 =  0) then 
								visible6 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible7 = '0') then 
					  If ((SQ_X27-25 > SQ_X7-100)) AND ((SQ_X27+25) < (SQ_X7 +100)) AND (SQ_Y27 > SQ_Y7-100) AND ((SQ_Y27) < (SQ_Y7 +100))  THEN
							counter7<= counter7-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter7 =  0) then 
								visible7 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible8 = '0') then 
					  If ((SQ_X27-25 > SQ_X8-100)) AND ((SQ_X27+25) < (SQ_X8 +100)) AND (SQ_Y27 > SQ_Y8-100) AND ((SQ_Y27) < (SQ_Y8 +100))  THEN
							counter8<= counter8-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter8 =  0) then 
								visible8 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible9 = '0') then 
					  If ((SQ_X27-25 > SQ_X9-100)) AND ((SQ_X27+25) < (SQ_X9 +100)) AND (SQ_Y27 > SQ_Y9-100) AND ((SQ_Y27) < (SQ_Y9 +100))  THEN
							counter9<= counter9-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter9 =  0) then 
								visible9 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible10 = '0') then 
					  If ((SQ_X27-25 > SQ_X10-100)) AND ((SQ_X27+25) < (SQ_X10 +100)) AND (SQ_Y27 > SQ_Y10-100) AND ((SQ_Y27) < (SQ_Y10 +100))  THEN
							counter10<= counter10-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter10 =  0) then 
								visible10 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible11 = '0') then 
					  If ((SQ_X27-25 > SQ_X11-100)) AND ((SQ_X27+25) < (SQ_X11 +100)) AND (SQ_Y27 > SQ_Y11-100) AND ((SQ_Y27) < (SQ_Y11 +100))  THEN
							counter11<= counter11-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter11 =  0) then 
								visible11 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible12 = '0') then 
					  If ((SQ_X27-25 > SQ_X12-100)) AND ((SQ_X27+25) < (SQ_X12 +100)) AND (SQ_Y27 > SQ_Y12-100) AND ((SQ_Y27) < (SQ_Y12 +100))  THEN
							counter12<= counter12-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter12 =  0) then 
								visible12 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
					if(visible13 = '0') then 
					  If ((SQ_X27-25 > SQ_X13-100)) AND ((SQ_X27+25) < (SQ_X13 +100)) AND (SQ_Y27 > SQ_Y13-100) AND ((SQ_Y27) < (SQ_Y13 +100))  THEN
							counter13<= counter13-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter13 =  0) then 
								visible13 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
						
				
					if(visible14 = '0') then
						If ((SQ_X27-25 > SQ_X14-100)) AND ((SQ_X27+25) < (SQ_X14 +100)) AND (SQ_Y27 > SQ_Y14-100) AND ((SQ_Y27) < (SQ_Y14 +100)) THEN
							counter14<= counter14-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter14 =  0) then 
								visible14 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						 END IF;
						else
						
						end if;
						

				if(visible15 = '0') then 
					  If ((SQ_X27-25 > SQ_X15-100)) AND ((SQ_X27+25) < (SQ_X15 +100)) AND (SQ_Y27 > SQ_Y15-100) AND ((SQ_Y27) < (SQ_Y15 +100))  THEN
							counter15<= counter15-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter15 =  0) then 
								visible15 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;				
				if(visible16 = '0') then 
					  If ((SQ_X27-25 > SQ_X16-100)) AND ((SQ_X27+25) < (SQ_X16 +100)) AND (SQ_Y27 > SQ_Y16-100) AND ((SQ_Y27) < (SQ_Y16 +100))  THEN
							counter16<= counter16-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter1 =  0) then 
								visible16 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
				if(visible17= '0') then 
					  If ((SQ_X27-25 > SQ_X17-100)) AND ((SQ_X27+25) < (SQ_X17 +100)) AND (SQ_Y27 > SQ_Y17-100) AND ((SQ_Y27) < (SQ_Y17 +100))  THEN
							counter17 <= counter17 -1;
							pointsin <= pointsin + "11001";
							---points <= pointsin;
							if(counter17 =  0) then 
								visible17 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
				if(visible18 = '0') then 
					  If ((SQ_X27-25 > SQ_X18-100)) AND ((SQ_X27+25) < (SQ_X18 +100)) AND (SQ_Y27 > SQ_Y18-100) AND ((SQ_Y27) < (SQ_Y18 +100))  THEN
							counter18<= counter18-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter18 =  0) then 
								visible18 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;				
						if(visible19 = '0') then 
					  If ((SQ_X27-25 > SQ_X19-100)) AND ((SQ_X27+25) < (SQ_X19 +100)) AND (SQ_Y27 > SQ_Y19-100) AND ((SQ_Y27) < (SQ_Y19 +100))  THEN
							counter19<= counter19-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter19 =  0) then 
								visible19 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
						if(visible20 = '0') then 
					  If ((SQ_X27-25 > SQ_X20-100)) AND ((SQ_X27+25) < (SQ_X20 +100)) AND (SQ_Y27 > SQ_Y20-100) AND ((SQ_Y27) < (SQ_Y20 +100))  THEN
							counter20<= counter20-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter20 =  0) then 
								visible20 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;				
						if(visible21 = '0') then 
					  If ((SQ_X27-25 > SQ_X21-100)) AND ((SQ_X27+25) < (SQ_X21 +100)) AND (SQ_Y27 > SQ_Y21-100) AND ((SQ_Y27) < (SQ_Y21 +100))  THEN
							counter21<= counter21-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter21 =  0) then 
								visible21 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
						if(visible22 = '0') then 
					  If ((SQ_X27-25 > SQ_X22-100)) AND ((SQ_X27+25) < (SQ_X22 +100)) AND (SQ_Y27 > SQ_Y22-100) AND ((SQ_Y27) < (SQ_Y22+100))  THEN
							counter22<= counter22-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter22 =  0) then 
								visible22 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
						if(visible23 = '0') then 
					  If ((SQ_X27-25 > SQ_X23-100)) AND ((SQ_X27+25) < (SQ_X23 +100)) AND (SQ_Y27 > SQ_Y23-100) AND ((SQ_Y27) < (SQ_Y23 +100))  THEN
							counter23<= counter23-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter23 =  0) then 
								visible23 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
						if(visible24 = '0') then 
					  If ((SQ_X27-25 > SQ_X24-100)) AND ((SQ_X27+25) < (SQ_X24 +100)) AND (SQ_Y27 > SQ_Y24-100) AND ((SQ_Y27) < (SQ_Y24 +100))  THEN
							counter24<= counter24-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter24 =  0) then 
								visible24 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
						if(visible25 = '0') then 
					  If ((SQ_X27-25 > SQ_X25-100)) AND ((SQ_X27+25) < (SQ_X25 +100)) AND (SQ_Y27 > SQ_Y25-100) AND ((SQ_Y27) < (SQ_Y25 +100))  THEN
							counter25<= counter25-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter25 =  0) then 
								visible25 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;					
						if(visible26 = '0') then 
					  If ((SQ_X27-25 > SQ_X26-100)) AND ((SQ_X27+25) < (SQ_X26 +100)) AND (SQ_Y27 > SQ_Y26-100) AND ((SQ_Y27) < (SQ_Y26 +100))  THEN
							counter26<= counter26-1;
							pointsin <= pointsin + "11001";
							--points <= pointsin;
							if(counter26 =  0) then 
								visible26 <= '1';
								SQ_Y27<=OG_Y;
								hit<='1';
							else 
								
								SQ_Y27<=OG_Y;
								hit<='1';
							end if;
						END IF;
						else
						
						end if;
						-- state<=sFetch;

					else
						SQ_Y27<=SQ_Y27;
						state<=sFetch;
					
					end if;
					

when others=>

end case;
 END IF;
 
 points <= pointsin;
 
 END PROCESS;
 END MAIN;