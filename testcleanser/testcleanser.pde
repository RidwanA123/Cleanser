//Main Class
import g4p_controls.*;

PImage botpic; //gobal variable for each bot picture, because they constantly change in different functions

int botNum; //amount of bots, changable by user selection, global since all tabs utilize this

float cellsize; //cellsize, global since all tabs utilize this 
int gencount;

boolean mapChanged; //boolean, allows maps to change if true
float pollutionChance; //pollution chance changes the probability of plastic generating

int targetX, targetY; //the location of the plastic target the bots catch, used in efficient bot
float iDelta, jDelta; //the difference between targetX,targetY, and xposition and yposition, used in efficient bot

boolean b;

boolean xMove, yMove; //prevents bot to move in x or y if false, used in efficient bot.

boolean buttonPressed = false; //allows us to switch between "pause" and "resume"

int lastBot = 2; //lastbot used in Number of Cleansers part of the GUI

boolean[][] pollution;


bot Clenser;    //globalises all bots so I don't have to add bot to everything
bot other1;
bot other2;
bot other3;            
bot other4;

int n = 100; //number of cells
float padding = 0; //padding
float CPS = 60;  //framerate
boolean[][] land, boundary, ocean, base, landBlock, oceanBlock, baseBlock, target;
//land maps all cell positions of where the country will be
//boundary sets the boundary for where plastic shoudn't be
//ocean sets the cell states of where the ocean will be
//base sets the cell states of where the base will be




float cellSize;
float[][] plasticX = new float[n][n]; //new float variable for plastic, instead of boolean. Makes it easier for bots to detect x and y, instead of colours
float[][] plasticY = new float[n][n];



int genCount = 0; 


PImage image;  

void setup() {
  noStroke(); //removes ugly borders between cells
  size(1000, 700); //screen size
  frameRate( CPS); //frameRate variable
  restart();                          //restart function called in setup since it seeems cleaner than to define new booleans twice

  Clenser = new bot(lastBot);        //all new bots spawn, whether there used is dependant on user selection
  other1 = new bot(lastBot);
  other2 = new bot(lastBot);
  other3 = new bot(lastBot);
  other4 = new bot(lastBot);
}

void restart() {
  createGUI();  //gui is created (refer to gui tab)

  image = loadImage("NA.png");
  image(image, -500, -300);

  ocean = new boolean[height][width];  //defines each cell boolean as a new value whe restarting
  land = new boolean[height][width];
  base = new boolean[height][width];
  oceanBlock = new boolean[n][n];
  landBlock = new boolean[n][n];
  baseBlock = new boolean[n][n];
  pollution = new boolean[n][n];
  target = new boolean[n][n];
  loadPixels();
  getpix();



  cellSize = (width-2*padding)/n;  //cellsize formula


  //setCellValuesRandomly();
  //setCellValuesAlternating();
  cMap();
}
void draw() {
  background(0, 0, 255);    
  cMap();

  Clenser.moveBot();
  //use if statemenets to make sure it goes through all possible bots
  if (botNum >= 2) {
    other1.moveBot();    //if user selects atleast 2 bots then the second one spawns
  }
  if (botNum >= 3) {      //if user selects atleast 3 bots then the third one spawns
    other2.moveBot();
  }
  if (botNum >= 4) {      //if user selects atleast 4 bots then the fourth one spawns
    other3.moveBot();
  }
  if (botNum >= 5) {      //if user selects atleast 5 bots then the final one spawns
    other4.moveBot();
  }
}



