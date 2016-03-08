JOY1                    .equ 56320 ; Joystick flag byte
JOY2                    .equ 56320
MOVE_REPEAT_TIME        .equ 0
JOY_BIT_UP              .equ 1
JOY_BIT_DOWN            .equ 2
JOY_BIT_LEFT            .equ 4
JOY_BIT_RIGHT           .equ 8
JOY_BIT_FIRE            .equ 16

LIMIT_Y_TOP             .equ 50
LIMIT_Y_BOTTOM          .equ 250 - 24
LIMIT_X_LEFT            .equ 23
LIMIT_X_RIGHT           .equ 200

moveDustyUp
    lda SPRITE1_Y_POS
    cmp #LIMIT_Y_TOP
    beq mdu_finished
    dec SPRITE1_Y_POS
    dec SPRITE2_Y_POS
    dec SPRITE3_Y_POS
    dec SPRITE4_Y_POS
mdu_finished
    lda SPRITE1_Y_POS
    cmp #SPRITE_Z_PRIORITY_Y
    bcs mdd_setZAboveUp
    lda $D01B
    ora #%00001111
    sta $D01B
    rts
mdd_setZAboveUp
    lda #%11110000
    and $D01B
    sta $D01B
    rts

moveDustyDown
    lda SPRITE1_Y_POS
    cmp #LIMIT_Y_BOTTOM
    beq mdd_finished
    inc SPRITE1_Y_POS
    inc SPRITE2_Y_POS
    inc SPRITE3_Y_POS
    inc SPRITE4_Y_POS
mdd_finished
    lda SPRITE1_Y_POS
    cmp #SPRITE_Z_PRIORITY_Y
    bcs mdd_setZAbove
    lda $D01B
    ora #%00001111
    sta $D01B
    rts
mdd_setZAbove
    lda #%11110000
    and $D01B
    sta $D01B
    rts

moveDustyRight
    lda SPRITE1_X_POS
    cmp #LIMIT_X_RIGHT
    beq mdr_finished
    inc SPRITE1_X_POS
    inc SPRITE2_X_POS
    inc SPRITE3_X_POS
    inc SPRITE4_X_POS
mdr_finished
    rts

moveDustyLeft
    lda SPRITE1_X_POS
    cmp #LIMIT_X_LEFT
    beq mdl_finished
    dec SPRITE1_X_POS
    dec SPRITE2_X_POS
    dec SPRITE3_X_POS
    dec SPRITE4_X_POS
mdl_finished
    rts

updateJoyPos
    ldx JOY2 ; cache JOY1 value in x
    ldy #0   ; for zeroing out
nextJoy1
    txa ; Cache joystick input values
    and #JOY_BIT_DOWN
    bne nextJoy2
    lda d_repeatTime
    cmp #MOVE_REPEAT_TIME
    bcc nextJoy2 ; Less than repeat time, do not move down yet
    sty d_repeatTime
    jsr moveDustyDown
nextJoy2 ; Left
    txa
    and #JOY_BIT_LEFT
    bne LeftNotPressed
    lda l_repeatTime
    cmp #MOVE_REPEAT_TIME
    bcc nextJoy3
    sty l_repeatTime ; Reset repeat time back to 0
    jsr moveDustyLeft
    jmp nextJoy3
LeftNotPressed
    lda #MOVE_REPEAT_TIME
    sta l_repeatTime

nextJoy3 ; Right
    txa
    and #JOY_BIT_RIGHT
    bne RightNotPressed
    lda r_repeatTime
    cmp #MOVE_REPEAT_TIME
    bcc nextJoy4
    sty r_repeatTime
    jsr moveDustyRight
    jmp nextJoy4
RightNotPressed
    lda #MOVE_REPEAT_TIME
    sta r_repeatTime ; allow the key to be pressed again immediately after being picked up
nextJoy4
    txa
    and #JOY_BIT_UP
    bne finishJoy
    lda u_repeatTime
    cmp #MOVE_REPEAT_TIME
    bcc finishJoy
    sty u_repeatTime
    jsr moveDustyUp
finishJoy
    rts

d_repeatTime    .byte MOVE_REPEAT_TIME
u_repeatTime    .byte MOVE_REPEAT_TIME
l_repeatTime    .byte MOVE_REPEAT_TIME
r_repeatTime    .byte MOVE_REPEAT_TIME
