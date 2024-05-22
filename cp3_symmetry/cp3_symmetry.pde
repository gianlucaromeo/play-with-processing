// Shapes: Line, Square, Rectangle, Ellipse, Circle
// Colors
// Number of shapes
// Rotation

final int N_SHAPES = 9;

String name;
String vowels = "aeiouAEIOU";

ArrayList<int[]> colorPairs = new ArrayList<int[]>() {
  {
    add(new int[] {0xFF1a1a1d, 0xFFc3073f}); // Dark grey and bright red
    add(new int[] {0xFF003366, 0xFFffffff}); // Navy blue and white
    add(new int[] {0xFF000000, 0xFFff00ff}); // Black and magenta
    add(new int[] {0xFF000080, 0xFFffff00}); // Navy blue and yellow
    add(new int[] {0xFF2c3e50, 0xFFecf0f1}); // Midnight blue and light grey
    add(new int[] {0xFF34495e, 0xFFe74c3c}); // Dark blue-grey and red
    add(new int[] {0xFF1abc9c, 0xFF2c3e50}); // Teal and dark blue-grey
    add(new int[] {0xFF2ecc71, 0xFFe74c3c}); // Bright green and red
    add(new int[] {0xFF2980b9, 0xFFecf0f1}); // Blue and light grey
    add(new int[] {0xFF8e44ad, 0xFFecf0f1}); // Purple and light grey
    add(new int[] {0xFFd35400, 0xFFecf0f1}); // Orange and light grey
    add(new int[] {0xFFc0392b, 0xFFecf0f1}); // Red and light grey
    add(new int[] {0xFF2c3e50, 0xFFbdc3c7}); // Dark blue-grey and silver
    add(new int[] {0xFF7f8c8d, 0xFFecf0f1}); // Grey and light grey
    add(new int[] {0xFF95a5a6, 0xFF2c3e50}); // Light grey and dark blue-grey
    add(new int[] {0xFFffffff, 0xFFe74c3c}); // White and red
    add(new int[] {0xFFecf0f1, 0xFF2c3e50}); // Light grey and dark blue-grey
    add(new int[] {0xFFffffff, 0xFF2980b9}); // White and blue
    add(new int[] {0xFF34495e, 0xFFecf0f1}); // Dark blue-grey and light grey
    add(new int[] {0xFF2c3e50, 0xFFffffff}); // Dark blue-grey and white
  }
};

ArrayList<String> allNames = new ArrayList<String>() {
  {
    add("Caitlin Wong Yu-Lin");
    add("Pablo San Gregorio de Lucas");
    add("Matthijs Dethmers");
    add("Hezheng Hao");
    add("José Iglesias Martínez");
    add("Damian Kagenaar");
    add("Luukas Kiviniemi");
    add("Gracy Nedev");
    add("Lisemijn Presser");
    add("Sascha Reker");
    add("Evana Reuvers");
    add("Gianluca Romeo");
    add("Alma Schaafstal");
    add("Lina Stenstrom");
    add("Wouter Stoter");
    add("Matthias Wentink");
    add("Thijs van Zeijts");
  }
};

int SECTIONS = 4;

boolean isVowel(char c) {
  return vowels.indexOf(c) >= 0;
}

int nVowels(String str) {
  int n = 0;
  for (int i = 0; i < str.length(); i++) {
    char c = str.charAt(i);
    n += isVowel(c) ? 1 : 0;
  }
  return n;
}

int nConsonants(String str) {
  return str.length() - nVowels(str);
}

int getSectionsBasedOnLength(int length) {
  int[] validSections = {4, 6, 8, 10, 12, 14, 16, 18}; // Valid section counts
  int index = length % validSections.length; // Use length to find the index
  return validSections[index];
}

void setup() {
  size(700, 700);
  smooth();
  //noLoop();
}

int colorIndex = 0;
int nameIndex = 0;

