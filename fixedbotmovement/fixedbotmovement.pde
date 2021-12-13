boolean plastics[][]; //Well, Icicles :);
int NumberOfRowsAndColumn = 100; //Number of [i] and [j];
float botSize; //Size Of Icicle;
int padding = 0; //The padding;
float moving = 0.99; 
float SpeedOfAnimation = 20.0; 
int movementDirection;


color[][] cells = new color[NumberOfRowsAndColumn][NumberOfRowsAndColumn]; //Each square on the grid
color[][] cellsNext = new color[NumberOfRowsAndColumn][NumberOfRowsAndColumn]; // The next generation of squares related to the previous cell 

color botColour = color(255);
color BackGroundColour = color (0,255,0);

void setup() {

  size(600, 600);
  frameRate(SpeedOfAnimation);
  noStroke();

  botSize = (width-2*padding)/NumberOfRowsAndColumn;
  plantFirstgeneration();
}



void draw() {

  background(BackGroundColour);
  float y1 = padding;  // Value for y1

  for (int i = 0; i < NumberOfRowsAndColumn; i++ ) { //nested for loop part 1
    for (int j=0; j< NumberOfRowsAndColumn; j++) { //nested for loop part 2
      float x1 = padding + j*botSize;  // value of x1
      fill( cells[i][j] ); // colour of cells 
      square(x1, y1, botSize); // size of squares (cells)
    }
    y1 += botSize; // value of y1 increasing of IcicleSize
  }

  setNextGen(); 
  copyNextGenIntoCurrentGen();
  IdentifyBots(); //
}



void plantFirstgeneration() {


  for (int i = 10; i<NumberOfRowsAndColumn-10; i++) {
    for (int j = 60; j<NumberOfRowsAndColumn-10; j++) {

      float r = random(0, 1);

      if (r <= 0.005) {

        cells [i][j] = botColour;
      }
    }
  }
}


void IdentifyBots() {


  for (int i=0; i<NumberOfRowsAndColumn; i++) {

    for (int j = 0; j<NumberOfRowsAndColumn; j++) {

      if (cells [i][j] == botColour) {
      }
    }
  }
}
void setNextGen () {

 for (int i = 0; i < NumberOfRowsAndColumn; i++) {
    for (int j = 0; j < NumberOfRowsAndColumn; j++) {

       
      if (cells[i][j] != botColour ) {
        if ( cellsNext[i][j] != botColour )
          cellsNext[i][j] = cells[i][j];
      } 
      
      else {
        try {if ( i <= NumberOfRowsAndColumn - 2 )
        
        

          cellsNext[i + 1][j+1] = botColour;

        cellsNext[i][j] = BackGroundColour;
        }
        catch(Exception e) {
          
        }
        
        
      }
    }
  }
}

void copyNextGenIntoCurrentGen() {
  for (int i = 0; i<NumberOfRowsAndColumn; i++) {      
    for (int j = 0; j<NumberOfRowsAndColumn; j++) {            
      cells[i][j] = cellsNext[i][j];
    }
  }
}
