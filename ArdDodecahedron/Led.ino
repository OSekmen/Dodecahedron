class Led {
  float[] Pos = new float[3];
  color c;

  Led(float[] Pos) {
    for (int i=0; i<3; i++) {
      this.Pos[i] = Pos[i];
    }
  }

  void showLed(color c) {
    stroke(c);
    strokeWeight(10);
    point(Pos[0], Pos[1], Pos[2]);
    strokeWeight(1);
  }
}
