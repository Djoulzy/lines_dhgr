$BEFB:78

NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*--------------------------------------
			.INB /DEV/LINES.DHGR/DHGR.OFFSET.S
			.INB /DEV/LINES.DHGR/DHGR.TABLES.S
            .INB /DEV/LINES.DHGR/MEM.S
			.INB /DEV/LINES.DHGR/DHGR.INIT.S
			.INB /DEV/LINES.DHGR/DHGR.PLOT.S
			.INB /DEV/LINES.DHGR/DHGR.CLR.S
			.INB /DEV/LINES.DHGR/DHGR.LINES.S
*--------------------------------------
REF         .HS 00              ; ProDOS reference number
OBJMEMLOC   .EQ $0800
DATAMEMLOC  .EQ $8000
*--------------------------------------
RUN
            >GODHGR2
			LDA #$00
            JSR DHGR2_CLR
            STA STORE80_OFF
            STA PAGE2_OFF
            STA RAMRD_OFF
            STA RAMWRT_OFF

			LDA #$00			; Ecriture Page 1
            STA DBL_DRAW
			STA $E6

            STA STORE80_ON
            STA PAGE2_OFF
            STA RAMRD_OFF
            STA RAMWRT_OFF

*            >CORNER #$00,#$BF,#$01
*            >CORNER #$01,#$BE,#$02
*            >CORNER #$02,#$BD,#$03
*            >CORNER #$03,#$BC,#$01

            JSR VERTLINE
*            JSR HORIZLINE

            LDX #$09
            LDA XMOD7,X
            TAX
            LDA MAINMG,X
            BRK
*--------------------------------------
MAN
SAVE /DEV/LINES.DHGR/LINES.S

ASM
