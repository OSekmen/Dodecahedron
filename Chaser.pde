class Chaser {
  int Pos=5;
  int size;
  color[] ledMem;
  IntList ledHis;


  Chaser(int size) {
    this.size = size;
    ledMem = new color[240];
    ledHis = new IntList();
    ledHis.append(Pos);
  }

  void update() {
    ledHis.append(Pos);


    if (ledHis.size() > size) {
      ledHis.remove(0);
      ledMem[ledHis.get(0)] = 0;
      ledHMem[ledHis.get(0)] = 0;
    }
  }

  void show() {
    for (int i=0; i<size; i++) {
      if (ledHis.size() > i) {
        ledHMem[ledHis.get(i)]=color(255, 255, 255);
        ledMem[ledHis.get(i)]=color(255, 255, 255);
        leds[ledHis.get(i)].showLed(color(255,255,255));
      }
    }
  }
}
