PROCESSOR 16F628A
#include <xc.inc>
; CONFIG
  CONFIG  FOSC = INTOSCIO       ; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = OFF           ; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
  CONFIG  BOREN = OFF           ; Brown-out Detect Enable bit (BOD disabled)
  CONFIG  LVP = OFF             ; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EE Memory Code Protection bit (Data memory code protection off)
  CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)

;******************************varibles***************************************** 
flag	equ 0x21
	
cout_1	equ 0x22
cout_2	equ 0x23
cout_3	equ 0x24
cout_4	equ 0x25

 
;********** macro **************************************************************
resta MACRO numero  ;el argumento va ser una literal en hexadecimal
 movlw	numero  ;carga el numero a w
 subwf	PORTA, 0   ;realizar la resta para la comparacion (numero - input)
endm

;************** inicio de codigo *********************************************** 
PSECT main, class=code, delta=2,abs
 
  bsf       STATUS, 5	    ; Cambia a banco 1 para configuración de registros
  bcf       STATUS, 6
  movlw     0b11111111	    ; Carga valor a w (todos entradas)
  movwf     TRISA           ; Puerto A como entradas
  movlw     0b00000000      ; Carga valor a w
  movwf     TRISB           ; Puerto B como salida solo 5 bits
  bcf       STATUS, 5       ; Cambia a banco 0 para operación normal de los port 
  movlw	    0x07	    ; 
  movwf	    CMCON	    ; habilita all pines (desabilita comparadores)
  
;************* inicializacion de variables *************************************

    
   

;************* bucle mian ******************************************************    
main:
    
    movlw 0x00		    ;reinicia bandera
    movwf flag
    
    resta   0x00              ; Realizar la resta
    btfss   STATUS, 2         ; Si Z = 1 (resultado cero), salta la sigiente intrucción
    goto    skip_0            ; Salta todo el bloque de call si el resultado fue cero
    call turn_right           ; Si no fue cero, ejecuta out_put
skip_0:                       ; Etiqueta de salto
    
    resta 0x01
    btfss   STATUS, 2
    goto    skip_1
    call turn_right
skip_1:
    
    resta 0x02
    btfss   STATUS, 2
    goto    skip_2
    call turn_right
skip_2:
    
    resta 0x03
    btfss   STATUS, 2
    goto    skip_3
    call turn_right
skip_3:
    
    resta 0x04
    btfss   STATUS, 2
    goto    skip_4
    call turn_right
skip_4:
    
    resta 0x05
    btfss   STATUS, 2
    goto    skip_5
    call turn_right
skip_5:
    
    resta 0x06
    btfss   STATUS, 2
    goto    skip_6
    call turn_right
skip_6:
    
    resta 0x07
    btfss   STATUS, 2
    goto    skip_7
    call turn_right
skip_7:
    
    resta 0x08
    btfss   STATUS, 2
    goto    skip_8
    call turn_right
skip_8:
    
    resta 0x09
    btfss   STATUS, 2
    goto    skip_9
    call turn_right
skip_9:
    
    btfsc   flag, 7
    goto    skip    ;goto salta a una etiqueta
    call turn_left  ;call llama a una subrutina
skip:
    
goto main


turn_right:
    movlw   0x00
    movwf   PORTB
    
    movlw   0x01
    movwf   PORTB
    call    Deley
    movlw   0x02
    movwf   PORTB
    call    Deley
    movlw   0x04
    movwf   PORTB
    call    Deley
    movlw   0x08
    movwf   PORTB
    call    Deley
    movlw   0x10
    movwf   PORTB
    call    Deley
    movlw   0x20
    movwf   PORTB
    call    Deley
    movlw   0x01
    movwf   PORTB
    call    Deley
    
    movlw   0x00
    movwf   PORTB
    
    movlw 
return    
    
turn_left:
    movlw   0x00
    movwf   PORTB
    
    movlw   0x01
    movwf   PORTB
    call    Deley
    movlw   0x20
    movwf   PORTB
    call    Deley
    movlw   0x10
    movwf   PORTB
    call    Deley
    movlw   0x08
    movwf   PORTB
    call    Deley
    movlw   0x04
    movwf   PORTB
    call    Deley
    movlw   0x02
    movwf   PORTB
    call    Deley
    movlw   0x01
    movwf   PORTB
    call    Deley
    
    movlw   0x00
    movwf   PORTB
    incf    flag,1
return    
    

Deley:
    movlw 0b10000000
return
    
END