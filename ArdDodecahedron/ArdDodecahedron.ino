#include "Chaser.h"
#include <arduino.h>

int time;
int prevTime = - 10000;

int counter;
int aantaalChasers = 6;
int ledHMem[240];

Chaser chaser1(0, 0, 5, 100);
Chaser chaser2(1, 2, 6, 100);
void setup() {
  Serial.begin(9600);
}

void loop() {

  chaser1.show();
  chaser1.Update(500);
}
