NEW
  
AUTO 4,1
            .OP	65C02
            .LIST OFF
*--------------------------------------
DBL_DRAW	.HS 00          ; Si = 01, on dessine sur les deux pages
*--------------------------------------
* Y -> param 1
			.MA FINDY
			LDX ]1
			LDA HTAB_LO,X		;Find the low byte of the row address
			STA SCRN_LO 
			LDA HTAB_HI,X 		;Find the high byte of the row address
			STA SCRN_HI
			.EM
*--------------------------------------
* Color number (00 - 15) dans A
SETDCOLOR	TAY
			LDA CLOM,Y 			;Lookup low byte of MAIN memory colour table
			STA ORMAIN+1		;Update the ORA instruction
			LDA CHIM,Y 			;Lookup high byte of MAIN memory colour table
			STA ORMAIN+2 		;Update the ORA instruction
			LDA CLOA,Y 			;Lookup low byte of AUX memory colour table
			STA ORAUX+1	 		;Update the ORA instruction
			LDA CHIA,Y 			;Lookup high byte of AUX memory colour table
			STA ORAUX+2 		;Update the ORA instruction
			RTS
*--------------------------------------
* X in X / Y in Y
D2PLOT		LDA HTAB_LO,Y		;Find the low byte of the row address
			STA SCRN_LO 
			LDA HTAB_HI,Y		;Find the high byte of the row address
			STA SCRN_HI

			LDY MBOFFSET,X		;Find what byte if any in MAIN we are working in
			BMI AUX				;If pixel has no bits in MAIN memory - go to aux routine
			STA PAGE2_OFF		;Map $2000 to MAIN memory
			LDA (SCRN_LO),Y		;Load screen data
			AND MAINAND,X		;Erase pixel bits
ORMAIN		ORA MAINGR,X		;Draw coloured bits
			STA (SCRN_LO),Y		;Write back to screen

AUX			LDY ABOFFSET,X 		;Find what byte if any in AUX we are working in
			BMI D2PLOTEND		;If no part of the pixel is in AUX - end the program
			STA PAGE2_ON		;Map $2000 to AUX memory
			LDA (SCRN_LO),Y		;Load screen data
			AND AUXAND,X		;Erase pixel bits
ORAUX		ORA AUXGR,X			;Draw coloured bits
			STA (SCRN_LO),Y		;Write back to screen
D2PLOTEND	RTS 
*--------------------------------------
MAN
SAVE /DEV/LINES.DHGR/DHGR.PLOT.S
LOAD /DEV/LINES.DHGR/LINES.S

ASM