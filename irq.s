RASTER_TO_START_FLOOR   .equ 180
RASTER_FOR_SIDEWALK     .equ 215
RASTER_BACK_TO_GREEN    .equ 225
RASTER_TO_COUNT_AT      .equ 251


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
    lda #%00001000 ; 40 columns, single color mode, alighed to the right
    lda #%11110111 ; 38 columns, single color mode, aligned right
    sta $d016

    lda #RASTER_TO_START_FLOOR   ; line to trigger interrupt
    sta $d012

    lda #<irq_flooring    ; low part of address of interrupt handler code
    sta $fffe
    lda #>irq_flooring    ; high part of address of interrupt handler code
    sta $ffff
    cli          ; turn interrupts back on
    rts



    

irq_refreshCounter ; void (y, x, a)
    pha        ;store register A in stack
    txa
    pha        ;store register X in stack
    tya
    pha        ;store register Y in stack
    lda #COLOR_CYAN
    sta SCREEN_BG_COLOR
    lda propBit
    and #%00000001
    beq setPropOff
    lda #131 ; Prop on
    jmp setProp
setPropOff
    lda #132 ; Prop off
setProp
    sta $07fa
    inc propBit
    jsr scrollIRQ
    jsr updateJoyPos
    inc d_repeatTime
    inc u_repeatTime
    inc l_repeatTime
    inc r_repeatTime
    lda #RASTER_TO_START_FLOOR     ; line to trigger interrupt
    sta $d012
    lda #<irq_flooring    ; low part of address of interrupt handler code
    sta $fffe
    lda #>irq_flooring    ; high part of address of interrupt handler code
    sta $ffff
    asl $d019
    pla
    tay
    pla
    tax
    pla
    rti          ; return from interrupt
propBit     .byte 0

; painting some green flooring
irq_flooring
    pha        ;store register A in stack
    txa
    pha        ;store register X in stack
    tya
    pha        ;store register Y in stack
    ldx #COLOR_L_GREEN
if_loop
    lda $d012
    cmp #RASTER_TO_START_FLOOR+1
    bne if_loop
    stx SCREEN_BG_COLOR
    lda #RASTER_FOR_SIDEWALK      ; line to trigger interrupt
    sta $d012
    lda #<irq_sideWalk ; next
    sta $fffe
    lda #>irq_sideWalk ; next
    sta $ffff
    asl $d019
    pla
    tay
    pla
    tax
    pla
    rti          ; return from interrupt

irq_sideWalk
    pha        ;store register A in stack
    txa
    pha        ;store register X in stack
    tya
    pha        ;store register Y in stack
    ldx #COLOR_L_GREY
isw_loop
    lda $d012
    cmp #RASTER_FOR_SIDEWALK+1
    bne isw_loop
    stx SCREEN_BG_COLOR
    lda #RASTER_BACK_TO_GREEN      ; line to trigger interrupt
    sta $d012
    lda #<irq_backToGreen ; next
    sta $fffe
    lda #>irq_backToGreen ; next
    sta $ffff
    asl $d019
    pla
    tay
    pla
    tax
    pla
    rti          ; return from interrupt

irq_backToGreen
    pha        ;store register A in stack
    txa
    pha        ;store register X in stack
    tya
    pha        ;store register Y in stack
    ldx #COLOR_L_GREEN
ibtg_loop
    lda $d012
    cmp #RASTER_BACK_TO_GREEN+1
    bne ibtg_loop
    stx SCREEN_BG_COLOR
    lda #RASTER_TO_COUNT_AT      ; line to trigger interrupt
    sta $d012
    lda #<irq_refreshCounter ; next
    sta $fffe
    lda #>irq_refreshCounter ; next
    sta $ffff
    asl $d019
    pla
    tay
    pla
    tax
    pla
    rti          ; return from interrupt

