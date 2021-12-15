import g4p_controls.*;

PImage botpic;

int botNum;
int plastNum; 

int plastored;

float cellsize;

float pollutionChance;

boolean buttonPressed = false;


  String name;
  boolean[][] pollution;


  bot Clenser;


int n = 100;
float padding = 50;
float CPS = 10;
boolean[][] cells, cellsNext, Land, reg, cleanserbot,ocean;



float cellSize;



color[][] temp;
int genCount = 0;

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
  
  plastored = 1;
  plastNum = round(random(20,50));
  botNum = round(random(1,3));
  createGUI();
  xb = 0;
  noStroke();
  size(1000, 700);   
  frameRate( CPS);
  
  image = loadImage("NA.png");
  image(image, -500, -300);
 
  ocean = new boolean[height][width];
  Land = new boolean[height][width];
  pollution = new boolean[n][n];
  cellscol = new color[n][n];
  cellscolNext = new color[n][n];
  temp = new color[n][n];
  loadPixels();
  getpix();


  cellSize = (width-2*padding)/n;
  cells = new boolean[n][n];
  cellsNext = new boolean[n][n];
  //setCellValuesRandomly();
  //setCellValuesAlternating();
  
  for (int c = 0; c < botNum; c++){
    Clenser = new bot(100);
  }
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

             
             
            }
          }
        
          else {
            
            if (cellscolNext[i][j] == color(255, 165, 0)) {
              fill(color(255, 165, 0));
             
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
             if   (pollution[i][j] == true) {
             fill(color(128,98,90));
             

              rect(x, y, cellSize, cellSize);
           }
        }
        catch(Exception e) {
          
        }
      }

      y += cellSize;
    }


    genCount++;
   
    if (ontouchedd) {
      ontouched();
    }
   
    if (savestate) {
      savestates();
    }
    
    
    copyNextGenerationToCurrentGeneration();
    
    Clenser.moveBot();
    Clenser.storage();
  }
}
int x = 0;
boolean savestate;
void savestates() {
              
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
  plasticGeneration();
  
  updatePixels();
}




 
void plasticGeneration() {

  for (int i=40; i<70;i++) {
    for (int j=20; j<50;j++){
       float rand = random(0,1);
       
       float convert = pollutionChance/100;
       if (rand<convert){    //This is where we need to put in the option to change probability of plastic generation in the GUI 
         pollution[i][j] = true;
      }
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
void loadIndianOcean() {
 
  
  image = loadImage("IndianOcean.jpg");
    image(image, -100, -200);
  
}
void loadArcticOcean() {
  image = loadImage("ArcticOcean.jpg");
    image(image, -100, -200);
  
}
void loadPacificOcean() {
  image = loadImage("NA.png");
    image(image, -550, -300);
  
}
void loadAtlanticOcean() {
  image = loadImage("AtlanticOcean.jpg");
    image(image, 300, 0);
    
  
}
void resetLand() {
  for (int i = 0; i <n; i++) {
    for (int j = 0; j<n;j++) {
       //float x = padding + j*cellSize;
       //float y = padding;
       //fill(color(255, 165, 0));


       //rect(x, y, cellSize, cellSize);
      Land[i][j] = false;
      ocean[i][j] = false;
      
      
    }
}
 redraw();
}
void reset(){
  Clenser = new bot(100);
  plastNum = 0;
  botNum = 1;
  
  for (int i=40; i<70;i++) {
    for (int j=20; j<50;j++){
      pollution[i][j] = false;
    }
  }
  plasticGeneration();
 
}

void removePol(){
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
     pollution[i][j] = false;
    }
  }
}
