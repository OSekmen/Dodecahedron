#include "List.h"
#include "Chaser.h"
#include <arduino.h>
#include <FastLED.h>

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
Chaser chaser1(0, 0, 5, 100);

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
  FastLED.addLeds<WS2812, LED_PIN1, GRB>(leds[0], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN2, GRB>(leds[1], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN3, GRB>(leds[2], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN4, GRB>(leds[3], NUM_LEDS);
  FastLED.addLeds<WS2812, LED_PIN5, GRB>(leds[4], NUM_LEDS);
}

void loop()
{

  chaser1.show();
  chaser1.Update(500);
  int dataLine;
  int number;
  /*
  for (int i = 0; i < chaser1.len; i++)
  {
    //dataLine = int(47 / 48);
    //number = 47 % 48;
    //Serial.print(dataLine);Serial.print("  ");Serial.println(number);
    Serial.print(chaser1.ledHis.item[i]);
    Serial.print(" ");
    //leds[dataLine][] = CRGB::Red;
    //FastLED.show();
    //leds[dataLine][i] = CRGB::Black;
  }
  Serial.print("New item: ");Serial.print(chaser1.ledHis.item[0]);Serial.print(" ");
  Serial.println(" ");

  */
  for (int i = 0; i < chaser1.len; i++)
  {

    dataLine = int(chaser1.ledHis.item[i] / 48);
    number = chaser1.ledHis.item[i] % 48;

    leds[dataLine][number] = CRGB::Red;
    FastLED.show();
  }
}
