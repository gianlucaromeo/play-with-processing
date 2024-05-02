PImage img;

int SIZE = 1020; // Screen size
int ROW = 40; // Number of element in row
int COL = 40; // Number of element in column
int PADDING = 12; // External space
int PIECE_SIZE = SIZE / ROW - PADDING; // Size of every rectangle piece of image

void setup() {
  size(1020, 1020);
  img = loadImage("programming.jpeg");
  img.resize(ROW * PIECE_SIZE, COL * PIECE_SIZE);
}

void draw() {
  background(0);
  fill(0);
  
  float velocity = frameCount*0.9;
  
  for (int i = 0; i < ROW; i++) {
    for (int j = 0; j < COL; j++) {
      int x = (i * PIECE_SIZE);
      int y = (j * PIECE_SIZE);
      PImage pieceImg = img.get(x, y, PIECE_SIZE, PIECE_SIZE);
      push();
        float tx = - (ROW * PIECE_SIZE / 2) + x + (PIECE_SIZE / 2);
        float ty = - (COL * PIECE_SIZE / 2) + y + (PIECE_SIZE / 2);
        translate(width/2 + tx, height/2 + ty);
        rotate(sin(radians(velocity)));
        image(pieceImg, 0, 0);
      pop();
    }
  }
}
