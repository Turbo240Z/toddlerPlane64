paintColors1
    ldx #0
pc_loop
    ldy SCREENMEM+0, x
    lda COLOR_MAP, y
    sta COLORMEM+0, x
    ldy SCREENMEM+40, x
    lda COLOR_MAP, y
    sta COLORMEM+40, x
    ldy SCREENMEM+80, x
    lda COLOR_MAP, y
    sta COLORMEM+80, x
    ldy SCREENMEM+120, x
    lda COLOR_MAP, y
    sta COLORMEM+120, x
    ldy SCREENMEM+160, x
    lda COLOR_MAP, y
    sta COLORMEM+160, x
    ldy SCREENMEM+200, x
    lda COLOR_MAP, y
    sta COLORMEM+200, x
    ldy SCREENMEM+240, x
    lda COLOR_MAP, y
    sta COLORMEM+240, x
    ldy SCREENMEM+280, x
    lda COLOR_MAP, y
    sta COLORMEM+280, x
    ldy SCREENMEM+320, x
    lda COLOR_MAP, y
    sta COLORMEM+320, x
    ldy SCREENMEM+360, x
    lda COLOR_MAP, y
    sta COLORMEM+360, x
    ldy SCREENMEM+400, x
    lda COLOR_MAP, y
    sta COLORMEM+400, x
    ldy SCREENMEM+440, x
    lda COLOR_MAP, y
    sta COLORMEM+440, x
    ldy SCREENMEM+480, x
    lda COLOR_MAP, y
    sta COLORMEM+480, x
    inx
    cpx #COLS_TO_COPY
    beq pc_finished
    jmp pc_loop
pc_finished
    rts

paintColors2
    ldx #0
pc2_loop
    ldy SCREENMEM+520, x
    lda COLOR_MAP, y
    sta COLORMEM+520, x
    ldy SCREENMEM+560, x
    lda COLOR_MAP, y
    sta COLORMEM+560, x
    ldy SCREENMEM+600, x
    lda COLOR_MAP, y
    sta COLORMEM+600, x
    ldy SCREENMEM+640, x
    lda COLOR_MAP, y
    sta COLORMEM+640, x
    ldy SCREENMEM+680, x
    lda COLOR_MAP, y
    sta COLORMEM+680, x
    ldy SCREENMEM+720, x
    lda COLOR_MAP, y
    sta COLORMEM+720, x
    ldy SCREENMEM+760, x
    lda COLOR_MAP, y
    sta COLORMEM+760, x
    ldy SCREENMEM+800, x
    lda COLOR_MAP, y
    sta COLORMEM+800, x
    ldy SCREENMEM+840, x
    lda COLOR_MAP, y
    sta COLORMEM+840, x
    ldy SCREENMEM+880, x
    lda COLOR_MAP, y
    sta COLORMEM+880, x
    ldy SCREENMEM+920, x
    lda COLOR_MAP, y
    sta COLORMEM+920, x
    ldy SCREENMEM+960, x
    lda COLOR_MAP, y
    sta COLORMEM+960, x
    inx
    cpx #COLS_TO_COPY
    beq pc2_finished
    jmp pc2_loop
pc2_finished
    rts

paintColors1Buff2
    ldx #0
pcb2_loop
    ldy SCREENMEM2+0, x
    lda COLOR_MAP, y
    sta COLORMEM+0, x
    ldy SCREENMEM2+40, x
    lda COLOR_MAP, y
    sta COLORMEM+40, x
    ldy SCREENMEM2+80, x
    lda COLOR_MAP, y
    sta COLORMEM+80, x
    ldy SCREENMEM2+120, x
    lda COLOR_MAP, y
    sta COLORMEM+120, x
    ldy SCREENMEM2+160, x
    lda COLOR_MAP, y
    sta COLORMEM+160, x
    ldy SCREENMEM2+200, x
    lda COLOR_MAP, y
    sta COLORMEM+200, x
    ldy SCREENMEM2+240, x
    lda COLOR_MAP, y
    sta COLORMEM+240, x
    ldy SCREENMEM2+280, x
    lda COLOR_MAP, y
    sta COLORMEM+280, x
    ldy SCREENMEM2+320, x
    lda COLOR_MAP, y
    sta COLORMEM+320, x
    ldy SCREENMEM2+360, x
    lda COLOR_MAP, y
    sta COLORMEM+360, x
    ldy SCREENMEM2+400, x
    lda COLOR_MAP, y
    sta COLORMEM+400, x
    ldy SCREENMEM2+440, x
    lda COLOR_MAP, y
    sta COLORMEM+440, x
    ldy SCREENMEM2+480, x
    lda COLOR_MAP, y
    sta COLORMEM+480, x
    inx
    cpx #COLS_TO_COPY
    beq pcb2_finished
    jmp pcb2_loop
pcb2_finished
    rts


paintColors2Buff2
    ldx #0
pc2b2_loop
    ldy SCREENMEM2+520, x
    lda COLOR_MAP, y
    sta COLORMEM+520, x
    ldy SCREENMEM2+560, x
    lda COLOR_MAP, y
    sta COLORMEM+560, x
    ldy SCREENMEM2+600, x
    lda COLOR_MAP, y
    sta COLORMEM+600, x
    ldy SCREENMEM2+640, x
    lda COLOR_MAP, y
    sta COLORMEM+640, x
    ldy SCREENMEM2+680, x
    lda COLOR_MAP, y
    sta COLORMEM+680, x
    ldy SCREENMEM2+720, x
    lda COLOR_MAP, y
    sta COLORMEM+720, x
    ldy SCREENMEM2+760, x
    lda COLOR_MAP, y
    sta COLORMEM+760, x
    ldy SCREENMEM2+800, x
    lda COLOR_MAP, y
    sta COLORMEM+800, x
    ldy SCREENMEM2+840, x
    lda COLOR_MAP, y
    sta COLORMEM+840, x
    ldy SCREENMEM2+880, x
    lda COLOR_MAP, y
    sta COLORMEM+880, x
    ldy SCREENMEM2+920, x
    lda COLOR_MAP, y
    sta COLORMEM+920, x
    ldy SCREENMEM2+960, x
    lda COLOR_MAP, y
    sta COLORMEM+960, x
    inx
    cpx #COLS_TO_COPY
    beq pc2b2_finished
    jmp pc2b2_loop
pc2b2_finished
    rts


doColor1
    lda screenBuffUsed
    beq dc_readFromBuff1
    jsr paintColors1
    rts
dc_readFromBuff1
    jsr paintColors1Buff2
    rts

doColor2
    lda screenBuffUsed
    beq dc2_readFromBuff1
    jsr paintColors2
    rts
dc2_readFromBuff1
    jsr paintColors2Buff2
    rts



