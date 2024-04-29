// A basic big line to get started with Processing
void setup() {
  size(400, 400);
}


float x = 0.0;
float y = 0.0;


void draw() {
  background(21, 21, 21);
  
  int lineLenght = width / 2; // Line is long half of the width of the screen
  
  // Draw a line in the middle of the screen of length [length]
  pushMatrix();
  translate(width / 2 - lineLenght / 2, height / 2);
  strokeWeight(40);
  stroke(255, 255, 255);
  line(x, y, lineLenght, y);
  popMatrix();
}
