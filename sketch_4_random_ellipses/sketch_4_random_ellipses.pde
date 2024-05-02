void setup() {
  size(650, 650);
}

void draw() {
  background(0);
  fill(0);
  
  float velocity = frameCount * 1.0;
  
  float w = width;
  float hw = width/2;
  float h = height;
  float hh = height/2;
  
  for (int i = 0; i < 35; i++) {
    float ellipseWidth = map(sin(radians(velocity)), -1, 1, -hw, hw);
    float ellipseHeight = map(sin(radians(velocity)), -1, 1, -hh, hh);
    
    float r = 200;
    float g = 20;
    float b = 120;
    stroke(r, g, b);
    strokeWeight(4);
    noFill();
    
    ellipse(
      hw, 
      hh, 
      ellipseWidth - i * cos(radians(velocity)) * 120, 
      ellipseHeight - i * cos(radians(velocity)) * 120
    );
  }
}
