scrollScreen
    ldx #0
ss_loop
    lda SCREENMEM+1, x
    sta SCREENMEM, x

    lda SCREENMEM+1+40, x
    sta SCREENMEM+40, x

    lda SCREENMEM+1+80, x
    sta SCREENMEM+80, x

    lda SCREENMEM+1+120, x
    sta SCREENMEM+120, x

    lda SCREENMEM+1+160, x
    sta SCREENMEM+160, x

    lda SCREENMEM+1+200, x
    sta SCREENMEM+200, x

    lda SCREENMEM+1+240, x
    sta SCREENMEM+240, x

    lda SCREENMEM+1+280, x
    sta SCREENMEM+280, x

    lda SCREENMEM+1+320, x
    sta SCREENMEM+320, x

    lda SCREENMEM+1+360, x
    sta SCREENMEM+360, x

    lda SCREENMEM+1+400, x
    sta SCREENMEM+400, x

    lda SCREENMEM+1+440, x
    sta SCREENMEM+440, x

    inx
    cpx #40
    bne ss_loop
    rts

scrollIRQ
    inc screenCount
    lda screenCount
    cmp #SCROLL_SCREEN_FRAMES
    bne noScrollingForNow
    ; Do it
    jsr scrollScreen
    lda #0
    sta screenCount ; reset counter
noScrollingForNow
    rts

screenCount .byte 0
