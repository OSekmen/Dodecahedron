class Chaser {
  int Pos;
  int prevTime=1000;
  int dir=1;
  int vorigeIndex;
  int size;
  int tak;
  int arm;
  color c;
  color[] ledMem;
  IntList ledHis;




  Chaser(int tak, int arm, int size, color c) {
    this.size = size;
    this.tak = tak;
    this.arm = arm;
    this.c = c;
    this.Pos= (8*tak)+(48*arm);
    ledMem = new color[240];
    ledHis = new IntList();
    ledHis.append(Pos);
  }
  void choose(int right, int left, int dir1, int dir2) {
    if (random(0, 100)>50) {
      this.Pos+= right-1-this.Pos%48;
      this.dir= dir1;
    } else {
      this.Pos+= left-1-this.Pos%48;

      this.dir=dir2;
    }
    this.Pos = this.Pos%240;
  }
  void update(int time) {
    if (millis() - prevTime >time) {

      vorigeIndex = ledHis.get(ledHis.size()-1);
      Pos +=dir;
      ledHis.append(Pos);
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

      if (ledHis.size() > size) {
        ledHis.remove(0);
        ledMem[ledHis.get(0)%240] = 0;
        ledHMem[ledHis.get(0)%240] = 0;
      }
      prevTime = millis();
    }
  }

  void show() {
    for (int i=0; i<size; i++) {
      if (ledHis.size() > i) {
        ledHMem[ledHis.get(i)%240]=c;
        ledMem[ledHis.get(i)%240]=c;
        leds[ledHis.get(i)%240].showLed(c);
      }
    }
  }
}
