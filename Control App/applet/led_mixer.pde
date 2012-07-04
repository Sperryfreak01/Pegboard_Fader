import processing.serial.*;
import controlP5.*;

ControlP5 controlP5;
RadioButton r;
Textfield RedTextfield;
Textfield GreenTextfield;
Textfield BlueTextfield;
Serial port;

int RLED;
int GLED;
int BLED;
int Rpreset;
int Gpreset;
int Bpreset;
int RadioIndex =0;
int CustomRed = 128;
int CustomGreen = 128;
int CustomBlue = 128;

void setup() {
  size(400, 400);
  frameRate(25);
  smooth();

  controlP5 = new ControlP5(this);

  controlP5.addSlider("REDSLIDER", 0, 255, 128, 25, 75, 35, 255);
  controlP5.controller("REDSLIDER").setColorForeground(color(255, 0, 0));
  controlP5.controller("REDSLIDER").setColorActive(color(255, 0, 0));
  // controlP5.controller("REDSLIDER").setValue(128);

  controlP5.addSlider("GREENSLIDER", 0, 255, 32, 100, 75, 35, 255);
  controlP5.controller("GREENSLIDER").setColorForeground(color(0, 255, 0));  
  controlP5.controller("GREENSLIDER").setColorActive(color(0, 255, 0));
  // controlP5.controller("GREENSLIDER").setValue(128);

  controlP5.addSlider("BLUESLIDER", 0, 255, 32, 175, 75, 35, 255);
  controlP5.controller("BLUESLIDER").setColorForeground(color(0, 0, 255));
  controlP5.controller("BLUESLIDER").setColorActive(color(0, 0, 255));
  //controlP5.controller("BLUESLIDER").setValue(128);   

  RedTextfield = controlP5.addTextfield("R_Value", 25, 360, 45, 20);
  RedTextfield.setFocus(false);
  RedTextfield.setAutoClear(false);
  String str = Integer.toString(CustomRed); 
  RedTextfield.setText(str);

  GreenTextfield = controlP5.addTextfield("G_Value", 100, 360, 45, 20);
  GreenTextfield.setFocus(false);
  GreenTextfield.setAutoClear(false);
  str = Integer.toString(CustomGreen); 
  GreenTextfield.setText(str);

  BlueTextfield = controlP5.addTextfield("B_Value", 175, 360, 45, 20);
  BlueTextfield.setFocus(false);
  BlueTextfield.setAutoClear(false);
  str = Integer.toString(CustomBlue); 
  BlueTextfield.setText(str);

  r = controlP5.addRadioButton("radioButton", 300, 110);
  r.setColorForeground(color(120));
  r.setColorActive(color(255));
  r.setColorLabel(color(255));
  r.setItemsPerRow(1);
  r.setSpacingColumn(50);

  addToRadioButton(r, "Custom", 1);
  addToRadioButton(r, "Red", 2);
  addToRadioButton(r, "Orange", 3);
  addToRadioButton(r, "Yellow", 4);
  addToRadioButton(r, "Green", 5);
  addToRadioButton(r, "Cyan", 6);
  addToRadioButton(r, "Blue", 7);
  addToRadioButton(r, "Magenta", 8);
  addToRadioButton(r, "Violet", 9);
  addToRadioButton(r, "White", 10);
  r.activate(RadioIndex);

  println("Available serial ports:");
  println(Serial.list());
  port = new Serial(this, Serial.list()[1], 9600);
}

void draw() {
  background(0);
  fill(RLED, GLED, BLED);
  rect(25, 10, 185, 50);
  if (RedTextfield.isFocus()) {
    RedTextfield.clear();
  }
  else {
    String str = Integer.toString(RLED); 
    RedTextfield.setText(str);
  }
  if (GreenTextfield.isFocus()) {
    GreenTextfield.clear();
  }
  else {
    String str = Integer.toString(GLED); 
    GreenTextfield.setText(str);
  }
  if (BlueTextfield.isFocus()) {
    BlueTextfield.clear();
  }
  else {
    String str = Integer.toString(BLED); 
    BlueTextfield.setText(str);
  }
}

public void REDSLIDER(int SlidePos) {
  if (RadioIndex == 0) {
    CustomRed = SlidePos;
  } 
  RLED = SlidePos;
  port.write(byte(SlidePos));
  port.write('R');
  String str = Integer.toString(SlidePos); 
  RedTextfield.setText(str);
}

