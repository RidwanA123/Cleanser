import g4p_controls.*;

PImage botpic;

boolean buttonPressed = false;


  String name;
  float pollution;


  bot Clenser;
  bot rob;


 int n = 100;
float padding = 50;
float CPS = 10;
boolean[][] cells, cellsNext, Land, reg, radiation, NATOstate, cleanserbot, NATO;

int[][] nukestage = new int[n][n];

float cellSize;
float probofspreadexplosion = 1;
int radiationlimit = 10; 
float radiationprobability = 0.9;
int natoblastradius = 40;
int comblastradius = 40;
int natospreadspeed = 30;
int comspreadspeed = 30;
int natospeed = 5;    
int comspeed = 5;
color[][] NATO3;
boolean mswitch = false;
String misstype;
color[][] temp;
int genCount = 0;
int blastLimit = 4;
boolean state[][];

int xb = 0;

int[][] xSpeeds = new int[n][n];
int[][] xSpeedsNext = new int[n][n];

int[][] ySpeeds = new int[n][n];
int[][] ySpeedsNext = new int[n][n];
color[][] cellscolNext;
color[][] cellscol;
boolean ontouchedd;

PImage image;  
void setup() {
  createGUI();
  xb = 0;
  size(1100, 800);  
  //noStroke();
  frameRate( CPS);

  image = loadImage("NA.png");
  image(image, -400, 0);
  NATOstate = new boolean[n][n];
  cleanserbot = new boolean[n][n];
  NATO = new boolean[height][width];
  radiation = new boolean[n][n];
  ocean = new boolean[height][width];
  Land = new boolean[height][width];
  NATO3 = new color[n][n];
  cellscol = new color[n][n];
  cellscolNext = new color[n][n];
  temp = new color[n][n];
  loadPixels();
  getpix();



  //noStroke();

  cellSize = (width-2*padding)/n;
  cells = new boolean[n][n];
  cellsNext = new boolean[n][n];
  //setCellValuesRandomly();
  //setCellValuesAlternating();
}


