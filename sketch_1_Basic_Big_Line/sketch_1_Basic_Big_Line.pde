// Draw a line in the middle of the screen long half of the screen
//
// @author Gianluca Romeo
void setup() {
  size(400, 400);
}


float x = 0.0;
float y = 0.0;

void draw() {
  background(21, 21, 21);
  
  int lineLenght = width / 2;
  
  pushMatrix();
  translate(width / 2 - lineLenght / 2, height / 2);
  strokeWeight(40);
  stroke(255, 255, 255);
  line(x, y, lineLenght, y);
  popMatrix();
}
