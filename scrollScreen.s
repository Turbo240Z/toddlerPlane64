; Assume that game level is 200 columns total
scrollScreen
    inc lvlColPos
    ldx lvlColPos
    ldy #0
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
    cmp #9 ; end char
    bne ss1_continueNormally
    lda #0
    sta lvlColPos
ss1_continueNormally
    inx
    iny
    cpy #40
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
    cpy #40
    beq ss1_finished
    jmp ss1_loop
ss1_finished
    rts

scrollIRQ
    inc screenCount
    lda screenCount
    cmp #LVL_CPY_PT1_FRAME
    bne si_notCpyFrame1
    jsr scrollScreen
si_notCpyFrame1
    
    lda screenCount
    cmp #SCROLL_SCREEN_FRAMES
    bne noScrollingForNow
    ; Do it

    lda #0
    sta screenCount ; reset counter
    lda %11111000
    and $d016
    ora %00000111
    sta $d016
    rts
noScrollingForNow
    dec $d016
    rts

screenCount .byte 0