void draw() {
  if (frameCount % 200 == 1) {
    colorIndex++;
    if (colorIndex >= colorPairs.size()) {
      colorIndex = 0;
    }

    color bgColor = colorPairs.get(colorIndex)[0];
    background(bgColor); // Set background color

    nameIndex++;
    if (nameIndex >= allNames.size()) {
      nameIndex = 0;
    }
    name = allNames.get(nameIndex);

    // Set pixel color to create grain effect
    loadPixels();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {

        // Extract the red, green, and blue components from the background color
        float r = red(bgColor);
        float g = green(bgColor);
        float b = blue(bgColor);

        // Apply random noise to each color component
        r += random(-20, 20);
        g += random(-20, 20);
        b += random(-20, 20);

        // Ensure the values stay within valid RGB range
        r = constrain(r, 0, 255);
        g = constrain(g, 0, 255);
        b = constrain(b, 0, 255);

        // Set the pixel color
        pixels[x + y * width] = color(r, g, b);
      }
    }
    updatePixels(); // Update the canvas with the modified pixels
  }

  SECTIONS = getSectionsBasedOnLength(name.length());

  int parts = constrain(name.length(), 0, 14); // Number of shapes per section
  float size = name.length(); // size of one single shape
  int shape = ((name.length()) % N_SHAPES) + 1;
  
  boolean showDouble = nVowels(name) % 2 == 0;
  boolean showCenter = nConsonants(name) % 2 == 0;
  
  int shapeColor = colorPairs.get(colorIndex)[1];
  stroke(shapeColor);
  fill(shapeColor, 1);
  strokeWeight(0.5);

  for (int r = 1; r <= SECTIONS / 2; r++) {
    for (int c = 1; c <= SECTIONS / 2; c++) {
      pushMatrix();
      translate(
        width / (SECTIONS / 2) * (r - 1) + (width / SECTIONS),
        height / (SECTIONS / 2) * (c - 1) + (height / SECTIONS)
        );

      if (showCenter) ellipse(0, 0, size, size);

      for (int i = 0; i < parts; i++) {
        pushMatrix(); // Save the current transformation matrix
        rotate(i * TWO_PI / parts);

        int yOffset = name.length() * nVowels(name);
        float x = 0;
        float y = yOffset;

        switch(shape) {
        case 1:
          // Square
          rect(x, y, size, size);
          if (showDouble) rect(x-(size/2), y-(size/2), size, size);
          break;
        case 2:
          // Line
          line(x, y, size, size);
          if (showDouble) line(x-(size/2), y-(size/2), size, size);
          break;
        case 3:
          // Rectangle
          rect(x, y, size, size*3);
          if (showDouble) rect(x-(size/2), y-(size/2), size, size*3);
          break;
        case 4:
          // Circle
          ellipse(x, y, size, size);
          if (showDouble) ellipse(x-(size/2), y-(size/2), size, size);
          break;
        case 5:
          // Ellipse
          ellipse(x, y, size, size*3);
          if (showDouble) ellipse(x-(size/2), y-(size/2), size, size*3);
          break;
        case 6:
          // Arc
          float start = PI / 4;    // Start angle in radians
          float stop = PI + PI / 4; // Stop angle in radians
          arc(x, y, size*2, size*2, start, stop);
          if (showDouble) arc(x-(size/2), y-(size/2), size*2, size*2, -PI, 0);
          break;
        case 7:
          // Triangle
          float x1 = x;
          float y1 = y - size;
          float x2 = x - size / 2;
          float y2 = y + size / 2;
          float x3 = x + size / 2;
          float y3 = y + size / 2;
          triangle(x1, y1, x2, y2, x3, y3);
          if (showDouble) triangle(x1-(size/2), y1-(size/2), x2-(size/2), y2-(size/2), x3-(size/2), y3-(size/2));
          break;
        case 8:
          // Quad
          float qx1 = x;
          float qy1 = y;
          float qx2 = x + size;
          float qy2 = y;
          float qx3 = x + size;
          float qy3 = y + size;
          float qx4 = x;
          float qy4 = y + size;
          quad(qx1, qy1, qx2, qy2, qx3, qy3, qx4, qy4);
          if (showDouble) quad(qx1-(size/2), qy1-(size/2), qx2-(size/2), qy2-(size/2), qx3-(size/2), qy3-(size/2), qx4-(size/2), qy4-(size/2));
          break;
        case 9:
          // Bezier Curve
          float bx1 = x;
          float by1 = y;
          float cx1 = x + size;
          float cy1 = y - size;
          float cx2 = x + size * 2;
          float cy2 = y + size;
          float bx2 = x + size * 3;
          float by2 = y;
          bezier(bx1, by1, cx1, cy1, cx2, cy2, bx2, by2);
          if (showDouble) bezier(bx1-(size/2), by1-(size/2), cx1-(size/2), cy1-(size/2), cx2-(size/2), cy2-(size/2), bx2-(size/2), by2-(size/2));
          break;
        }
        popMatrix(); // Restore the previous transformation matrix
      }
      popMatrix(); // Section
    }
  }

  fill(shapeColor);
  textAlign(CENTER, CENTER);
  text(name, width / 2, height - 10);
}