void draw() {
  background(0, 0, 255);    
  float y = padding;

  if (true) {

    for (int i=0; i<n; i++) {

      for (int j=0; j<n; j++) {

        float x = padding + j*cellSize;


        try {     
         
       
           if ( (Land[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (Land[int(y)][int(x)]) || (Land[int(y+cellSize)][int(x)]) || (Land[int(y)][int(x+cellSize)]) || (Land[int(y+cellSize)][int(x+cellSize)]) ) {
           
            if (cellscolNext[i][j] == color(255, 165, 0)) {
              fill(color(255, 165, 0));
             

              rect(x, y, cellSize, cellSize);
            } 
           
            else if (cellscolNext[i][j] == color(0, 255, 0)) {
              fill(color(0, 255, 0));



              rect(x, y, cellSize, cellSize);
             }
             else {
           
              fill(104,189,86);

              rect(x, y, cellSize, cellSize);
              coloursetter(i, j, 1);  



              cleanserbot[i][j] = true;
            }
          } else if ( (ocean[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (ocean[int(y)][int(x)]) || (ocean[int(y+cellSize)][int(x)]) || (ocean[int(y)][int(x+cellSize)]) || (ocean[int(y+cellSize)][int(x+cellSize)]) ) {
         
            if (cellscolNext[i][j] == color(255, 165, 0)) {
              fill(color(255, 165, 0));


              rect(x, y, cellSize, cellSize);
            } 
           
            //else if (cellscolNext[i][j] == color(0, 255, 0)) {
            //  fill(color(0, 255, 0));



            //  rect(x, y, cellSize, cellSize);
            // }
             else {
              fill(0, 120, 255);                          //land
              
              rect(x, y, cellSize, cellSize);

              coloursetter(i, j, 1);
             
            }
          } else {
           
            if (cellscolNext[i][j] == color(255, 165, 0)) {
              fill(color(255, 165, 0));
             
              rect(x, y, cellSize, cellSize);
            } 
            else  if (radiation[i][j]) {
              fill(color(0, 255, 0));



              rect(x, y, cellSize, cellSize);
            }
            else if (cellscolNext[i][j] == color(0, 255, 0)) {
              fill(color(0, 255, 0));



              rect(x, y, cellSize, cellSize);
             }
             else {
              fill(0, 0, 255);

              rect(x, y, cellSize, cellSize);
            }
          }
        }
        catch(Exception e) {
          
        }
      }

      y += cellSize;
    }


    genCount++;
    setNextGeneration();
    if (ontouchedd) {
      ontouched();
    }
   
    if (savestate) {
      savestates();
    }
    copyNextGenerationToCurrentGeneration();
     fireFirstMissile();
  
  }
}
int x = 0;
boolean savestate;
void savestates() {
              
}

void fireFirstMissile() {
   for (int i=0; i<n; i++) 
      for (int j=0; j<n; j++) {
        if (genCount > x && cleanserbot[i][j] == true && mswitch == false) {
          mswitch = true;
          cellscol[i][j] = color(255, 165, 0);
          misstype = "Cuba";
          xSpeeds[i][j] = -2;
          ySpeeds[i][j] = -2;
          x = x + 50;
        }
        if (genCount > x && mswitch == true ) {
          if (NATOstate[i][j] == true) {
          mswitch = false;
          cellscol[i][j] = color(255, 165, 0);
          misstype = "NATO";
          xSpeeds[i][j] = 1;
          ySpeeds[i][j] = 1;
           x = x + 70;
          }
        }
      }
}
void setNextGeneration() {
  scrubNext(); 

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {

      int sx = xSpeeds[i][j];
      int sy = ySpeeds[i][j];


      if (cellscol[i][j] == color(255, 165, 0)) {
        try {
          int iNext = i + sy;
          int jNext = j + sx;
          cellscolNext[iNext][jNext] = color(255, 165, 0); 
          xSpeedsNext[iNext][jNext] = sx;
          ySpeedsNext[iNext][jNext] = sy;

          // println(genCount);

          cellscolNext[iNext][jNext] = color(255, 165, 0); 
          xSpeedsNext[iNext][jNext] = sx;
          ySpeedsNext[iNext][jNext] = sy;
          if (cleanserbot[iNext][jNext] == true && misstype == "NATO") {
            float x = int(random(1, 2));
            if (x == 1) {

              misstype = "";
              cleanserbot[iNext][jNext] = false;
              cellscol[i][j] = color(255, 165, 0);
              cellscolNext[iNext][jNext] = color(255, 165, 0);
              temp[i][j] = cellscolNext[i][j];
              ontouched();
              ontouchedd = true;
            }
          } else if (NATOstate[iNext][jNext] == true && misstype == "Cuba") {
            println("OK");
            float x = int(random(1, 5));
            println("val is", x);
            if (x == 1) {

              misstype = "";
              ontouched();
              ontouchedd = true;

           
              cellscol[i][j] = color(255, 165, 0);
              cellscolNext[iNext][jNext] = color(255, 165, 0);
              temp[i][j] = cellscolNext[i][j];
              print(temp[i][j]);
            }
          } else {
          }
        }



        catch( Exception e) {


          xSpeedsNext[i][j] = 0;
          ySpeedsNext[i][j] = 0;
        }
      }
    }
  }
}


void secondstate() {
  
         
    


}

void ontouched() {

}

int countAliveNeighbours(int i, int j) {
  int count = 0;

  for (int a = -1; a <= 1; a++) {  //a=-1, a = 0, a = 1
    for (int b = -1; b <= 1; b++) {  //b=-1, b=0,   b=1

      try {
        if (cellscol[i+a][j+b] ==  color(255, 165, 0) && !(a==0 && b==0))
          count++;
      }

      catch( IndexOutOfBoundsException e ) {
      }
    }
  }

  return count;
}
void scrubNext() {  
  cellscolNext = new color[n][n];
  xSpeedsNext = new int[n][n];
  ySpeedsNext = new int[n][n];
}




void getpix() {
  loadPixels();
  for (int i = 0; i < height; i++) {
    for (int b = 0; b < width; b++) {
      if (pixels[width*i+b] != (-3355444)) {

        //println(pixels[width*i+b]);
      }
      if (pixels[width*i+b] == -1212415) {


        Land[i][b] = false;
        ocean[i][b] = false;
      } else if (pixels[width*i+b] == color(255)) {

        Land[i][b] = false;
        ocean[i][b] = true;
      } else if (pixels[width*i+b] == color(0)) {
  
        ocean[i][b] = false;
        Land[i][b] = true;
      }
    }
  }
  updatePixels();
}



void coloursetter(int r, int c, int type) {

  if (nukestage[r][c] == 1) {     // Orange 
    fill(255, 165, 0);
  }
  if (type == 1) {
    fill(0, 255, 0);
  }
}

void plantFirstGeneration() {
  for (int i=0; i<n; i++) 
    for (int j=0; j<n; j++) {
      if (cleanserbot[i][j] == true && mswitch == false) {
        mswitch = true;
        cellscol[i][j] = color(255, 165, 0);
        misstype = "Cuba";
        xSpeeds[i][j] = 2;
        ySpeeds[i][j] = 2;
      }
    }
}
void copyNextGenerationToCurrentGeneration() {
  for (int i=0; i<n; i++) 
    for (int j=0; j<n; j++) {
      cellscol[i][j] = cellscolNext[i][j];
      xSpeeds[i][j] = xSpeedsNext[i][j];
      ySpeeds[i][j] = ySpeedsNext[i][j];
    }
}
