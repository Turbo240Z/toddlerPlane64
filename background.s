
doBackground
drawCloud1 ; void ret2, ret1, char y, char x
    pla
    sta ret1+1
    pla
    sta ret1
    pla
    sta cloud1row
    pla
    sta cloud1col
    stx dc_retx
    sty dc_rety

    lda #40 ; chars per row
    pha
    lda cloud1row
    pha
    jsr eightBitMul ; results are in tmp1, tmp3
    lda tmp1        ; low byte result
    clc
    adc cloud1col   ; add the column to the row value
    sta zpPtr1
    lda tmp3        ; high byte result
    adc #0          ; carry over any from addition
    sta zpPtr1+1

    ; Add in screen memory location
    clc
    lda #<LVL_RAM
    adc zpPtr1
    sta zpPtr1
    lda #>LVL_RAM
    adc zpPtr1+1
    sta zpPtr1+1

    ldy #0
    lda #0
    sta (zpPtr1),y
    lda #1
    iny
    sta (zpPtr1),y
    lda #2
    iny
    sta (zpPtr1),y
    lda #3
    iny
    sta (zpPtr1),y
    ; Next row
    ldy #40
    lda #16
    sta (zpPtr1),y
    lda #17
    iny
    sta (zpPtr1),y
    lda #18
    iny
    sta (zpPtr1),y
    lda #19
    iny
    sta (zpPtr1),y
    ;jsr drawCloud2
    lda ret1
    pha
    lda ret1+1
    pha
    ldx dc_retx
    ldy dc_rety
    rts
ret1        .byte 0, 0
cloud1col   .byte 0    ; cloud1col/40 * 1000 + remainder
cloud1row   .byte 0
dc_retx     .byte 0
dc_rety     .byte 0

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
dbr_loop
    txa
    pha
;    jsr get_random_number ; get number under 25 by dividing by 2, 4 times gives us 0-15 number
;    lsr
;    lsr
;    lsr
;    lsr
    lda #0
    pha
    jsr drawCloud1
    txa
    clc
    adc #8
    tax
    cpx #40 ; Level column limit number?
    bcc dbr_loop; we're still less than the compare
    rts

copyLevelDataToScreen1
    ldx #0
cpldts_loop
    lda LVL_RAM, x
    sta SCREENMEM, x
    lda LVL_RAM   + $100, x
    sta SCREENMEM + $100, x
    lda LVL_RAM   + $200, x
    sta SCREENMEM + $200, x
;    lda LVL_RAM   + $300, x
;    sta SCREENMEM + $300, x
    inx
    bne cpldts_loop
    rts

copyLevelDataToScreen2
    ldx #0
cpldts2_loop
    lda LVL_RAM, x
    sta SCREENMEM2, x
    lda LVL_RAM   + $100, x
    sta SCREENMEM2 + $100, x
    lda LVL_RAM   + $200, x
    sta SCREENMEM2 + $200, x
;    lda LVL_RAM   + $300, x
;    sta SCREENMEM + $300, x
    inx
    bne cpldts2_loop
    rts


eightBitMul ; tmp1, tmp3 = (return_2, return_1, num1, num2) ; alter tmp1, tmp2, tmp4
    stx retx ; stash a copy of reg x
    pla
    sta ret2+1
    pla
    sta ret2
    pla
    sta tmp2
    pla
    sta tmp1
    lda #$00
    ldx #8
    lsr tmp1 ; FPL?
M1
    bcc M2
    clc
    adc tmp2 ; S?
M2
    ror
    ror tmp1 ; FPL?
    dex
    bne M1
    sta tmp3 ; high byte (PH)
    ; Copy return address back to stack
    lda ret2
    pha
    lda ret2+1
    pha
    ldx retx ; return x's value back
    rts ; and return
tmp1    .byte 0
tmp2    .byte 0
tmp3    .byte 0
retx    .byte 0
ret2    .byte 0, 0

get_random_number ; reg a ()
    lda $d012 ; load current screen raster value
    eor $dc04 ; xor against value in $dc04
    sbc $dc05 ; then subtract value in $dc05
    rts
