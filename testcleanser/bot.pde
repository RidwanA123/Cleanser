float batterylife;
float storSize;
  
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
  void moveBot(){
    if (storageFull == false){
      this.detectPlastic();
    }
    this.storage();
    this.batteryLife();
    if (efficiencyCheckbox.isSelected()) {
     
        if (xMove == false && yMove == false){ 
     randomPlastic();     
     xMove = true;
     yMove = true;
 }
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
  
  image(botpic, this.xpos, this.ypos);
  
  //xpos += xs;
  //ypos += ys;
  if (xMove == true) {    
  BotMovementInXDirection();
}

if (yMove == true) {
  BotMovementInYDirection();
}
 landDetection();
  
    }
    else{
    
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
  
  image(botpic, this.xpos, this.ypos);
  
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
}
void BotMovementInXDirection() {
  int xCell = round(this.xpos/ cellSize);

   iDelta = targetX - xCell;  
   println(targetX,xCell,iDelta);
   
  if (iDelta>0){
  xpos = xpos + xs;
  }
 
  if (iDelta<0){
 
 xpos = xpos -xs;
  }
 
  if (iDelta == 0){
   println("stop");
  }
}
void BotMovementInYDirection() {
 //   int yCell = round(this.ypos/ cellSize);
 //   jDelta = targetY - yCell;  
   
 // if (jDelta>0){
 // ypos = ypos + ys;
 // }
 
 // if (jDelta<0){
 
 //ypos = ypos -ys;
 // }
 
 // if (jDelta == 0){
 //  ypos = 0;
 // }
}
void landDetection() {
 int xCell = round(this.xpos/ cellSize);
  int yCell = round(this.ypos/ cellSize);
 
  try{if (landBlock[yCell][xCell] == true) {
    
    xs = xs *-1;
    ys = ys * -1;
     randomPlastic(); 
   
  }}
  catch(Exception e){}
 
}
void randomPlastic() {
    
    boolean foundTarget = false;
  int i=0, j=0;

  while ( !foundTarget ) {
    i = int(random(0, n));
    j = int(random(0, n));

    if (pollution[i][j]){
      foundTarget = true;
      target[i][j] = true; 
      targetX = i;
      targetY = j;
      println(i,j);
      
    }
    
    else if ( oceanBlock[i][j] || landBlock[i][j] || baseBlock[i][j]) {
       foundTarget = false;
      target[i][j] = false;
    }
  }
}
void detectPlastic(){
  int xCell = round(this.xpos/ cellSize);
  int yCell = round(this.ypos/ cellSize);
    boolean foundTarget = false;
  int i=0, j=0;

  while ( !foundTarget ) {
    i = int(random(0, 100));
    j = int(random(0, 100));

    if (pollution[i][j]){
      foundTarget = true;
      target[i][j] = true;  
      
    }
    
    else if ( oceanBlock[i][j] || landBlock[i][j] || baseBlock[i][j]) {
       foundTarget = false;
      target[i][j] = false;
    }
  }
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
    xpos = 1000000000;
    Clenser.decreaseBot();
    if (lastBot <= 0){
      text("All the bots sunk due to no battery, press restart",width/2,height/2);
      println("All bots ded");
      noLoop();
    }
  }
}
void storage(){
  fill(255,165,0);
  rect(xpos,ypos+40,plastored,3);
  
  if (plastored >= full){
    storageFull = true;
  }
}

void increaseBot(){
  if (this.minBot < 5){
    this.minBot++;
  }
}

void decreaseBot(){
  if (this.minBot > 1){
    this.minBot--;
}
}
}
