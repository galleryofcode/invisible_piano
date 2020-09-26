/**
 * Invisible piano By Olubiyiontheweb 
 */

import processing.sound.*;
//import TUIO.*;
//import gab.opencv.*;
import processing.video.*;
//import java.awt.*;

SoundFile c, d, e, f, g, a, b;
//TuioProcessing tuioClient;

Capture video;
//OpenCV opencv;

PImage piano, prevFrame;
//int tobjbrushY, tobjbrushX;

float soundwidth, soundwidthm, threshold = 250;

int testloc;

boolean playing = false;

//SinOsc sine;

void setup() {
  size(1280, 960);
  //background(200);

  //fullScreen();

  piano = loadImage("pianoimage.jpg");

  //video = new Capture(this, width/scl, height/scl);
  //opencv = new OpenCV(this, width/scl, height/scl);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  //video.start();

  //Initialising the Tuio object
  //  tuioClient  = new TuioProcessing(this);

  video = new Capture(this, width, height, "USB Video Device", 5);
  video.start();
  // Create an empty image the same size as the video
  prevFrame = createImage(video.width, video.height, RGB);

  c = new SoundFile(this, "c.wav");
  d = new SoundFile(this, "d.wav");
  e = new SoundFile(this, "e.wav");
  f = new SoundFile(this, "f.wav");
  g = new SoundFile(this, "g.wav");
  a = new SoundFile(this, "a.wav");
  b = new SoundFile(this, "b.wav");

  soundwidth = width/16;
  soundwidthm = width/8;
}

void draw() {

  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

  // These are the variables we'll need to find the average X and Y
  float sumX = 0;
  int motionCount = 0; 

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {

      color current = video.pixels[x+y*video.width];

      // What is the previous color
      color previous = prevFrame.pixels[x+y*video.width];

      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous);
      float b2 = blue(previous);

      // Motion for an individual pixel is the difference between the previous color and current color.
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // Step 5, How different are the colors?
      // If the color at that pixel has changed, then there is motion at that pixel.
      if (diff > threshold) {
        sumX += x;
        motionCount++;
      }
    }
  }

  //image(video, 0, 0 );
  scale(2);

  // average location is total location divided by the number of motion pixels.
  float avgX = sumX / motionCount;

  image(piano, 0, 0, width/2, height/2);
  //background(200);
  line(soundwidth,0,soundwidth,height);
  strokeWeight(5);
  line(soundwidth*2,0,soundwidth*2,height);
  strokeWeight(5);
  line(soundwidth*3,0,soundwidth*3,height);
  strokeWeight(5);
  line(soundwidth*4,0,soundwidth*4,height);
  strokeWeight(5);
  line(soundwidth*5,0,soundwidth*5,height);
  strokeWeight(5);
  line(soundwidth*6,0,soundwidth*6,height);
  strokeWeight(5);
  line(soundwidth*7,0,soundwidth*7,height);
  //stroke(126);
  
  
  
  testloc = int(avgX / soundwidth);
  println( soundwidth);
  
  //check object location

if (playing == true) {
 startplay();
}
}

void startplay() {

  chkloc(testloc);

  if (testloc == 0)
  {
    d.stop();
      e.stop();
      f.stop();
      g.stop();
      a.stop();
      b.stop();
      c.stop();
      c.play();
  } else if (testloc == 1)
  {
    d.stop();
    d.play();
      e.stop();
      f.stop();
      g.stop();
      a.stop();
      b.stop();
      c.stop();
  } else if (testloc == 2)
  {
    d.stop();
    e.stop();
      e.play();
      f.stop();
      g.stop();
      a.stop();
      b.stop();
      c.stop();
  } else if (testloc == 3)
  {  
      d.stop();
      e.stop();
      f.stop();
      f.play();
      g.stop();
      a.stop();
      b.stop();
      c.stop();
  } else if (testloc == 4)
  {
    d.stop();
      e.stop();
      f.stop();
      g.stop();
      g.play();
      a.stop();
      b.stop();
      c.stop();
  } else if (testloc == 5)
  {
    d.stop();
      e.stop();
      f.stop();
      g.stop();
      a.stop();
      a.play();
      b.stop();
      c.stop();
  } else if (testloc == 6)
  {
    d.stop();
      e.stop();
      f.stop();
      g.stop();
      a.stop();
      b.stop();
      b.play();
      c.stop();
  } else if (testloc == 7)
  {   
      d.stop();
      e.stop();
      f.stop();
      g.stop();
      a.stop();
      b.stop();
      c.stop();
      c.play();
  }
  
}

