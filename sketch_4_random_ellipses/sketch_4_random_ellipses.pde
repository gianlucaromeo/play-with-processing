void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  fill(0);
  
  float velocity = frameCount * 0.4;
  float w = width;
  float hw = width/2;
  float h = height;
  float hh = height/2;
  
  for (int i = 0; i < 15; i++) {
    float ellipseWidth = map(sin(radians(velocity)), -1, 1, hw, w);
    float ellipseHeight = map(sin(-radians(velocity)), -1, 1, hh, h);
    
    float r = 255 % (i+1);
    float g = i * 10;
    float b = 200;
    stroke(r, g, b);
    strokeWeight(3);
    noFill();
    
    ellipse(
      hw, 
      hh, 
      ellipseWidth - i * cos(radians(velocity)) * 100, 
      ellipseHeight - i * sin(radians(velocity)) * 50
    );
  }
}
