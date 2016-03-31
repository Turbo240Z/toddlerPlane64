; Assume that game level is 200 columns total
scrollScreen
    ldy #0
    inc lvlColPos
    ldx lvlColPos
    cpx #LVL_COLUMNS+1
    bne ss1_loop
    ldx #0
    stx lvlColPos
ss1_loop
    lda LVL_RAM+0, x
    sta SCREENMEM+0, y
    lda LVL_RAM+200, x
    sta SCREENMEM+40, y
    lda LVL_RAM+400, x
    sta SCREENMEM+80, y
    lda LVL_RAM+600, x
    sta SCREENMEM+120, y
    lda LVL_RAM+800, x
    sta SCREENMEM+160, y
    lda LVL_RAM+1000, x
    sta SCREENMEM+200, y
    lda LVL_RAM+1200, x
    sta SCREENMEM+240, y
    lda LVL_RAM+1400, x
    sta SCREENMEM+280, y
    lda LVL_RAM+1600, x
    sta SCREENMEM+320, y
    lda LVL_RAM+1800, x
    sta SCREENMEM+360, y
    lda LVL_RAM+2000, x
    sta SCREENMEM+400, y
    lda LVL_RAM+2200, x
    sta SCREENMEM+440, y
    lda LVL_RAM+2400, x
    sta SCREENMEM+480, y
    inx
    iny
    cpy #COLS_TO_COPY
    beq ss1_finished
    jmp ss1_loop
ss1_finished
    rts
lvlColPos   .byte 0

scrollScreen2
    ldx lvlColPos
    ldy #0
ss2_loop
    lda LVL_RAM+2600, x
    sta SCREENMEM+520, y
    lda LVL_RAM+2800, x
    sta SCREENMEM+560, y
    lda LVL_RAM+3000, x
    sta SCREENMEM+600, y
    lda LVL_RAM+3200, x
    sta SCREENMEM+640, y
    lda LVL_RAM+3400, x
    sta SCREENMEM+680, y
    lda LVL_RAM+3600, x
    sta SCREENMEM+720, y
    lda LVL_RAM+3800, x
    sta SCREENMEM+760, y
    lda LVL_RAM+4000, x
    sta SCREENMEM+800, y
    lda LVL_RAM+4200, x
    sta SCREENMEM+840, y
    lda LVL_RAM+4400, x
    sta SCREENMEM+880, y
    lda LVL_RAM+4600, x
    sta SCREENMEM+920, y
    lda LVL_RAM+4800, x
    sta SCREENMEM+960, y
    inx
    iny
    cpy #COLS_TO_COPY
    beq ss2_finished
    jmp ss2_loop
ss2_finished
    rts



scrollScreenBuff2
    inc lvlColPos
    ldx lvlColPos
    ldy #0
    cpx #LVL_COLUMNS+1
    bne ss1b2_loop
    ldx #0
    stx lvlColPos
ss1b2_loop
    lda LVL_RAM+0, x
    sta SCREENMEM2+0, y
    lda LVL_RAM+200, x
    sta SCREENMEM2+40, y
    lda LVL_RAM+400, x
    sta SCREENMEM2+80, y
    lda LVL_RAM+600, x
    sta SCREENMEM2+120, y
    lda LVL_RAM+800, x
    sta SCREENMEM2+160, y
    lda LVL_RAM+1000, x
    sta SCREENMEM2+200, y
    lda LVL_RAM+1200, x
    sta SCREENMEM2+240, y
    lda LVL_RAM+1400, x
    sta SCREENMEM2+280, y
    lda LVL_RAM+1600, x
    sta SCREENMEM2+320, y
    lda LVL_RAM+1800, x
    sta SCREENMEM2+360, y
    lda LVL_RAM+2000, x
    sta SCREENMEM2+400, y
    lda LVL_RAM+2200, x
    sta SCREENMEM2+440, y
    lda LVL_RAM+2400, x
    sta SCREENMEM2+480, y
    inx
    iny
    cpy #COLS_TO_COPY
    beq ss1b2_finished
    jmp ss1b2_loop
ss1b2_finished
    rts


