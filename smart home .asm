
_new_line:

;smart home .c,11 :: 		void new_line() {
;smart home .c,12 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;smart home .c,13 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;smart home .c,14 :: 		}
L_end_new_line:
	RETURN
; end of _new_line

_clear_receive:

;smart home .c,16 :: 		void clear_receive() {
;smart home .c,17 :: 		for (x = 0; x < 5; x++) {
	CLRF       _x+0
L_clear_receive0:
	MOVLW      5
	SUBWF      _x+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_clear_receive1
;smart home .c,18 :: 		receive[x] = 0;
	MOVF       _x+0, 0
	ADDLW      _receive+0
	MOVWF      FSR
	CLRF       INDF+0
;smart home .c,17 :: 		for (x = 0; x < 5; x++) {
	INCF       _x+0, 1
;smart home .c,19 :: 		}
	GOTO       L_clear_receive0
L_clear_receive1:
;smart home .c,20 :: 		}
L_end_clear_receive:
	RETURN
; end of _clear_receive

_main:

;smart home .c,22 :: 		void main() {
;smart home .c,26 :: 		TRISD = 0;
	CLRF       TRISD+0
;smart home .c,27 :: 		trisb=0b11111111;
	MOVLW      255
	MOVWF      TRISB+0
;smart home .c,28 :: 		portb=0;
	CLRF       PORTB+0
;smart home .c,29 :: 		PORTD = 0;
	CLRF       PORTD+0
;smart home .c,30 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;smart home .c,31 :: 		UART1_Write_Text("WELCOME\n\r");
	MOVLW      ?lstr1_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;smart home .c,32 :: 		UART1_Write_Text("Please Enter The Password\n\r");
	MOVLW      ?lstr2_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;smart home .c,34 :: 		for (;;) {
L_main3:
;smart home .c,35 :: 		adc_value = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;smart home .c,36 :: 		Volt = (adc_value * 5) / 1023.0;
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
;smart home .c,37 :: 		TempC = Volt * 100.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
;smart home .c,38 :: 		FloatToStr(TempC, TempC_text);
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      main_TempC_text_L0+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;smart home .c,39 :: 		UART1_Write_Text("Current Temp = ");
	MOVLW      ?lstr3_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;smart home .c,40 :: 		UART1_Write_Text(TempC_text);
	MOVLW      main_TempC_text_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;smart home .c,41 :: 		UART1_Write_Text(" C"); // send temperature value to PC
	MOVLW      ?lstr4_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;smart home .c,44 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;smart home .c,45 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;smart home .c,46 :: 		Delay_ms(500); // wait 0.5 Second
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;smart home .c,49 :: 		if (UART1_Data_Ready() == 1) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;smart home .c,50 :: 		receive[i] = UART1_Read();
	MOVF       _i+0, 0
	ADDLW      _receive+0
	MOVWF      FLOC__main+0
	CALL       _UART1_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;smart home .c,51 :: 		if (receive[i] == '/') {
	MOVF       _i+0, 0
	ADDLW      _receive+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;smart home .c,52 :: 		new_line();
	CALL       _new_line+0
;smart home .c,53 :: 		UART1_Write_Text("Please Enter The Password\n\r");
	MOVLW      ?lstr5_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;smart home .c,54 :: 		i = 0;
	CLRF       _i+0
;smart home .c,55 :: 		clear_receive();
	CALL       _clear_receive+0
;smart home .c,56 :: 		} else {
	GOTO       L_main9
L_main8:
;smart home .c,57 :: 		UART1_Write('*');
	MOVLW      42
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;smart home .c,58 :: 		i++;
	INCF       _i+0, 1
;smart home .c,59 :: 		if (i == 5) {
	MOVF       _i+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;smart home .c,60 :: 		new_line();
	CALL       _new_line+0
;smart home .c,61 :: 		if (receive[0] == 'm' && receive[1] == 'o' && receive[2] == 't' && receive[3] == 'o' && receive[4] == 'r') {
	MOVF       _receive+0, 0
	XORLW      109
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVF       _receive+1, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVF       _receive+2, 0
	XORLW      116
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVF       _receive+3, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVF       _receive+4, 0
	XORLW      114
	BTFSS      STATUS+0, 2
	GOTO       L_main13
L__main34:
;smart home .c,62 :: 		Motor = ~Motor;
	MOVLW      1
	XORWF      PORTD+0, 1
;smart home .c,63 :: 		if (Motor == 0) UART1_Write_Text("door is closed\n\r");
	BTFSC      PORTD+0, 0
	GOTO       L_main14
	MOVLW      ?lstr6_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	GOTO       L_main15
L_main14:
;smart home .c,64 :: 		else UART1_Write_Text("door is  Ooen\n\r");
	MOVLW      ?lstr7_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
L_main15:
;smart home .c,65 :: 		i = 0;
	CLRF       _i+0
;smart home .c,66 :: 		clear_receive();
	CALL       _clear_receive+0
;smart home .c,67 :: 		}
	GOTO       L_main16
L_main13:
;smart home .c,69 :: 		else if (receive[0] == 'l' && receive[1] == 'a' && receive[2] == 'm' && receive[3] == 'p' && receive[4] == '1') {
	MOVF       _receive+0, 0
	XORLW      108
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	MOVF       _receive+1, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	MOVF       _receive+2, 0
	XORLW      109
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	MOVF       _receive+3, 0
	XORLW      112
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	MOVF       _receive+4, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main19
L__main33:
;smart home .c,70 :: 		Lamp = ~Lamp;
	MOVLW      2
	XORWF      PORTD+0, 1
;smart home .c,71 :: 		if (Lamp == 0) UART1_Write_Text("Lamp Turns OFF\n\r");
	BTFSC      PORTD+0, 1
	GOTO       L_main20
	MOVLW      ?lstr8_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	GOTO       L_main21
L_main20:
;smart home .c,72 :: 		else UART1_Write_Text("Lamp Turns ON\n\r");
	MOVLW      ?lstr9_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
L_main21:
;smart home .c,73 :: 		i = 0;
	CLRF       _i+0
;smart home .c,74 :: 		clear_receive();
	CALL       _clear_receive+0
;smart home .c,75 :: 		}
	GOTO       L_main22
L_main19:
;smart home .c,77 :: 		else if (receive[0] == 'b' && receive[1] == 'u' && receive[2] == 'z' && receive[3] == 'z' && receive[4] == '1') {
	MOVF       _receive+0, 0
	XORLW      98
	BTFSS      STATUS+0, 2
	GOTO       L_main25
	MOVF       _receive+1, 0
	XORLW      117
	BTFSS      STATUS+0, 2
	GOTO       L_main25
	MOVF       _receive+2, 0
	XORLW      122
	BTFSS      STATUS+0, 2
	GOTO       L_main25
	MOVF       _receive+3, 0
	XORLW      122
	BTFSS      STATUS+0, 2
	GOTO       L_main25
	MOVF       _receive+4, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main25
L__main32:
;smart home .c,78 :: 		Buzzer = ~Buzzer;
	MOVLW      4
	XORWF      PORTD+0, 1
;smart home .c,79 :: 		if (Buzzer == 0) UART1_Write_Text("Buzzer Turns OFF\n\r");
	BTFSC      PORTD+0, 2
	GOTO       L_main26
	MOVLW      ?lstr10_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	GOTO       L_main27
L_main26:
;smart home .c,80 :: 		else UART1_Write_Text("Buzzer Turns ON\n\r");
	MOVLW      ?lstr11_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
L_main27:
;smart home .c,81 :: 		i = 0;
	CLRF       _i+0
;smart home .c,82 :: 		clear_receive();
	CALL       _clear_receive+0
;smart home .c,83 :: 		} else {
	GOTO       L_main28
L_main25:
;smart home .c,84 :: 		unsigned short z = 0;
	CLRF       main_z_L5+0
;smart home .c,85 :: 		for (z = 0; z <= 3; z++) {
	CLRF       main_z_L5+0
L_main29:
	MOVF       main_z_L5+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_main30
;smart home .c,86 :: 		UART1_Write_Text("Please Enter The Correct Password\n\r");
	MOVLW      ?lstr12_smart_32home_32+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;smart home .c,87 :: 		i = 0;
	CLRF       _i+0
;smart home .c,88 :: 		clear_receive();
	CALL       _clear_receive+0
;smart home .c,85 :: 		for (z = 0; z <= 3; z++) {
	INCF       main_z_L5+0, 1
;smart home .c,89 :: 		}
	GOTO       L_main29
L_main30:
;smart home .c,90 :: 		alarm_sound = 1;
	BSF        PORTB+0, 0
;smart home .c,91 :: 		alarm_light = 1;
	BSF        PORTB+0, 1
;smart home .c,92 :: 		}
L_main28:
L_main22:
L_main16:
;smart home .c,93 :: 		}
L_main10:
;smart home .c,94 :: 		}
L_main9:
;smart home .c,95 :: 		}
L_main7:
;smart home .c,96 :: 		}
	GOTO       L_main3
;smart home .c,97 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
