
doBackground
drawCloud1
    lda #0
    sta SCREENMEM
    lda #1
    sta SCREENMEM+1
    lda #2
    sta SCREENMEM+2
    lda #3
    sta SCREENMEM+3
    lda #16
    sta SCREENMEM+40
    lda #17
    sta SCREENMEM+41
    lda #18
    sta SCREENMEM+42
    lda #19
    sta SCREENMEM+43
    jsr drawCloud2
    rts

drawCloud2
    lda #4
    sta SCREENMEM+410
    lda #5
    sta SCREENMEM+411
    lda #6
    sta SCREENMEM+412
    lda #7
    sta SCREENMEM+413
    lda #20
    sta SCREENMEM+450
    lda #21
    sta SCREENMEM+451
    lda #22
    sta SCREENMEM+452
    lda #23
    sta SCREENMEM+453
    rts


doBackgroundRand
    ldx #0
    ldy #0
    lda #<SCREENMEM
    sta db_loop1+2
    lda #>SCREENMEM
    sta db_loop1+3
db_loop1
    txa
    sta SCREENMEM, x
    inx
    cpx #40
    bne db_loop1 ; draw row
    iny
    ldx #0
    clc
    lda db_loop1+2
    adc #40
    sta db_loop1+2
    lda db_loop1+3
    adc #0
    sta db_loop1+3
    cpy #24
    bne db_loop1
    rts
    