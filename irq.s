RASTER_TO_COUNT_AT .equ 250

initIRQs
    sei          ; turn off interrupts
    lda #$7f
    sta $dc0d  ; disable timer interrupts from CIA1
    sta $dd0d  ; and CIA2
    lda $dc0d  ; by reading this two registers we negate any pending CIA irqs.
    lda $dd0d  ; if we don't do this, a pending CIA irq might occur after we finish setting up our irq.
           ;we don't want that to happen.
    lda #$01   ;this is how to tell the VICII to generate a raster interrupt
    sta $d01a
    ; Configure ROM/RAM
    lda #$35   ;we turn off the BASIC and KERNAL rom here
    sta $01    ;the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of
           ;SID/VICII/etc are visible

    ; Set video mode
    lda #%00011011 ; screen on, 25 rows : this is default
    sta $d011
    lda #%00001000 ; 40 columns, single color mode
    sta $d016

    lda #RASTER_TO_COUNT_AT     ; line to trigger interrupt
    sta $d012

    lda #<irq_refreshCounter    ; low part of address of interrupt handler code
    sta $fffe
    lda #>irq_refreshCounter    ; high part of address of interrupt handler code
    sta $ffff
    cli          ; turn interrupts back on
    rts

irq_refreshCounter ; void (y, x, a)
    pha        ;store register A in stack
    txa
    pha        ;store register X in stack
    tya
    pha        ;store register Y in stack
    ;inc SCREEN_BORDER
    lda propBit
    and #%00000001
    beq setPropOff
    lda #SCREEN_BUF1_MASK
    sta screenBufMask
    lda #131 ; Prop on
    jmp setProp
setPropOff
    lda #SCREEN_BUF2_MASK
    sta screenBufMask
    lda #132 ; Prop off
setProp
    sta $07fa
    inc propBit
    ;jsr scrollIRQ
    jsr updateJoyPos
    jsr setScreenBuff
    asl $d019
    pla
    tay
    pla
    tax
    pla
    rti          ; return from interrupt
propBit .byte 0


