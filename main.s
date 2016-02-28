.org $0801
;.byte $0C,$08,$0A,$00,$9E,' ','2','0','6','4',$00,$00,$00,$00,$00

; -- Memory layout -- 
; $0400 - $07e8 screen memory
; $0801 - $082a main program
; $2000 - $2100 sprite memory
; $3000 - $3800 Custom Character RAM

lda #COLOR_L_BLUE
sta SCREEN_BG_COLOR
lda #COLOR_MAGENTA
sta SCREEN_BORDER
jsr setScreenMode
jsr ClearScreen
jsr initDustySprite
jsr initIRQs
jsr doBackground
mainLoop
    jmp mainLoop


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
    inx ; 129
    stx $07f8 ; sprite 2 black multi color
    inx ; 130
    stx $07fb ; sprite 3 red single color
    inx ; 131
    stx $07fa ; sprite 4 black multi color

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
    rts
dusty_x_pos .byte 100
dusty_y_pos .byte 100

setScreenMode
    lda $D018
    and #%11110001
    ora #%00001100 ; Set to $3000
    sta $D018
    rts

clearScreen ; void ()
    ldx #$00
clearing
    lda #32
    STA SCREENMEM, X
    STA SCREENMEM + $100, x
    STA SCREENMEM + $200, x
    STA SCREENMEM + $300, x
    lda #COLOR_WHITE
    STA COLORMEM, X
    STA COLORMEM + $100, x
    STA COLORMEM + $200, x
    STA COLORMEM + $300, x
    inx
    bne clearing
    rts
