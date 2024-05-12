import processing.sound.*;

SoundFile sample;
Waveform waveform;

int tiles = 250;
float tileSize = 500 / tiles;

int samples = tiles;

PImage img;

float distorsion = 15.0;
float yRotation = 0.0;

void setup() {
  size(500, 500, P3D);
  
  img = loadImage("image.jpeg");
  img.resize(500, 500);
  
  sample = new SoundFile(this, "blink.mp3"); // try also "beat.aiff"
  sample.loop();

  waveform = new Waveform(this, samples);
  waveform.input(sample);
}

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
  
  tileSize = 500.0 / tiles;
  
  println("tiles: " + tiles + ", tileSize: " + tileSize);
  push() ;
  translate(width / 2, height / 2) ;
  rotateY(radians(yRotation));
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x * tileSize), int(y * tileSize));
      float b = map(brightness(c), 0, 255, 0, 1);
      b = b * map(avg, -0.5, 0.5, -distorsion, 5); // Or: -15, 5
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

void keyPressed() {
    // ROTATION
    if (keyCode == LEFT) {
      yRotation -= 20;
    } else if (keyCode == RIGHT) {
      yRotation += 20;
    } 
    
    // TILES
    else if (keyCode == UP) {
      tiles += 25;
    } else if (keyCode == DOWN && tiles > 25) {
      tiles -= 25;
    }
    
    // DISTORSION
    else if (key == 'a') {
      distorsion -= 1;
    } else if (key == 'd') {
      distorsion += 1;
    }
}
