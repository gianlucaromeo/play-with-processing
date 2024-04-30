void setup() {
  size(820, 820);  
}

int maxLines = 25;

void draw() {
  background(21, 21, 21);
  
  // Fixed number of lines
  int nLines = maxLines;
  
  // Or, dynamically changing the number of lines:
  // int nLines = (frameCount / 4) % maxLines; 
  
  pushMatrix();
  int halfWidth = width / 2;
  int halfHeight = height / 2;
  translate(halfWidth, halfHeight);
  for (int i = 0; i < nLines; i++) {
    // Coordinates for Bottom Right
    int x1 = 0;
    int y1 = (halfHeight / nLines) * i;    
    int x2 = (halfWidth / nLines) * i;
    int y2 = halfHeight;
    
    // TODO: Map coordinates to colors instead of using hardcoded values
    float r = 45;
    float g = 133;
    float b = 99;
    stroke(r, g, b);
    strokeWeight(2);
    
    line(0, -y1, -x2, -y2);// Top Left
    line(0, -y1, x2, -y2);// Top Right
    line(x1, y1, x2, y2); // Bottom Right
    line(x1, y1, -x2, y2); // Bottom Left
  }
  popMatrix();
  
  fill(255);
  textSize(28);
  textAlign(CENTER);
  text("Lines: " + nLines, width/2, height/2);
}
