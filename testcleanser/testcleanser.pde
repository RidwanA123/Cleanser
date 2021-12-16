import g4p_controls.*;

PImage botpic;

int botNum;
int plastNum; 

int plastored;

float cellsize;

float pollutionChance;
boolean b;

boolean buttonPressed = false;



  boolean[][] pollution;


  bot Clenser;


int n = 100;
float padding = 0;
float CPS = 60;
boolean[][] land, boundary,ocean,base,landBlock,oceanBlock,baseBlock;
//land maps all cell positions of where the country will be
//boundary sets the boundary for where plastic shoudn't be
//ocean sets the cell states of where the ocean will be
//base sets the cell states of where the base will be




float cellSize;
float[][] plasticX = new float[n][n];
float[][] plasticY = new float[n][n];



int genCount = 0;

boolean state[][];



boolean ontouchedd;

PImage image;  

void setup() {
  noStroke();
  size(1000, 700);   
  frameRate( CPS);
  restart();
  
  
}

void restart() {
 plastored = 1;
  plastNum = round(random(20,50));
  botNum = round(random(1,3));
  createGUI();

  
  
  image = loadImage("NA.png");
  image(image, -500, -300);
 
  ocean = new boolean[height][width];
  land = new boolean[height][width];
  base = new boolean[height][width];
  oceanBlock = new boolean[n][n];
  landBlock = new boolean[n][n];
  baseBlock = new boolean[n][n];
  pollution = new boolean[n][n];
  loadPixels();
  getpix();



  cellSize = (width-2*padding)/n;

 
  //setCellValuesRandomly();
  //setCellValuesAlternating();
  cMap();
  for (int c = 0; c < botNum; c++){
     
    Clenser = new bot(100);
  }
 
}
void draw() {
  background(0, 0, 255);    
    cMap();
    Clenser.moveBot();
    Clenser.storage();
  }

int x = 0;
boolean savestate;
void savestates() {
              
}


