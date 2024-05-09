void setup() {
  size(550, 550, P3D);
}

float r1 = 200;
float r2 = 50;
int numPoints = 100;

void draw() {
  background(21);
  translate(width/2, height/2);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  
  for (int i = 0; i < numPoints; i++) {
    float theta1 = map(i, 0, numPoints, 0, TWO_PI);
    float x1 = r1 * cos(theta1);
    float z1 = r1 * sin(theta1);
    
    for (int j = 0; j < numPoints; j++) {
      float theta2 = map(j, 0, numPoints, 0, TWO_PI);
      float x = (r1 + r2 * cos(theta2)) * cos(theta1);
      float y = r2 * sin(theta2);
      float z = (r1 + r2 * cos(theta2)) * sin(theta1);
      
      float hue = map(sqrt(sq(x) + sq(y) + sq(z)), 0, sqrt(sq(width/2) + sq(height/2)), 0, 255);
      stroke(hue, 255, 255);
      point(x, y, z);
    }
  }
}
