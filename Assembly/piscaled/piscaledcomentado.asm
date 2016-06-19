#INCLUDE <P16F628A.INC>

#DEFINE   select_bank0  bcf STATUS,RP0
#define   select_bank1  bsf STATUS,RP0
#define   LED_PWR  PORTA,1
#define   LED_D1   PORTA,0
#define   LED_D2   PORTA,7
#define   BUTTON   PORTB,4
 
                org       0x00
                goto      setup              ;Perform the initial settings     ;
                
main            btfsc     BUTTON             ;Monitors the action of the button;
                goto      turn_on_d2         ;Turns on LED_D2                  ;
                goto      turn_on_d1         ;Turns on LED_D1                  ;
                
turn_on_d1      bcf       LED_D2             ;Turns off LED_D2                 ;
                bsf       LED_D1             ;Turns on LED_D1                  ;
                goto      main
                
turn_on_d2      bcf       LED_D1             ;Turns off LED_D1                 ;
                bsf       LED_D2             ;Turns on LED_D2                  ;
                goto      main
                
setup           select_bank1
                movlw     B'00000000'        ;Defines all pins of the PORTA    ;
                movwf     TRISA              ;registrator as output            ;
                
                movlw     B'00010000'        ;Defines all pins of the PORTB    ;
                movwf     TRISB              ;registrator as output except the ;
                                             ;the pin 4 - push button          ;
                
                bsf       PCON, OSCF         ;Sets 16F628 to operate at 4MHz   ;
                
                select_bank0
                movlw     0x07
                movwf     CMCON              ;Turns off the comparator         ;
                
                clrf      PORTA              ;Clears all pins of the PORTA     ;
                                             ;registrator                      ;
                
                clrf      PORTB              ;Clears all pins of the PORTB     ;
                                             ;registrator                      ;
                
                bsf       LED_PWR            ;Turns on LED_PWR - power LED     ;
 
 
                goto      main               ;Loop forever ;)                  ;
 
end

