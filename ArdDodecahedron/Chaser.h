
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

    void Update(int time){
      this->time = millis();
      if (this->time - prevTime >time) {
        vorigeIndex = ledHis.item[ledHis.size()-1];
        Pos+=dir;
        ledHis.append(Pos);
        ledHMem[Pos]=1;
        ledHis.print();
        
        if (Pos%8 == 7) {
        if (vorigeIndex%8 == Pos%8-1) {
          switch(Pos%48) {
          case 7:
            choose(48, 8, 1, 1);
            break;
          case 15:
            choose(24, 24, 1, -1);
            break;
          case 23:
            choose(17, 24, -1, 1);
            break;
          case 31:
            choose(64, 32, 1, 1);
            break;
          case 39:
            choose(40, 240, 1, -1);
            break;
          case 47:
            choose(89, 88, -1, 1);
            break;
          }
        }
      } else if (Pos%8 == 0) {
        if (vorigeIndex%8 == Pos%8+1) {
          switch(Pos%48) {
          case 0:
            choose(199, 200, 1, -1);
            Pos+=1;
            break;
          case 8:
            choose(8, 47, -1, 1);
            Pos+=1;
            break;
          case 16:
            choose(223, 224, 1, -1);
            Pos+=1;
            break;
          case 24:
            choose(24, 16, -1, -1);
            Pos+=1;
            break;
          case 32:
            choose(32, 63, -1, 1);
            Pos+=1;
            break;
          case 40:
            choose(239, 39, -1, -1);
            Pos+=1;
            break;
          }
        }
      }


        if(ledHis.size() >len){
          ledHis.shift(Pos);
          LedHMem[Pos]=0;
          
        }

        
        //temporary bug fix. Remove when algorithm is implemented)
        if(Pos >=240){
          for(int i=0;i<240;i++){
            ledHis.item[i]=-1;
          }
          Pos=0;
        }
        //
        prevTime = this->time ;
        }
      }

    void show(){

    }
    void choose(int right, int left, int dir1, int dir2) {
    if (random(0, 100)>50) {
      this->Pos+= right-1-this->Pos%48;
      this->dir= dir1;
    } else {
      this->Pos+= left-1-this->Pos%48; 
      this->dir=dir2;
    }
    this->Pos = this->Pos%240;
  }



};

Chaser::Chaser(int tak, int arm, int len, int h) {
  this->len = len;
  this->hue = hue;
  this->Pos = (8 * tak) + (48 * arm);
  ledHis.setLenght(len);
}