scrollScreen2Buff2
    ldx lvlColPos
    ldy #0
ss2b2_loop
    lda LVL_RAM+2600, x
    sta SCREENMEM2+520, y
    lda LVL_RAM+2800, x
    sta SCREENMEM2+560, y
    lda LVL_RAM+3000, x
    sta SCREENMEM2+600, y
    lda LVL_RAM+3200, x
    sta SCREENMEM2+640, y
    lda LVL_RAM+3400, x
    sta SCREENMEM2+680, y
    lda LVL_RAM+3600, x
    sta SCREENMEM2+720, y
    lda LVL_RAM+3800, x
    sta SCREENMEM2+760, y
    lda LVL_RAM+4000, x
    sta SCREENMEM2+800, y
    lda LVL_RAM+4200, x
    sta SCREENMEM2+840, y
    lda LVL_RAM+4400, x
    sta SCREENMEM2+880, y
    lda LVL_RAM+4600, x
    sta SCREENMEM2+920, y
    lda LVL_RAM+4800, x
    sta SCREENMEM2+960, y
    inx
    iny
    cpy #COLS_TO_COPY
    beq ss2b2_finished
    jmp ss2b2_loop
ss2b2_finished
    rts


scrollIRQ
    inc screenCount
    lda screenCount
    cmp #LVL_CPY_PT1_FRAME
    bne si_notCpyFrame1
    lda screenBuffUsed
    bne si_notScreen1Buff
    jsr scrollScreen      ; Part one of buff 1
    jmp si_screenScrolled
si_notScreen1Buff
    jsr scrollScreenBuff2 ; Part one of buff 2
si_screenScrolled
    lda $D016
    ora #%00000111 ; Reset scroll
    sta $D016
    jsr setScreenBuff     ; Flip the Screen Buff value
    jsr doColor1
si_notCpyFrame1
    lda screenCount
    cmp #SCROLL_SCREEN_FRAMES
    bne noScrollingForNow
    ; Do it
    lda #0
    sta screenCount ; reset counter
    rts
noScrollingForNow
    lda screenCount
    cmp #H_SCROLL_1_FRAME
    bne si_noH1
    dec $d016
    lda screenBuffUsed
    bne si_notScreen1Buff2nd
    jsr scrollScreen2      ; Part two of buff 1
    jmp si_screenScrolled2nd
si_notScreen1Buff2nd
    jsr scrollScreen2Buff2 ; Part two of buff 2
si_screenScrolled2nd
    ; Flip screenBuffUsed Value
    lda screenBuffUsed
    bne si_resetScreenBuffToScreen1 ; Greater than 0
    inc screenBuffUsed
    lda #SCREEN_BUF1_MASK
    jmp si_screenBuffSet
si_resetScreenBuffToScreen1
    lda #0
    sta screenBuffUsed
    lda #SCREEN_BUF2_MASK
si_screenBuffSet
    sta screenBufMask

si_noH1
    lda screenCount
    cmp #H_SCROLL_2_FRAME
    bne si_noH2
    dec $d016
si_noH2
    lda screenCount
    cmp #H_SCROLL_3_FRAME
    bne si_noH3
    dec $d016
si_noH3
    lda screenCount
    cmp #H_SCROLL_4_FRAME
    bne si_noH4
    dec $d016
si_noH4
    lda screenCount
    cmp #H_SCROLL_5_FRAME
    bne si_noH5
    dec $d016
si_noH5
    lda screenCount
    cmp #H_SCROLL_6_FRAME
    bne si_noH6
    dec $d016
si_noH6
    lda screenCount
    cmp #H_SCROLL_7_FRAME
    bne si_noH7
    dec $d016
si_noH7
    lda screenCount
    cmp #DO_COLOR_2_FRAME
    bne si_finished
    jsr doColor2
si_finished
    rts

screenCount     .byte 0
screenBuffUsed  .byte 0 ; 0 = SCREEN1, 1 = SCREEN2



printScrollNumber
    lda $d016
    and #%00000111
    clc
    adc #25 ; 0 = 25
    sta SCREENMEM+2 ; write to screen
    rts



