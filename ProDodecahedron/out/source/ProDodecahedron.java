import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ProDodecahedron extends PApplet {




int time;
int prevTime=-10000;

int counter;
int aantaalChasers = 6;

float phi = (1+sqrt(5
))/2;

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
int[] ledHMem= new int[240];

Arm arm1;
Arm arm2;
Arm arm3;
Arm arm4;
Arm arm5;


Chaser[] chasers;

PeasyCam cam;

public void setup() {
  
  
  //smooth(0);
  colorMode(HSB, 255);
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



  arm1 = new Arm(Pos1, 0xffFFFFFF);
  arm2 = new Arm(Pos2, 0xffFF0000);
  arm3 = new Arm(Pos3, 0xff00FF00);
  arm4 = new Arm(Pos4, 0xff0000FF);
  arm5 = new Arm(Pos5, 0xffFF00FF);
  println(posArray[0]);
  /*
  chaser1 = new Chaser(0, 0, 5, color(10, 255, 255));
   chaser2 = new Chaser(0, 1, 5, color(50, 255, 255));
   chaser3 = new Chaser(0, 2, 5, color(100, 255, 255));
   chaser4 = new Chaser(0, 3, 5, color(150, 255, 255));
   chaser5 = new Chaser(0, 4, 5, color(200, 255, 255));
   */

  chasers = new Chaser[aantaalChasers];

  for (int i=0; i<aantaalChasers; i++) {
    chasers[i] = new Chaser(PApplet.parseInt(random(0, 7)), PApplet.parseInt(random(0, 5)), PApplet.parseInt(random(5, 15)), PApplet.parseInt(random(0, 255)));
  }

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

public void draw() {
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

  /*
   cam.beginHUD();
   text(chaser1.Pos, 10, 10);
   text(chaser1.vorigeIndex, 10, 25);
   text(chaser1.dir, 10, 40);
   //text(chaser1.ledHis.get(chaser1.ledHis.size()-1), 10, 55);
   cam.endHUD();
   */
  for (int i=0; i<aantaalChasers; i++) {
    chasers[i].show(); 
    chasers[i].update(50);
  }
}

public void axis() {
  stroke(0xffFF0000);
  line(-100, -5, 0, -100, 5, 0);
  line(-100, 0, 0, 100, 0, 0);
  stroke(0xff00FF00);
  line(-5, -100, 0, 5, -100, 0);
  line(0, -100, 0, 0, 100, 0);
  stroke(0xff0000FF);
  line(0, -5, -100, 0, 5, -100);
  line(0, 0, -100, 0, 0, 100);
}

public float[][] rotCalc(float inTempPos[][], float outTempPos[][], float rotTemp[][]) {
  for (int i=0; i<7; i++) {
    for (int j=0; j<3; j++) {
      outTempPos[i][j] = inTempPos[i][0]*rotTemp[0][j] +inTempPos[i][1]*rotTemp[1][j] +inTempPos[i][2]*rotTemp[2][j] ;
    }
  }
  return outTempPos;
}

public void ledAssign(float pos1[], float pos2[], int ledNumBeg) {
  for (int i=0; i<8; i++) {

    float deltaX=(pos2[0]-pos1[0])/9;
    float deltaY=(pos2[1]-pos1[1])/9;
    float deltaZ=(pos2[2]-pos1[2])/9;
    float[] posTemp = {deltaX*(i+1)+pos1[0], deltaY*(i+1)+pos1[1], deltaZ*(i+1)+pos1[2]};
    leds[(ledNumBeg)+i]= new Led( posTemp);
  }
}

/*
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
 */
class Arm {
  float[][] Pos = new float[7][3];
  int c;

  Arm (float[][] Pos, int c) {
    for (int i=0; i<7; i++) {
      for (int j=0; j<3; j++) {
        this.Pos[i][j] = Pos[i][j];
        this.c = c;
      }
    }
  }

  public void showArm() {
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
class Chaser {
  int Pos;
  int brightness;
  int prevTime=1000;
  int dir=1;
  int vorigeIndex;
  int size;
  int tak;
  int arm;
  int c;
  int h;
  int[] ledMem;
  IntList ledHis;




  Chaser(int tak, int arm, int size, int h) {
    this.size = size;
    this.tak = tak;
    this.arm = arm;
    this.h = h;
    this.Pos= (8*tak)+(48*arm);
    ledMem = new int[240];
    ledHis = new IntList();
    ledHis.append(Pos);
  }
  public void choose(int right, int left, int dir1, int dir2) {
    if (random(0, 100)>50) {
      this.Pos+= right-1-this.Pos%48;
      this.dir= dir1;
    } else {
      this.Pos+= left-1-this.Pos%48;

      this.dir=dir2;
    }
    this.Pos = this.Pos%240;
  }
  public void update(int time) {
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

  public void show() {
    for (int i=0; i<size; i++) {
      if (ledHis.size() > i) {
        this.c = color(h,255,255,i*(255/size));
        ledHMem[ledHis.get(i)%240]=c;
        ledMem[ledHis.get(i)%240]=c;
        leds[ledHis.get(i)%240].showLed(c);
      }
    }
  }
}
class Led {
  float[] Pos = new float[3];
  int c;

  Led(float[] Pos) {
    for (int i=0; i<3; i++) {
      this.Pos[i] = Pos[i];
    }
  }

  public void showLed(int c) {
    stroke(c);
    strokeWeight(10);
    point(Pos[0], Pos[1], Pos[2]);
    strokeWeight(1);
  }
}
  public void settings() {  size(1200, 800, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ProDodecahedron" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