void cMap() {  //this function draws the map
  float y = padding; //basic cell work, y value increases after forloop
  if (true) {

    for (int i=0; i<n; i++) { //for loop for width

      for (int j=0; j<n; j++) { //for loop for length

        float x = padding + j*cellSize; //converting cells into an x value


        try {     


          if ( (land[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (land[int(y)][int(x)]) || (land[int(y+cellSize)][int(x)]) || (land[int(y)][int(x+cellSize)]) || (land[int(y+cellSize)][int(x+cellSize)]) ) {




            fill(104, 189, 86);                      //land colour

            rect(x, y, cellSize, cellSize);        // land cell creation



            landBlock[i][j] = true;
            oceanBlock[i][j] = false;            //gives boolean values to pixels, all is false but land
            baseBlock[i][j] = false;
            boundary[i][j] = false;
          } 
          else if ( (base[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (base[int(y)][int(x)]) || (base[int(y+cellSize)][int(x)]) || (base[int(y)][int(x+cellSize)]) || (base[int(y+cellSize)][int(x+cellSize)]) ) {





            fill(211, 211, 211);                          //base colour

            rect(x, y, cellSize, cellSize);               //base cell creation

            baseBlock[i][j] = true;
            landBlock[i][j] = false;
            oceanBlock[i][j] = false;                  //gives boolean values to pixels, all is false but base and boundary
            boundary[i][j] = true;
          } 
          else if ( (ocean[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (ocean[int(y)][int(x)]) || (ocean[int(y+cellSize)][int(x)]) || (ocean[int(y)][int(x+cellSize)]) || (ocean[int(y+cellSize)][int(x+cellSize)]) ) {



            fill(0, 120, 255);                          //ocean colour

            oceanBlock[i][j] = true;
            landBlock[i][j] = false;                    //gives boolean values to pixels, all is false but ocean

            baseBlock[i][j] = false;

            rect(x, y, cellSize, cellSize);              // ocean cell creation
          } 
          else {



            fill(0, 0, 255);
            boundary[i][j] = true;
            rect(x, y, cellSize, cellSize);
          }
          if   (pollution[i][j] == true) {
            fill(color(128, 98, 90));

            landBlock[i][j] = false;
            oceanBlock[i][j] = false;
            baseBlock[i][j] = false;
            rect(x, y, cellSize, cellSize);
          }
        }
        catch(Exception e) {
        }
      }

      y += cellSize;
    }
  }
  if (mapChanged) {
    genCount++;
    if (genCount > 8) {      //This sends the bot back to spawn everytime the map is changed
      reset();
      mapChanged = false;
      genCount = 0;
    }
  }
}








void getpix() { //this function converts the image into pixels by giving boolean values depending on if the pixel is using the land, ocean, or base, in the map
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
      } 
      else if (pixels[width*i+b] == color(255)) {

        land[i][b] = false;
        ocean[i][b] = true;
        base[i][b] = false;
      } 
      else if (pixels[width*i+b] == color(0)) {

        ocean[i][b] = false;
        land[i][b] = true;
        base[i][b] = false;
      } 
      else if (pixels[width*i+b] == color(255, 0, 0)) {
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



  int selectedMap = Oceans.getSelectedIndex(); // changes the plastic generation for each selectable map
  if (selectedMap == 1) {
    for (int i=40; i<70; i++) { //pacific

      for (int j=10; j<40; j++) {
        float rand = random(0, 1);

        float convert = pollutionChance/100;
        if (rand<convert) {    
          pollution[i][j] = true;
        }
      }
    }
  } else if (selectedMap == 2) { //indian
    for (int i=10; i<40; i++) {
      for (int j=20; j<50; j++) {
        float rand = random(0, 1);

        float convert = pollutionChance/100;
        if (rand<convert) {    
          pollution[i][j] = true;
        }
      }
    }
  } else if (selectedMap == 3) {  //arctic
    for (int i=10; i<40; i++) {
      for (int j=60; j<90; j++) {
        float rand = random(0, 1);

        float convert = pollutionChance/100;
        if (rand<convert) {   
          pollution[i][j] = true;
        }
      }
    }
  } else { //atlantic
    for (int i=40; i<70; i++) {
      for (int j=20; j<50; j++) {
        float rand = random(0, 1);

        float convert = pollutionChance/100;
        if (rand<convert) {    
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
      for (int j=0; j<n; j++) {
        if (base[i][j] == false ) {
          float rand = random(0, 1);

          float convert = pollutionChance/500;
          if (rand<convert) {    
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


  image = loadImage("IndianOcean.png"); //indian ocean image 
  image(image, -100, -200);


  reset(); //when selected, all values reset
  Clenser.resetBot();
}
void loadArcticOcean() { //arctic ocean image
  image = loadImage("ArcticOcean.png");
  image(image, -200, -500);

  reset();
  Clenser.resetBot();
}
void loadPacificOcean() { //pacific ocean image
  image = loadImage("NA.png");
  image(image, -480, -200);

  reset();
  Clenser.resetBot();
}
void loadAtlanticOcean() {//atlantic ocean image


  image = loadImage("AtlanticOcean.png");
  image(image, -400, 0);

  reset();
  Clenser.resetBot();
}
void initializeMap() {
  image = loadImage("initializer.jpg"); //this map opens before the other maps, so that the cell generation doesn't get buggy
  image(image, 0, 0);
}
void resetLand() {  //resets all cell values of map
  for (int i = 0; i <n; i++) {
    for (int j = 0; j<n; j++) {
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
void reset() {  //resets all values || different function than land because we need to differentiate between someone pressing restart, and someone choosing a different map
  for (int i=0; i<n; i++) {
    for (int j =0; j<n; j++) {
      target[i][j] = false;
    }
  }
  targetX = 0;
  targetY = 0;
  Clenser = new bot(lastBot);
  other1 = new bot(lastBot);
  other2 = new bot(lastBot);
  other3 = new bot(lastBot);
  other4 = new bot(lastBot);

  removePol();
  plasticGeneration();
}

void removePol() {  //removes pollution 
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      pollution[i][j] = false;
    }
  }
}