void cMap() {  
  float y = padding;
  if (true) {

    for (int i=0; i<n; i++) {

      for (int j=0; j<n; j++) {

        float x = padding + j*cellSize;


        try {     
         
          
           if ( (land[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (land[int(y)][int(x)]) || (land[int(y+cellSize)][int(x)]) || (land[int(y)][int(x+cellSize)]) || (land[int(y+cellSize)][int(x+cellSize)]) ) {
           
           
             
           
              fill(104,189,86);                      //land

              rect(x, y, cellSize, cellSize);
              


              landBlock[i][j] = true;
              boundary[i][j] = true;
              
        
          } 
           else if ( (base[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (base[int(y)][int(x)]) || (base[int(y+cellSize)][int(x)]) || (base[int(y)][int(x+cellSize)]) || (base[int(y+cellSize)][int(x+cellSize)]) ) {
         
          
           
            
          
              fill(211, 211, 211);                          //base
              
              rect(x, y, cellSize, cellSize);

              baseBlock[i][j] = true;
              boundary[i][j] = true;
             
            
          }else if ( (ocean[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (ocean[int(y)][int(x)]) || (ocean[int(y+cellSize)][int(x)]) || (ocean[int(y)][int(x+cellSize)]) || (ocean[int(y+cellSize)][int(x+cellSize)]) ) {
         
           
            
              fill(0, 120, 255);                          //ocean
              
              oceanBlock[i][j] = true;
              rect(x, y, cellSize, cellSize);
       

             
             
          
          }
          
        
          else {
            
          
          
              fill(0, 0, 255);

              rect(x, y, cellSize, cellSize);
            
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
}
}


void ontouched() {

}






void getpix() {
  loadPixels();
  for (int i = 0; i < height; i++) {
    for (int b = 0; b < width; b++) {
      if (pixels[width*i+b] != (-3355444)) {

        //println(pixels[width*i+b]);
      }
      if (pixels[width*i+b] == -1212415) {


        land[i][b] = false;
        ocean[i][b] = false;
          base[i][b] = false;
      } else if (pixels[width*i+b] == color(255)) {

        land[i][b] = false;
        ocean[i][b] = true;
          base[i][b] = false;
        
      } else if (pixels[width*i+b] == color(0)) {
  
        ocean[i][b] = false;
        land[i][b] = true;
          base[i][b] = false;
      }
      else if (pixels[width*i+b] == color(255,0,0)){
        ocean[i][b] = false;
        land[i][b] = false;
        base[i][b] = true;
      }
    }
  }
  plasticGeneration();
  
  updatePixels();
}




 
void plasticGeneration() {
  
  
  
 //Below is the plastic patch generation for different maps
  
int selectedMap = Oceans.getSelectedIndex();  
if (selectedMap == 1) {
  for (int i=40; i<70;i++) {
    for (int j=10; j<40;j++){
       float rand = random(0,1);
       
       float convert = pollutionChance/100;
       if (rand<convert){    
         pollution[i][j] = true;
      }
  }
  }
}
else if (selectedMap == 2) {
  for (int i=10; i<40;i++) {
    for (int j=20; j<50;j++){
       float rand = random(0,1);
       
       float convert = pollutionChance/100;
       if (rand<convert){    
         pollution[i][j] = true;
      }
  }
  }
}
else if (selectedMap == 3) {
  for (int i=10; i<40;i++) {
    for (int j=60; j<90;j++){
       float rand = random(0,1);
       
       float convert = pollutionChance/100;
       if (rand<convert){   
         pollution[i][j] = true;
      }
  }
  }
}
else {
   for (int i=40; i<70;i++) {
    for (int j=20; j<50;j++){
       float rand = random(0,1);
       
       float convert = pollutionChance/100;
       if (rand<convert){    
         pollution[i][j] = true;
          plasticX[i][j] = i;
         plasticY[i][j] = j;
      }
  }
  }
}

//Below is the random plastic generation scattered all over the ocean
if (scatteredVal.isSelected() == true) {
for (int i=0; i<n; i++) {
  for (int j=0;j<n;j++) {
    if (base[i][j] == false ) {
      float rand = random(0,1);
       
       float convert = pollutionChance/500;
       if (rand<convert){    
         pollution[i][j] = true;
         plasticX[i][j] = i;
         plasticY[i][j] = j;
      }
    }
  }
}
}

  

}

void loadIndianOcean() {
 
  
  image = loadImage("IndianOcean.png");
    image(image, -100, -200);
     delay(3);
    reset();
    
  
}
void loadArcticOcean() {
  image = loadImage("ArcticOcean.png");
    image(image, -200, -500);
     delay(3);
    reset();
    
  
}
void loadPacificOcean() {
  image = loadImage("NA.png");
    image(image, -480, -200);
     delay(3);
    reset();
    
  
}
void loadAtlanticOcean() {
  

  image = loadImage("AtlanticOcean.png");
    image(image, -400, 0);
    delay(3);
    reset();
    
  
}
void initializeMap() {
  image = loadImage("initializer.jpg");
  image(image,0,0);
}
void resetLand() {
  for (int i = 0; i <n; i++) {
    for (int j = 0; j<n;j++) {
       //float x = padding + j*cellSize;
       //float y = padding;
       //fill(color(255, 165, 0));


       //rect(x, y, cellSize, cellSize);
        oceanBlock = new boolean[n][n];
        landBlock = new boolean[n][n];
        baseBlock = new boolean[n][n];
      land[i][j] = false;
      ocean[i][j] = false;
      base[i][j] = false;
      
      
      
    }
}
 redraw();
}
void reset(){
  Clenser = new bot(100);
  plastNum = 0;
  botNum = 1;
  
  removePol();
  plasticGeneration();
 
}

void removePol(){
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
     pollution[i][j] = false;
    }
  }
}
