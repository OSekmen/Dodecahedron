import peasy.*;
int time;
int prevTime=-10000;

int counter;


float phi = (1+sqrt(5))/2;

float Pos1[][] = new float[7][3];
float Pos2[][] = new float[7][3];
float Pos3[][] = new float[7][3];
float Pos4[][] = new float[7][3];
float Pos5[][] = new float[7][3];

float[][][] posArray={Pos1, Pos2, Pos3, Pos4, Pos5};

float rotMat[][] =
  {{((pow(phi, 2)-1)/(2*phi)), ((-1)/(2*phi)), ((phi)/(2))}, 
  {(-(pow(phi, 3))+phi+2)/(2), ((phi)/(2)), (-(pow(phi, 3))+2*(pow(phi, 2)))/(2)}, 
  {((pow(phi, 4)-2*pow(phi, 2)-2*phi-1)/(2*phi)), (-(pow(phi, 2))+1)/(2*phi), (pow(phi, 3)-2*(pow(phi, 2))+phi)/(2)}};

float coor[][] = 
  {{1, -1, -1, }, 
  {phi, (-1/phi), 0}, 
  {phi, (1/phi), 0}, 
  {1, 1, 1}, 
  {0, phi, (1/phi)}, 
  {-1, 1, 1}, 
  {1, 1, -1}};

Led[] leds;
color[] ledHMem= new color[240];

Arm arm1;
Arm arm2;
Arm arm3;
Arm arm4;
Arm arm5;

Chaser chaser1;
Chaser chaser2;
Chaser chaser3;
Chaser chaser4;
Chaser chaser5;

PeasyCam cam;

void setup() {
  size(1200, 800, P3D);
  //smooth(0);
  colorMode(HSB, 240);
  cam = new PeasyCam(this, width/2, height/2, 0, 50);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(700);


  for (int i=0; i<7; i++) {
    for (int j=0; j<3; j++) {
      Pos1[i][j] = coor[i][j] * 50;
    }
  }

  Pos2= rotCalc(Pos1, Pos2, rotMat);
  Pos3= rotCalc(Pos2, Pos3, rotMat);
  Pos4= rotCalc(Pos3, Pos4, rotMat);
  Pos5= rotCalc(Pos4, Pos5, rotMat);



  arm1 = new Arm(Pos1, #FFFFFF);
  arm2 = new Arm(Pos2, #FF0000);
  arm3 = new Arm(Pos3, #00FF00);
  arm4 = new Arm(Pos4, #0000FF);
  arm5 = new Arm(Pos5, #FF00FF);
 // /*
  chaser1 = new Chaser(0, 0, 5, color(10, 255, 255));
   chaser2 = new Chaser(0, 1, 5, color(50, 255, 255));
   chaser3 = new Chaser(0, 2, 5, color(100, 255, 255));
   chaser4 = new Chaser(0, 3, 5, color(150, 255, 255));
   chaser5 = new Chaser(0, 4, 5, color(200, 255, 255));
  // */

    leds = new Led[240];
  for (int i=0; i<5; i++) {
    for (int j=0; j<2; j++) {
      ledAssign(posArray[i][j], posArray[i][j+1], j*8+(i*48));
    }
    ledAssign(posArray[i][6], posArray[i][2], 2*8+(i*48));
    for (int j=3; j<6; j++) {
      ledAssign(posArray[i][j-1], posArray[i][j], j*8+(i*48));
    }
  }
}

void draw() {
  time = millis();
  background(0);
  scale(1, -1, -1);
  translate(width/2, -height/2, 0);
  axis();

  arm1.showArm();
  arm2.showArm();
  arm3.showArm();
  arm4.showArm();
  arm5.showArm();
  
  ///*
   cam.beginHUD();
   text(chaser1.Pos, 10, 10);
   text(chaser1.vorigeIndex, 10, 25);
   text(chaser1.dir, 10, 40);
   //text(chaser1.ledHis.get(chaser1.ledHis.size()-1), 10, 55);
   cam.endHUD();
  chaser1.show();
  chaser2.show();
  chaser3.show();
  chaser4.show();
  chaser5.show();

  chaser1.update(10);
  chaser2.update(20);
  chaser3.update(30);
  chaser4.update(40);
  chaser5.update(50);
 // */
}
void keyPressed() {
  if (keyCode == UP) {

    chaser1.update(0);
  }
  if (keyCode == DOWN) {

    chaser1.dir *=-1;
    chaser1.update(0);
  }

  if (keyCode == '0') {
    if (chaser1.Pos%8 != 0) {
      chaser1.Pos-=chaser1.Pos%8;
    } else {
      chaser1.Pos-=8;
    }
    chaser1.update(0);
  }
}
void axis() {
  stroke(#FF0000);
  line(-100, -5, 0, -100, 5, 0);
  line(-100, 0, 0, 100, 0, 0);
  stroke(#00FF00);
  line(-5, -100, 0, 5, -100, 0);
  line(0, -100, 0, 0, 100, 0);
  stroke(#0000FF);
  line(0, -5, -100, 0, 5, -100);
  line(0, 0, -100, 0, 0, 100);
}

float[][] rotCalc(float inTempPos[][], float outTempPos[][], float rotTemp[][]) {
  for (int i=0; i<7; i++) {
    for (int j=0; j<3; j++) {
      outTempPos[i][j] = inTempPos[i][0]*rotTemp[0][j] +inTempPos[i][1]*rotTemp[1][j] +inTempPos[i][2]*rotTemp[2][j] ;
    }
  }
  return outTempPos;
}

void ledAssign(float pos1[], float pos2[], int ledNumBeg) {
  for (int i=0; i<8; i++) {

    float deltaX=(pos2[0]-pos1[0])/9;
    float deltaY=(pos2[1]-pos1[1])/9;
    float deltaZ=(pos2[2]-pos1[2])/9;
    float[] posTemp = {deltaX*(i+1)+pos1[0], deltaY*(i+1)+pos1[1], deltaZ*(i+1)+pos1[2]};
    leds[(ledNumBeg)+i]= new Led( posTemp);
  }
}
