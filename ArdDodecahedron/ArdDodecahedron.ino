#include "List.h"
#include "Chaser.h"
#include <Arduino.h>
#include <FASTled.h>



#define LED_PIN1 5
#define LED_PIN2 6
#define LED_PIN3 7
#define LED_PIN4 8
#define LED_PIN5 9
#define MAX_POW 150
#define NUM_LEDS 48

CRGB led[5][NUM_LEDS];
int time;
int prevTime = -10000;

int counter;
int aantaalChasers = 6;
//int ledHMem[240];

CRGB leds[5][NUM_LEDS];
void turnOff();
Chaser chaser1(0, 0, 10, 100);

void turnOff()
{
  for (int j = 0; j < 5; j++)
  {
    for (int i = 0; i < 48; i++)
    {
      leds[j][i] = CRGB::Black;
    }
  }
  FastLED.show();
}

void setup()
{
  Serial.begin(9600);
  //define 5 Led arms
  FastLED.addLeds<WS2812, LED_PIN1, GRB>(leds[0], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN2, GRB>(leds[1], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN3, GRB>(leds[2], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN4, GRB>(leds[3], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN5, GRB>(leds[4], NUM_LEDS);
}

void loop()
{
  function2();
}


void function2(){

  leds[0][number] = CRGB::Red;
}


void function1(){

  chaser1.show();
  chaser1.Update(5);
  int dataLine;
  int number;

  for (int i = 0; i < chaser1.len; i++)
  {
    dataLine = int(chaser1.ledHis.item[i] / 48);
    number = chaser1.ledHis.item[i] % 48;

    leds[dataLine][number] = CRGB::Red;
    FastLED.show();
  }
}
