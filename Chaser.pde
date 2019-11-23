class Chaser {
  int Pos=0;
  int vorigeIndex;
  int size;
  int tak;
  int arm;
  color c;
  color[] ledMem;
  IntList ledHis;


  Chaser(int tak, int arm, int size) {
    this.size = size;
    this.tak = tak;
    this.arm = arm;
    Pos= (8*tak)+(48*arm);
    ledMem = new color[240];
    ledHis = new IntList();
    ledHis.append(Pos);
  }
  
  Chaser(int tak, int arm, int size,color c) {
    this.size = size;
    this.tak = tak;
    this.arm = arm;
    this.c = c;
    Pos= (8*tak)+(48*arm);
    ledMem = new color[240];
    ledHis = new IntList();
    ledHis.append(Pos);
  }

  void update() { 

    vorigeIndex = ledHis.get(ledHis.size()-1);
    ledHis.append(Pos);
    if (Pos%8 == 7) {
      if (vorigeIndex%8 == Pos%8-1) {
        switch(Pos%48) {
        case 7:
          Pos=(48)+(48*arm)-1;
          println(arm, "test");
          break;
        case 15:
          Pos=24+(48*arm)-1;
          break;
        case 31:
          Pos=64+(48*arm)-1;
          break;
        case 39:
          Pos=239+(48*arm)-1;
          break;
        case 47:
          Pos=87+(48*arm)-1;
          break;
        }
      }/* else if (vorigeIndex%8 == Pos%8-1) {
        switch(Pos%48) {
        case 7:
          Pos=(48)+(48*arm)-1;
          println(arm, "test");
          break;
        case 15:
          Pos=24+(48*arm)-1;
          break;
        case 31:
          Pos=64+(48*arm)-1;
          break;
        case 39:
          Pos=239+(48*arm)-1;
          break;
        case 47:
          Pos=87+(48*arm)-1;
          break;
        }
      }*/
    }

    if (ledHis.size() > size) {
      ledHis.remove(0);
      ledMem[ledHis.get(0)%240] = 0;
      ledHMem[ledHis.get(0)%240] = 0;
    }
  }

  void show() {
    for (int i=0; i<size; i++) {
      if (ledHis.size() > i) {
        //ledHMem[ledHis.get(i)%240]=color(255, 255, 255);
        //ledMem[ledHis.get(i)%240]=color(255, 255, 255);
        //leds[ledHis.get(i)%240].showLed(color(255, 255, 255));
        
        ledHMem[ledHis.get(i)%240]=c;
        ledMem[ledHis.get(i)%240]=c;
        leds[ledHis.get(i)%240].showLed(c);
      }
    }
  }
}
