class Arm {
  float[][] Pos = new float[7][3];
  int c;

  Arm (float[][] Pos, color c) {
    for (int i=0; i<7; i++) {
      for (int j=0; j<3; j++) {
        this.Pos[i][j] = Pos[i][j];
        this.c = c;
      }
    }
  }

  void showArm() {
    stroke(c,50);
    for (int i=0; i<6; i++) {
      if (i<5) {
        line(Pos[i][0], Pos[i][1], Pos[i][2], 
          Pos[i+1][0], Pos[i+1][1], Pos[i+1][2]);
      } else if (i==5) {
        line(Pos[i+1][0], Pos[i+1][1], Pos[i+1][2], 
          Pos[2][0], Pos[2][1], Pos[2][2]);
      }
    }
  }
}
