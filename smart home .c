#define Motor portD.b0
#define Lamp PORTD.B1
#define Buzzer PORTD.B2
#define alarm_sound PORTB.B0
#define alarm_light PORTB.B1

char receive[5]; // stores the received data
unsigned short x = 0, i = 0;


void new_line() {
    UART1_Write(10);
    UART1_Write(13);
}

void clear_receive() {
    for (x = 0; x < 5; x++) {
        receive[x] = 0;
    }
}

void main() {
    unsigned int adc_value;
    float TempC, Volt;
    char TempC_text[15];
    TRISD = 0;
    trisb=0b11111111;
    portb=0;
    PORTD = 0;
    UART1_Init(9600);
    UART1_Write_Text("WELCOME\n\r");
    UART1_Write_Text("Please Enter The Password\n\r");

    for (;;) {
        adc_value = ADC_Read(0);
        Volt = (adc_value * 5) / 1023.0;
        TempC = Volt * 100.0;
        FloatToStr(TempC, TempC_text);
        UART1_Write_Text("Current Temp = ");
        UART1_Write_Text(TempC_text);
        UART1_Write_Text(" C"); // send temperature value to PC

        // new line
        UART1_Write(10);
        UART1_Write(13);
        Delay_ms(500); // wait 0.5 Second

        // motor
        if (UART1_Data_Ready() == 1) {
            receive[i] = UART1_Read();
            if (receive[i] == '/') {
                new_line();
                UART1_Write_Text("Please Enter The Password\n\r");
                i = 0;
                clear_receive();
            } else {
                UART1_Write('*');
                i++;
                if (i == 5) {
                    new_line();
                    if (receive[0] == 'm' && receive[1] == 'o' && receive[2] == 't' && receive[3] == 'o' && receive[4] == 'r') {
                        Motor = ~Motor;
                        if (Motor == 0) UART1_Write_Text("door is closed\n\r");
                        else UART1_Write_Text("door is  Ooen\n\r");
                        i = 0;
                        clear_receive();
                    }
                    // lamp1
                    else if (receive[0] == 'l' && receive[1] == 'a' && receive[2] == 'm' && receive[3] == 'p' && receive[4] == '1') {
                        Lamp = ~Lamp;
                        if (Lamp == 0) UART1_Write_Text("Lamp Turns OFF\n\r");
                        else UART1_Write_Text("Lamp Turns ON\n\r");
                        i = 0;
                        clear_receive();
                    }
                    // buzz1
                    else if (receive[0] == 'b' && receive[1] == 'u' && receive[2] == 'z' && receive[3] == 'z' && receive[4] == '1') {
                        Buzzer = ~Buzzer;
                        if (Buzzer == 0) UART1_Write_Text("Buzzer Turns OFF\n\r");
                        else UART1_Write_Text("Buzzer Turns ON\n\r");
                        i = 0;
                        clear_receive();
                    } else {
                    unsigned short z = 0;
                        for (z = 0; z <= 3; z++) {
                            UART1_Write_Text("Please Enter The Correct Password\n\r");
                            i = 0;
                            clear_receive();
                        }
                        alarm_sound = 1;
                        alarm_light = 1;
                    }
                }
            }
        }
    }
}
