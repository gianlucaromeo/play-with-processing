import processing.sound.*;

SoundFile sample;
Waveform waveform;

int tiles = 250;
int samples = tiles;

PImage img;

void setup() {
  size(500, 500, P3D);
  
  img = loadImage("image.jpeg");
  img.resize(500, 500);

  sample = new SoundFile(this, "blink.mp3"); // try also "beat.aiff"
  sample.loop();

  waveform = new Waveform(this, samples);
  waveform.input(sample);
}

float b = 0;
float avg = 0;

void draw() {
  background(21);
  fill(200);
  noStroke();
  
  waveform.analyze();
  
  beginShape();
  float t = 0;
  for(int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -1, 1, height-height/4, height)
    );
    
    t += waveform.data[i];
  }
  avg = t / samples;
  endShape();
  
  float tileSize = width / tiles;
  push() ;
  translate(width / 2, height / 2) ;
  rotateY(radians(mouseX)) ;
    
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x * tileSize), int(y * tileSize));
      b = map(brightness(c), 0, 255, 0, 1);
      b = b * map(avg, -0.5, 0.5, -15, 5);
      float z = map(b, 0, 1, -20, 20);
      push();
      translate(x * tileSize - width / 2, y * tileSize - height / 2, z);
      fill(c);
      ellipse(0, 0, tileSize * b, tileSize * b);
      pop();
    }
  }
  pop();
}
