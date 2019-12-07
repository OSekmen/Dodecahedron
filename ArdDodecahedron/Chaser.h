
#include "List.h"
class Chaser {
  
  public:
    Chaser(int tak, int arm,  int len, int h);
    List ledHis;
    int Pos;
    int brightness;
    int dir = 1;
    int vorigeIndex;
    int len;
    int hue;
    //int ledHis[240];

    int32_t time;
    int32_t prevTime = 0;
    int counter =0;

    void Update(int time){
      this->time = millis();
      if (this->time - prevTime >time) {
        
        ledHis.append(counter);
        ledHis.print();
        
        if(ledHis.size() >len){
          ledHis.shift(counter);
          Serial.print("hallo");
        }

        counter+=dir;
        
        prevTime = this->time ;
        }
      }

    void show(){

    }


    
    void choose() {
        
    }



};

Chaser::Chaser(int tak, int arm, int len, int h) {
  this->len = len;
  this->hue = hue;
  this->Pos = (8 * tak) + (48 * arm);
  ledHis.setLenght(len);
  
  
}