void chkloc(int xloc) {
  noStroke();
  fill(255,228,224);
  rect(xloc*soundwidth,0,soundwidth,720);
}

void mousePressed() {
  chkloc(testloc);
  if ((mouseX > 0) && (mouseX < soundwidthm))
{
    rect(mouseX+10, 680, 50, 100);
    fill(255);
    c.play();
  } else if ((mouseX > soundwidthm) && (mouseX < soundwidthm*2))
  {
    rect(mouseX+10, 680, 50, 100);
    d.play();
  } else if ((mouseX > soundwidthm*2) && (mouseX < soundwidthm*3))
  {
    rect(mouseX+10, 680, 50, 100);
    e.play();
  } else if ((mouseX > soundwidthm*3) && (mouseX < soundwidthm*4))
  {
    rect(mouseX+10, 680, 50, 100);
    f.play();
  } else if ((mouseX > soundwidthm*4) && (mouseX < soundwidthm*5))
  {
    rect(mouseX+10, 680, 50, 100);
    g.play();
  } else if ((mouseX > soundwidthm*5) && (mouseX < soundwidthm*6))
  {
    rect(mouseX+10, 680, 50, 100);
    a.play();
  } else if ((mouseX > soundwidthm*6) && (mouseX < soundwidthm*7))
  {
    rect(mouseX+10, 680, 50, 100);
    b.play();
  } else if ((mouseX > soundwidthm*7) && (mouseX < soundwidthm*8))
  {
    rect(mouseX+10, 680, 50, 100);
    c.play();
  }
  //println (mouseX, mouseY);
}

// called when a fiducial is added to the scene
//void addTuioObject(TuioObject tobj) 
//{
//}

// called when a fiducial is removed from the scene
//void removeTuioObject(TuioObject tobj) 
//{
//  //fid = tobj.getSymbolID();  //assignment
//  // when a symbol is removed, hide it
//  //obj.remove(new Integer(fid));
//}

// called when a fiducial is moved
//void updateTuioObject (TuioObject tobj) 
//{
//  tobjbrushY = tobj.getScreenY(height);
//  tobjbrushX = tobj.getScreenX(width);

//  if ((tobjbrushX > 172) && (tobjbrushX < 288))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   c.play();
//  } else if ((tobjbrushX > 288) && (tobjbrushX < 407))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   d.play();
//  } else if ((tobjbrushX > 407) && (tobjbrushX < 527))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   e.play();
//  } else if ((tobjbrushX > 527) && (tobjbrushX < 645))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   f.play();
//  } else if ((tobjbrushX > 645) && (tobjbrushX < 764))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   g.play();
//  } else if ((tobjbrushX > 764) && (tobjbrushX < 883))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   a.play();
//  } else if ((tobjbrushX > 883) && (tobjbrushX < 1002))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   b.play();
//  } else if ((tobjbrushX > 1002) && (tobjbrushX < 1122))
//  {
//   rect(tobjbrushX+10,680,50,100);
//   c.play();
//  }

//}

//// called when a cursor is added to the scene
//void addTuioCursor(TuioCursor tcur) {
//}

//// called when a cursor is moved
//void updateTuioCursor (TuioCursor tcur) {
//}

//// called when a cursor is removed from the scene
//void removeTuioCursor(TuioCursor tcur) {
//}

//// called after each message bundle
//// representing the end of an image frame
//void refresh(TuioTime bundleTime) { 
//  //redraw();
//}

void captureEvent(Capture video) {
  // Save previous frame for motion detection!!
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); // Before we read the new frame, we always save the previous frame for comparison!
  prevFrame.updatePixels();  // Read image from the camera
  video.read();
}

void keyPressed()
{
  if(key == 's') {
    playing = true;
  } else {
    a.play();
    b.play();
    c.play();
    d.play();
    e.play();
    f.play();
    g.play();
    c.play();
    playing = false;
  }
}
