#include <FastLED.h>
#define LED_PIN1 5
#define LED_PIN2 6
#define LED_PIN3 7
#define LED_PIN4 8
#define LED_PIN5 9
#define MAX_POW 150
#define NUM_LEDS 48

CRGB leds[5][NUM_LEDS];

void setup(){
    FastLED.addLeds<WS2812,LED_PIN1, GRB>(leds[0], NUM_LEDS);
    FastLED.addLeds<WS2812,LED_PIN2, GRB>(leds[1], NUM_LEDS);
    FastLED.addLeds<WS2812,LED_PIN3, GRB>(leds[2], NUM_LEDS);
    FastLED.addLeds<WS2812,LED_PIN4, GRB>(leds[3], NUM_LEDS);
    FastLED.addLeds<WS2812,LED_PIN5, GRB>(leds[4], NUM_LEDS);

}

void loop(){
    for(int x=0; x<5;x++){
        for(int i =0;i<48;i++){
            leds[x][i] = CRGB::Red;
            FastLED.show();
            leds[x][i] = CRGB::Black;
            delay(100);
        }
    }

}
