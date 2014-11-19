        sei             ;disable interrupts

        lda #$00        ;load $00 into A
        sta $d011       ;turn off screen
        sta $d020       ;make border black

main    ldy #$7a        ;load $7a into Y. this is the line where the raster bar will start
        ldx #$00        ;load $00 into X
loop    lda colors,x    ;load value at label 'colors' plus x into A

wait    cpy $d012       ;compare current value in Y with the current rasterposition
        bne wait        ;is the value in Y not equal to the current position? then jump back to cpy

        sta $d020       ;if equal: store current value of A into the bordercolor

        cpx #51         ;compare X to #51(decimal). have we had all lines of our bar yet?
        beq main        ;branch if equal - if yes, jump to main

        inx             ;increase X to read the next color
        iny             ;increase Y to go to the next rasterline

        jmp loop        ;jump to loop

colors  !byte $06,$06,$06,$0e,$06,$0e
        !byte $0e,$06,$0e,$0e,$0e,$03
        !byte $0e,$03,$03,$0e,$03,$03
        !byte $03,$01,$03,$01,$01,$03
        !byte $01,$01,$01,$03,$01,$01
        !byte $03,$01,$03,$03,$03,$0e
        !byte $03,$03,$0e,$03,$0e,$0e
        !byte $0e,$06,$0e,$0e,$06,$0e
        !byte $06,$06,$06,$00,$00,$00

        !byte $ff
