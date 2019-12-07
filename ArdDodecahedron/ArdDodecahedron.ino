#include "Chaser.h"
#include <arduino.h>

int time;
int prevTime = - 10000;

int counter;
int aantaalChasers = 6;


Chaser chaser1(0, 0, 10, 5);


void setup() {
  Serial.begin(9600);
  

  //for (int i=0; i<aantaalChasers; i++) {
  //  chasers = new Chaser(int(random(0, 7)), int(random(0, 5)), int(random(5, 15)), int(random(0, 255)));
  //}

  int leds[240];

}

void loop() {

  chaser1.show();
  chaser1.Update(1000);

}
