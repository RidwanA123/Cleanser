float batterylife;
float storSize;
boolean efficient = false;  
class bot{
  float draining;
  float xpos;
  float ypos;
  float stored;
  int minBot = 1; //minimum bot is always 1
  PImage img;
  boolean storageFull;

  int xs = round(random(-20,20));
  int ys = round(random(-20,20));
  
  float iPlastic, jPlastic;
  float iDelta, jDelta;
  float iBot, jBot;
  float xSpeed = 1;
  float ySpeed = 1;
  float xSpeedReverse = -1;
  float ySpeedReverse = -1;
  boolean xMove, yMove;

float rand = 0;

  float plastored;
  float full;

  //constructor
  bot(int n){
    this.minBot = n;
    draining = (100-batterylife)/500;
    stored = (100-storSize)/10;
    
    storageFull = false;
   
   full = 30;
   plastored = 2;
   resetBot();
  }
  
  void resetBot(){
    
    for (int i = 0; i<n;i++) {
      for (int j = 0; j<n;j++) {
        if (baseBlock[i][j] == true) {
          rand = random(1,3);
          if (rand >= 2){
          xpos = j*9;
          ypos = i*9;
          }
          
        }
      }
      
    }
    full = 30;
    plastored = 2;
  }
  
  void setRandomTarget() {
  boolean foundTarget = false;
  int i=0, j=0;

  while ( !foundTarget ) {
    i = int(random(0, n));
    j = int(random(0, n));

    if (pollution[i][j] == false){
      foundTarget = false;
    }
   
    else {
      foundTarget = true;

      iPlastic = round(cellSize*i);
      jPlastic = round(cellSize*j);
    }
  }
}
  
  void goodMove(){
     if (round(xpos) <= round(jPlastic) && round(xpos) >= round(jPlastic)) {
    xMove = false;
  }

  if (round(ypos) <= round(iPlastic) && round(ypos) >= round(iPlastic)) {
    yMove = false;
  }
  
   if (xMove == true) {    
  BotMovementInXDirection();
}

if (yMove == true) {
  BotMovementInYDirection();
}
  }
  
  void BotMovementInXDirection() {

  iDelta = round(jPlastic) - round(xpos);  
   
  if (iDelta>0){
  xSpeed = xs*1;
  }
 
  if (iDelta<0){
 
  xSpeed = xs*-1;
  }
 
  if (iDelta == 0){
   xSpeed = 0;
  }
}



  void BotMovementInYDirection() {
    jDelta = round(iPlastic) - round(ypos);
   
      if (jDelta<0) {

      ySpeed = ys*-1;
    }
   
    else if (jDelta>0) {

      ySpeed = ys*1;
    }
   
    else {
      ySpeed = 0;
    }
   
  ypos += ySpeed;
  }
  void moveBot(){
    if (efficient == true){
      goodMove();
    }
    if (storageFull == false){
      detectPlastic();
    }
    storage();
    batteryLife();
    
    if (xs > 0 && abs(xs) > abs(ys)){
      botpic = loadImage("clenser right-1.png.png");
    }
    else if (xs < 0 && abs(xs) > abs(ys)){
      botpic = loadImage("clenser left-1.png.png");
    }
    else if (ys > 0 && abs(ys) > abs(xs)){
      botpic = loadImage("clenser front-1.png.png");
    }
    else {
      botpic = loadImage("clenser back-1.png.png");
    }
  
  image(botpic, xpos, ypos);
  
  xpos += xs;
  ypos += ys;
  
  if (xs == 0 || ys == 0){
    xs = round(random(1,10));
    ys = round(random(1,10));
   
    
  }
  
  if (xpos < 0+padding+20){
   xs = round(random(1,10));
  
   
 }
 else if (xpos > width-40-padding){
   xs = round(random(-10,-1));

 }
 else if (ypos < 0+padding+20){
   ys = round(random(1,10));
 
 }
 else if (ypos > height-40-padding){
   ys = round(random(-10,-1));
  
  
  }
  landDetection();
}

void landDetection() {
 int xCell = round(xpos/ cellSize);
  int yCell = round(ypos/ cellSize);
 
  try{if (landBlock[yCell][xCell] == true) {
    
    xs = xs *-1;
    ys = ys * -1;
   
  }}
  catch(Exception e){}
 
}

void detectPlastic(){
  int xCell = round(xpos/ cellSize);
  int yCell = round(ypos/ cellSize);
 // println(xCell,yCell);
   
    
      try{
      if (pollution[yCell-1][xCell-1] == true || pollution[yCell][xCell] == true || pollution[yCell+1][xCell+1] == true){
        
        pollution[yCell-1][xCell-1] = false;
        pollution[yCell][xCell] = false;
        pollution[yCell+1][xCell+1] = false;
           fill(0, 120, 255);                          //ocean
              
           oceanBlock[yCell][xCell] = true;
            rect(xCell, yCell, cellSize, cellSize);
       plastored += stored;
       
  }
      }
      catch(Exception e) {
      }
  
  this.storage();
}

void batteryLife(){
  
  fill(0,255,0);
  
  rect(xpos,ypos-3,full,3);
  
  int s = second(); //Tracks time from 0s-59s
  
  if (s%2 == 0){
    full -= draining;
  }
  if (full <= 0){
    xpos = 1000000000; //moves bot far away from the screen (out of site, out of mind)
    this.decreaseBot(); //function that decreases bot count
    if (lastBot <= 0){ //if the last bot drowns, a message is sent
      println("All the bots sunk due to no battery, press restart");
    }
  }
}
void storage(){
  fill(255,165,0);
  rect(xpos,ypos+40,plastored,3);
  
  if (plastored >= full){ //if plastic meter full, a boolean is activated that prevents bot from consuming plastic
    storageFull = true;
  }
}

void increaseBot(){//allows me to increase botNum globally
  if (this.minBot < 5){
    this.minBot++;
  }
}

void decreaseBot(){ //allows me to lower botNum globally
  if (this.minBot > 1){
    this.minBot--;
}
}
}