public void GREENSLIDER(int SlidePos) {
  if (RadioIndex == 0) {
    CustomGreen = SlidePos;
  } 
  GLED = SlidePos;
  port.write(byte(SlidePos));
  port.write('G');
  String str = Integer.toString(SlidePos); 
  GreenTextfield.setText(str);
}

public void BLUESLIDER (int SlidePos) {
  if (RadioIndex == 0) {
    CustomBlue = SlidePos;
  }
  BLED = SlidePos;
  port.write(byte(SlidePos));
  port.write('B');
  String str = Integer.toString(SlidePos); 
  BlueTextfield.setText(str);
}

public void R_Value(String theText) {
  // receiving text from controller texting
  println("a textfield event for controller 'texting': "+theText);
  int i = Integer.parseInt(theText);
  if (i > 255) {
    i = 255;
  }
  controlP5.controller("REDSLIDER").setValue(i);
}

public void G_Value(String theText) {
  // receiving text from controller texting
  println("a textfield event for controller 'texting': "+theText);
  int i = Integer.parseInt(theText);
  if (i > 255) {
    i = 255;
  }
  controlP5.controller("GREENSLIDER").setValue(i);
}

public void B_Value(String theText) {
  // receiving text from controller texting

  println("a textfield event for controller 'texting': "+theText);
  int i = Integer.parseInt(theText);
  if (i > 255) {
    i = 255;
  }
  controlP5.controller("BLUESLIDER").setValue(i);
}

void addToRadioButton(RadioButton theRadioButton, String theName, int theValue ) {
  Toggle t = theRadioButton.addItem(theName, theValue);
  t.captionLabel().setColorBackground(color(80));
  t.captionLabel().style().movePadding(2, 0, -1, 2);
  t.captionLabel().style().moveMargin(-2, 0, 0, -3);
  t.captionLabel().style().backgroundWidth = 46;
}

void controlEvent(ControlEvent theEvent) {
  int i = int(+theEvent.group().value());

  switch (i) {
  case 1:
    Rpreset = CustomRed;
    Gpreset = CustomGreen;
    Bpreset = CustomBlue;
    RadioIndex = 0;
    break;
  case 2:    //Red
    Rpreset = 255;
    Gpreset = 0;
    Bpreset = 0;
    RadioIndex = 1;
    break;
  case 3:  //Orange
    Rpreset = 255;
    Gpreset = 92;
    Bpreset = 0;
    RadioIndex = 2;
    break;
  case 4:  //Yellow
    Rpreset = 255;
    Gpreset = 255;
    Bpreset = 0;
    RadioIndex = 3;
    break;
  case 5:   //Green
    Rpreset = 0;
    Gpreset = 255;
    Bpreset = 0;
    RadioIndex = 4;
    break;
  case 6:   //Cyan
    Rpreset = 0;
    Gpreset = 255;
    Bpreset = 255;
    RadioIndex = 5;
    break;
  case 7:   //Blue
    Rpreset = 0;
    Gpreset = 0;
    Bpreset = 255;
    RadioIndex = 6;
    break;
  case 8:   //Magenta
    Rpreset = 255;
    Gpreset = 0;
    Bpreset = 255;
    RadioIndex = 7;
    break;
  case 9:    //Violet
    Rpreset = 128;
    Gpreset = 0;
    Bpreset = 255;
    RadioIndex = 8;
    break;
  case 10:    //White
    Rpreset = 255;
    Gpreset = 255;
    Bpreset = 255;
    RadioIndex = 9;
    break;
  }
  controlP5.controller("REDSLIDER").setValue(Rpreset);
  controlP5.controller("GREENSLIDER").setValue(Gpreset);
  controlP5.controller("BLUESLIDER").setValue(Bpreset);
}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == UP) {
      if (RadioIndex == 0) { 
        RadioIndex = 10;
      }
      else RadioIndex --;
      r.activate(RadioIndex);
    } 
    else if (keyCode == DOWN) {
      if (RadioIndex == 9) { 
        RadioIndex = 0;
      }
      else RadioIndex ++;
      r.activate(RadioIndex);
    }
  }
}

