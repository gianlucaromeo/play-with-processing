import processing.sound.*;

SoundFile sample;
Waveform waveform;

int tiles = 250;
float tileSize = 500 / tiles;

int samples = tiles;

PImage img;

float distorsion = 7.0;
float yRotation = 0.0;

void setup() {
  size(500, 500, P3D);
  
  img = loadImage("image.jpeg");
  img.resize(500, 500);
  
  sample = new SoundFile(this, "blink.mp3"); // try also "beat.aiff"
  sample.loop();

  waveform = new Waveform(this, samples);
  waveform.input(sample);
  
  strokeWeight(1);
}

float avg = 0;
boolean showStroke = false;
void draw() {
  background(0);
  
  if (showStroke) {
    stroke(0);
  } else {
    noStroke();
  }
  
  waveform.analyze();
  
  // Draw the waves
  beginShape();
  float t = 0; // Total waves to calculate the average
  for(int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -1, 1, height-height/4, height)
    );
    t += waveform.data[i];
  }
  avg = t / samples; // Average waves value
  endShape();
  
  tileSize = 500.0 / tiles; // tiles can change from inputs
  
  println("tiles: " + tiles + ", tileSize: " + tileSize);
  
  push() ;
  translate(width / 2, height / 2) ;
  rotateY(radians(yRotation));
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x * tileSize), int(y * tileSize)); // color of that pixel
      float b = map(brightness(c), 0, 255, 0, 1); // Brightness
      b = b * map(avg, -0.5, 0.5, -distorsion, 5); // Or: -15, 5
      float z = map(b, 0, 1, -20, 20);
      push();
      translate(
        x * tileSize - width / 2,
        y * tileSize - height / 2, 
        z
      );
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
    
    // STROKE
    else if (key == 's') {
      showStroke = !showStroke;
    }
}
