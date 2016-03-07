
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
