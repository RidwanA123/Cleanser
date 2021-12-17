float batterylife; //globalizes both values to be changed in gui
float storSize;
  
class bot{
  float draining; // variable becomes formula for draining battery at certain speed
  float xpos; //x position
  float ypos;//y position
  float stored;//variable becomes formula for storage capacity
  int minBot = 1; //minimum bot is always 1
  PImage img; 
  boolean storageFull; //if storageFull == true; plastic cant be eaten

  int xs = round(random(-20,20)); //gives random initial xSpeed and ySpeed
  int ys = round(random(-20,20));
  

float rand = 0;

  float plastored;
  float full;

  //constructor bot, only has minimum amount of bots as a parameter, used for Cleanser Amount
  bot(int n){
    this.minBot = n;
    draining = (100-batterylife)/500; //formulas mentioned above^^
    stored = (100-storSize)/500;
    
    storageFull = false;//if storageFull == true; plastic cant be eaten
   
   full = 30; //the length of a full bar
   plastored = 2; //initial storage bar length, starts small because not in full capacity
   resetBot();
  }
  
  void resetBot(){
    
    for (int i = 0; i<n;i++) {
      for (int j = 0; j<n;j++) {
        if (baseBlock[i][j] == true) { //resets all bots in grey base
          rand = random(1,3);
          if (rand >= 2){
          xpos = j*9;
          ypos = i*9;
          }
          
        }
      }
      
    }
    full = 30; //recalling inital bar lengths, because at base, bots empty storage and charge
    plastored = 2;
    storageFull = false;
  }
  void moveBot(){
    if (storageFull == false){
      this.detectPlastic();//detects plastic function becaus storage is not full
    }
    else{
      resetBot(); //sends bots back to base when storage is full
    }//rewards bots with free battery, when storage is full, punishment by for not collecting enough storage is letting the bot drown
    this.storage();
    this.batteryLife();
    if (efficiencyCheckbox.isSelected()) { //this code runs only when efficiency is checked
     
        if (xMove == false && yMove == false){ //finds new targets when previous plastic is caught
     randomPlastic();     
     xMove = true;
     yMove = false;
 }
 //this series of codes will be found again, it loads the appropriate image depending on where the bot is going
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
  
  image(botpic, this.xpos, this.ypos); //creates the bot with images set
  
  //xpos += xs;
  
  if (xMove == true) {    
  BotMovementInXDirection();
}
//ypos += ys;
if (yMove == true) {
  BotMovementInYDirection();
}
 landDetection(); //function to avoid land
  
    }
    else{ //this code activates when efficiency is off
    
    if (xs > 0 && abs(xs) > abs(ys)){
      botpic = loadImage("clenser right-1.png.png"); //similar to above ^^
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
    ys = round(random(1,10)); //ensures robot is constantly moving
   
    
  }
  
  if (xpos < 0+padding+20){ //these parameters make sure the robot doesn't leave the edge when inefficient
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
void BotMovementInXDirection() { //xs formula for efficient tracking
  int xCell = round(this.xpos/ cellSize);

   iDelta = targetY - xCell;  //finds the difference between target, and bot location
   println(targetX,xCell,iDelta);
   
  if (iDelta>0){
  xpos = xpos + xs;
  }
 
  if (iDelta<0){
 
 xpos = xpos -xs;
  }
 
  if (iDelta == 0||iDelta == -1||iDelta == 1){ //if difference is miniscule, then movement is disabled
   xMove = false;
   yMove = true;
  }
}
void BotMovementInYDirection() { //ys formula for efficient tracking
    int yCell = round(this.ypos/ cellSize);
    jDelta = targetX - yCell;  //finds the difference between target, and bot location
   
  if (jDelta>0){
  ypos = ypos + ys;
  }
 
  if (jDelta<0){
 
 ypos = ypos -ys;
  }
 
  if (jDelta == 0||jDelta == -1||jDelta == 1){//if difference is miniscule, then movement is disabled
   xMove = false;
   yMove = false;
  }
}
void landDetection() {
 int xCell = round(this.xpos/ cellSize); //converts xposition of bot, to cell
  int yCell = round(this.ypos/ cellSize);
 
  try{if (landBlock[yCell][xCell] == true) { //bots leave screen when dead so try statement is important to make sure program doesn't crash
    
    xs = xs *-1;
    ys = ys * -1;
     randomPlastic(); //function for randomizing plastic
   
   
  }}
  catch(Exception e){}
 
}
void randomPlastic() {
    
    boolean foundTarget = false;
  int i=0, j=0;

  while ( !foundTarget ) {
    i = int(random(0, n));//finds a random i,j cell to target 
    j = int(random(0, n));

    if (pollution[i][j]){ //if random perameter is true, then target is locked
      foundTarget = true;
      target[i][j] = true; 
      targetX = i;
      targetY = j;
      println(i,j);
      
    }
    
    else if ( oceanBlock[i][j] || landBlock[i][j] || baseBlock[i][j]) { //if it's not plastic, it cannot be targeted
       foundTarget = false;
      target[i][j] = false;
    }
  }
}
void detectPlastic(){ //function for my bot to consume plastic
  int xCell = round(this.xpos/ cellSize); //x location to cell conversion
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
      if (pollution[yCell-1][xCell-1] == true || pollution[yCell][xCell] == true || pollution[yCell+1][xCell+1] == true){ // if bot near pollution vicinity
        
        pollution[yCell-1][xCell-1] = false;
        pollution[yCell][xCell] = false;    //area no longer polluted
        pollution[yCell+1][xCell+1] = false;
           fill(0, 120, 255);                          //ocean
              
           oceanBlock[yCell][xCell] = true;
            rect(xCell, yCell, cellSize, cellSize);
       plastored += stored; //storage bar increases meaning it is more full
       
  }
      }
      catch(Exception e) {
      }
  
  this.storage();
}

void batteryLife(){
  
  fill(0,255,0);
  
  rect(xpos,ypos-3,full,3); //visualise battery
  
  int s = second(); //Tracks time from 0s-59s
  
  if (s%2 == 0){  //every 2 seconds the battery drains by draining formula above^^
    full -= draining;
  }
  if (full <= 0){
    xpos = 1000000000; // when battery empty, bot goes outside of screen
    Clenser.decreaseBot(); //botcount goes down
    if (lastBot <= 0){
      text("All the bots sunk due to no battery, press restart",width/2,height/2);
      println("All bots ded");
      noLoop();
    }
  }
}
void storage(){
  fill(255,165,0);
  rect(xpos,ypos+40,plastored,3);  //visualise storage
  
  if (plastored >= full){ //storageFull = true when meter is full
    storageFull = true;
  }
}

void increaseBot(){ //increases minimum bot number for Cleanser Amount
  if (this.minBot < 5){
    this.minBot++;
  }
}

void decreaseBot(){ //decreases minimum bot number for Cleanser Amount
  if (this.minBot > 1){
    this.minBot--;
}
}
}
