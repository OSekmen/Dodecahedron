#include <Adafruit_NeoPixel.h>
// Which pin on the Arduino is connected to the NeoPixels?
// On a Trinket or Gemma we suggest changing this to 1:
#define LED_PIN    6

// How many NeoPixels are attached to the Arduino?
#define LED_COUNT 24

// Declare our NeoPixel strip object:
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

void setup() {
pinMode(6,OUTPUT);
}
void loop() {
  for (int i = 0; i < LED_COUNT; i++) {
    //strip.setPixelColor(i, strip.Color(200, 200, 150)); // Moderately bright green color.
    strip.setPixelColor(i, strip.Color(125, 125, 125));
  
  }
  delay(100);
  strip.show();
}
