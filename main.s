.org $0801
;.byte $0C,$08,$0A,$00,$9E,' ','2','0','6','4',$00,$00,$00,$00,$00

; -- Memory layout -- 
; $0400 - $07e8 screen memory     ; $D018 #%0001xxxx
; $0801 - $0bc3 main program
; $2000 - $2100 sprite memory
; $3000 - $3800 Custom Char RAM   ; $D018 #%00001100
; $3800 - $3BFF 2nd screen memory ; $D018 #%1110xxxx
; $8000 - $8f36 SID
; $9000 - $CFFF 16K FREE
; $D000 - $DFFF VIC/SID/CIA/IO registers/Color RAM
; $E000 - $FFFF 8K FREE


lda #COLOR_L_BLUE
sta SCREEN_BG_COLOR
;lda #COLOR_BLACK
sta SCREEN_BORDER
jsr setScreenMode
jsr ClearScreen ; set screen to white
jsr initDustySprite
jsr initIRQs
;jsr copyLevelDataToScreen1
;jsr copyLevelDataToScreen2

; For testing
lda #$09
sta $0400

mainLoop
    jmp mainLoop

setScreenBuff
    lda $D018
    and #%00001111
    ora screenBufMask
    sta $D018
    rts


; Dusty sprite data starts at $2000
initDustySprite
    lda #%00001111 ; enable first 4 sprites
    sta SPRITES_ENABLED
    lda #%00001010 ; Multi color 1 and 3
    sta SPRITES_MULTI_COLOR

    lda #COLOR_GREY
    sta SPRITES_SHARED_COLOR1
    lda #COLOR_L_GREY
    sta SPRITES_SHARED_COLOR2

    lda #COLOR_BLACK
    sta SPRITE2_COLOR
    sta SPRITE4_COLOR
    lda #COLOR_RED
    sta SPRITE1_COLOR
    sta SPRITE3_COLOR

    ldx #128
    stx $07f9 ; sprite 1 red single color
    stx $3BF9
    inx ; 129
    stx $07f8 ; sprite 2 black multi color
    stx $3BF8
    inx ; 130
    stx $07fb ; sprite 3 red single color
    stx $3BFB
    inx ; 131
    stx $07fa ; sprite 4 black multi color
    stx $3BFA

    lda #100
    sta SPRITE1_X_POS
    sta SPRITE1_Y_POS
    sta SPRITE2_X_POS
    sta SPRITE2_Y_POS
    sta SPRITE3_Y_POS
    sta SPRITE4_Y_POS
    lda #100+24
    sta SPRITE3_X_POS
    sta SPRITE4_X_POS
    ; For fun draw dusty behind clouds?
    lda #%00001111
    sta $D01B
    rts
dusty_x_pos .byte 100
dusty_y_pos .byte 100

setScreenMode
    lda $D018
    and #%00000001
    ora #%00001100 ; Set character set to $3000
    ora screenBufMask
    sta $D018
    rts
screenBufMask   .byte SCREEN_BUF1_MASK

clearScreen ; void ()
    ldx #0
clearing
;    lda #32
;    sta SCREENMEM, X
;    sta SCREENMEM + $100, x
;    sta SCREENMEM + $200, x
;    sta SCREENMEM + $300, x
;    sta SCREENMEM2, X
;    sta SCREENMEM2 + $100, x
;    sta SCREENMEM2 + $200, x
;    sta SCREENMEM2 + $300, x
    lda #COLOR_WHITE
    sta COLORMEM, X
    sta COLORMEM + $100, x
    sta COLORMEM + $200, x
    sta COLORMEM + $300, x
    inx
    bne clearing
    rts
