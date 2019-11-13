import processing.video.*;


import controlP5.*;

ControlP5 cp5;
ColorPicker cp;

////////////VIDEO////////////
//Movie image;
/////WEBCAM////////////
Capture image;
/////////////////////

int R_Width=50;
int R_Height=50;
int n=3;

///sizes
float Width_o=50;
float Height_o=50;
float Width_i=25;
float Height_i=40;

float changer=10;

float radius_o=500;
float radius_i=400;
//////
int margin=0;
float step=100;

float j=0.1;

float rotation_speed=radians(j);
float rotation_speed_i=radians(j);
float rotation = 0;
float rotation_i=0;


float redChannel;
float greenChannel;
float blueChannel;


int tint_r=255;
int tint_g=255;
int tint_b=255;


void setup() {

  size(1280, 720);
//////////////////VIDEO/////////////////////
 // image =new Movie(this, "P2_1.mp4");
 // image.loop();
  //////////////////////////////////////////////////////
  
  
  ///////////////////////////WEBCAM////////////////////////////////
    image =new Capture(this, Capture.list()[0]);
  image.start();
 //////////////////////////////////////////////////////


  rectMode(CENTER);
  cp5 = new ControlP5(this);




  cp5.addSlider("j")
    .setPosition(0, 200)
    .setSize(200, 20)
    .setRange(0, 0.2)
    .setCaptionLabel("Rotation Speed")
    ;

  cp5.addSlider("n")
    .setPosition(0, 0)
    .setSize(200, 20)
    .setRange(3, 80)
    .setCaptionLabel("Rectangles Number")
    ;

  cp5.addSlider("Width_o")
    .setPosition(0, 20)
    .setSize(200, 20)
    .setRange(3, 500)
    ;
    
     cp5.addSlider("Height_o")
    .setPosition(0, 40)
    .setSize(200, 20)
    .setRange(3, 500)
    ;

  cp5.addSlider("Width_i")
    .setPosition(0, 60)
    .setSize(200, 20)
    .setRange(3, 500)
    ;

  cp5.addSlider("Height_i")
    .setPosition(0, 80)
    .setSize(200, 20)
    .setRange(0, 800)
    ;




  cp5.addSlider("radius_o")
    .setPosition(0, 120)
    .setSize(200, 20)
    .setRange(0, 800)
    ;

  cp5.addSlider("radius_i")
    .setPosition(0, 140)
    .setSize(200, 20)
    .setRange(0, 800)
    ;
  cp5.addSlider("step")
    .setPosition(0, 180)
    .setSize(200, 20)
    .setRange(12, 800)
    ;

  cp5.addSlider("changer")
    .setPosition(0, 240)
    .setSize(200, 20)
    .setRange(1, 25)
    ;



  cp5.addSlider("tint_r")
    .setPosition(width-210, 0)
    .setSize(200, 20)
    .setRange(0, 255)
    .setColorActive(color(tint_r+80, 0, 0))
    .setColorBackground(color(150, 150, 150))
    .setColorForeground(color(tint_r, 0, 0))
    ;
  cp5.addSlider("tint_g")
    .setPosition(width-210, 20)
    .setSize(200, 20)
    .setRange(0, 255)
    .setColorActive(color(20, tint_g+50, 0))
    .setColorBackground(color(150, 150, 150))
    .setColorForeground(color(20, tint_g, 0))
    ;
  cp5.addSlider("tint_b")
    .setPosition(width-210, 40)
    .setSize(200, 20)
    .setRange(0, 255)
    .setColorActive(color(0, 20, tint_b+100))
    .setColorBackground(color(150, 150, 150))
    .setColorForeground(color(0, 20, tint_b))
    ;
}

void draw() {
  rotation_speed=radians(j);
  rotation_speed_i=radians(j);



  background(255);


  rectMode(CENTER);

  if (image.available()) {
    image.read();
    image.loadPixels();
  }
  if (image.pixels!=null && image.pixels.length>0) {

    for (int x=margin; x<(width)-margin; x+=step) {
      for (int y=margin; y<height-margin; y+=step) {
        int index=x+y*(width);
        color c=image.pixels[index];
        //int centerX=x+step/2;
        //int centerY=y+step/2;
        redChannel=red(c);  
        greenChannel=green(c);
        blueChannel=blue(c);
        float re=map(redChannel, 0, 255, 1, 2);
        float gr=map(greenChannel, 0, 255, 1, 2);
        float bl=map(blueChannel, 0, 255, 1, 2);
        ////Creating the objects/////
        pushMatrix();
        translate(x, y);
        shape_o(int(n), re, gr, bl, map(redChannel, 0, 255, 0, tint_r), map(greenChannel, 0, 255, 0, tint_g), map(blueChannel, 0, 255, 0, tint_b));
        shape_i(int(n/3), re, gr, bl, map(redChannel, 0, 255, 0, tint_r), map(greenChannel, 0, 255, 0, tint_g), map(blueChannel, 0, 255, 0, tint_b));
        rotation += rotation_speed;
        rotation_i -= rotation_speed_i;
        popMatrix();
        pushMatrix();
        fill(tint_r, tint_g, tint_b);

        rect(width-110, 80, 200, 30);
        popMatrix();
      }
    }
  }
  
  //saveFrame("output/########.png");
}









void shape_o(int sides, float re, float gr, float bl, float r, float g, float b) {
  float ang;
  rotate(rotation);
  ang=radians(180-((sides-2)*180)/sides);

  for (int i=0; i<sides; i++) {
    //rect(0, radius_o, Width_o, Width_o);
    noStroke();
    fill(r, g, b);
    rect(0, map(radius_o*changer/(re*gr*bl), 0, 800, 0, step/2), map(Width_o*changer/(re*gr*bl), 0, 500, 0, step/2), map(Height_o*changer/(re*gr*bl), 0, 500, 0, step/2));
    rotate(ang);
  }
  rotate(-rotation);
}

void shape_i(int sides, float re, float gr, float bl, float r, float g, float b) {
  float ang;
  noStroke();
  rotate(rotation_i);
  ang=radians(180-((sides-2)*180)/sides);
  for (int i=0; i<sides; i++) {
    //rect(0, radius_i, Width_i, Height_i);
    fill(r, g, b);

    rect(0, map(radius_i*changer/(re*gr*bl), 0, 800, 0, step/2), map(Width_i*changer/(re*gr*bl), 0, 500, 0, step/2), map(Height_i*changer/(re*gr*bl), 0, 500, 0, step/2));
    rotate(ang);
  }
  rotate(-rotation_i);
}
