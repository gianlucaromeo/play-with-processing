void setup() {
  size(650, 650);  
}

int maxLines = 50;

void draw() {
  background(21, 21, 21);
  
  int nLines = (frameCount / 4) % maxLines;
  for (int i = 0; i < nLines; i++) {
    int x1 = 0;
    int y1 = (height / nLines) * i;    
    int x2 = (width / nLines) * i;
    int y2 = height;
    
    // TODO: Map coordinates to colors instead of using hardcoded values
    float r = 45;
    float g = 133;
    float b = 99;
    stroke(r, g, b);
    strokeWeight(0.85);
    
    line(x1, y1, x2, y2);
  }
  
  fill(255);
  textSize(28);
  textAlign(CENTER);
  text("Lines: " + nLines, width/2, height/2);
}
