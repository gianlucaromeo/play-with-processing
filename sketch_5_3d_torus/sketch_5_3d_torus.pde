void setup() {
  size(550, 550, P3D);
}

float r1 = 200;
float r2 = 35;
int numPoints = 120;

void draw() {
  background(21);
  translate(width/2, height/2);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  
  for (int i = 0; i < numPoints; i++) {
    float phi = map(i, 0, numPoints, 0, TWO_PI);
    for (int j = 0; j < numPoints; j++) {
      float theta2 = map(j, 0, numPoints, 0, TWO_PI);
      float x = (r1 + r2 * cos(theta2)) * cos(phi);
      float y = r2 * sin(theta2);
      float z = (r1 + r2 * cos(theta2)) * sin(phi);
      stroke(20, 255, 255);
      point(x, y, z);
    }
  }
}
