$BEFB:78

NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*--------------------------------------
			.INB /DEV/LINES.DHGR/DHGR.OFFSET.S
			.INB /DEV/LINES.DHGR/DHGR.MAIN.S
			.INB /DEV/LINES.DHGR/DHGR.AUX.S
            .INB /DEV/LINES.DHGR/MEM.S
			.INB /DEV/LINES.DHGR/DHGR.INIT.S
			.INB /DEV/LINES.DHGR/DHGR.PLOT.S
			.INB /DEV/LINES.DHGR/DHGR.CLR.S
*--------------------------------------
REF         .HS 00              ; ProDOS reference number
OBJMEMLOC   .EQ $0800
DATAMEMLOC  .EQ $8000
COLCNT      .EQ $09
*--------------------------------------
COLSWITCH   LDA COLCNT
            DEC
            BEQ .5
            JMP .6
.5          LDA #$0F
.6          STA COLCNT
            JSR SETDCOLOR
            RTS
*--------------------------------------
			.MA CORNER
			LDA ]3
			JSR SETDCOLOR

            LDX #$00
            LDY ]1
            JSR D2PLOT

            LDX #$8B
            LDY ]1
            JSR D2PLOT

            LDX #$00
            LDY ]2
            JSR D2PLOT

            LDX #$8B
            LDY ]2
            JSR D2PLOT
			.EM
*--------------------------------------
VLINE
            STX PTR
            LDA #$C0    ; 192 dans CPTY
            STA CPTY
.11         LDX PTR
            LDY CPTY
            DEY
            JSR D2PLOT
            DEC CPTY
            BNE .11
            RTS
*--------------------------------------
VERTLINE    LDA #$8C    ; 140 dans CPTX
            STA CPTX
            LDA #$0F
            STA COLCNT

.12         JSR COLSWITCH
            LDX CPTX
            DEX
            JSR VLINE
            DEC CPTX
            BNE .12
            RTS
*--------------------------------------
HLINE
            STY PTR
            LDA #$8C    ; 140 dans CPTX
            STA CPTX

.21         LDY PTR
            LDX CPTX
            DEX
            JSR D2PLOT
            DEC CPTX
            BNE .21
            RTS

*--------------------------------------
HORIZLINE   LDA #$C0    ; 192 dans CPTY
            STA CPTY
            LDA #$0F
            STA COLCNT

.22         JSR COLSWITCH
            LDY CPTY
            DEY
            JSR HLINE
            DEC CPTY
            BNE .22
            RTS
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
            JSR HORIZLINE

            BRK
*--------------------------------------
MAN
SAVE /DEV/LINES.DHGR/LINES.S

ASM
