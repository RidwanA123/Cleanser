int xs = round(random(-20,20));
int ys = round(random(-20,20));
float batterylife;
float rand = 0;
class bot{
  float draining;
  float xpos;
  float ypos;
  float efficiency;
  PImage img;

  int storage = 0;

  float batnum;

  //constructor
  bot(float e){
   
    //this.xpos = random(400,500);
    //this.ypos = random(400,500);
        
    
    
    this.draining = (100-batterylife)/500;
    this.efficiency = e;
   
   batnum = 30;
  }
  
  void resetBot(){
    for (int i = 0; i<n;i++) {
      for (int j = 0; j<n;j++) {
        if (baseBlock[i][j] == true) {
          rand = random(1,3);
          if (rand >= 2){
           this.xpos = j*9;
          this.ypos = i*9;
          }
          
        }
      }
      
    }
    batnum = 30;
  }
  void moveBot(){
    this.batteryLife();
  
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

void landDetection() {
 int xCell = round(this.xpos/ cellSize);
  int yCell = round(this.ypos/ cellSize);
  println(xCell,yCell);
  try{if (landBlock[yCell][xCell] == true) {
    
    xs = xs *-1;
    ys = ys * -1;
  }}
  catch(Exception e){}
 
}

void detectPlastic(){
   for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      float ix = cellsize*i;
      float iy = cellsize*j;
      
      if (xpos == ix && ypos == iy){
        pollution[i][j] = false;
      }
    }
  }
}

void batteryLife(){
  
  fill(0,255,0);
  
  rect(xpos,ypos-3,batnum,3);
  
  int s = second(); //Tracks time from 0s-59s
  
  if (s%2 == 0){
    batnum -= draining;
  }
  if (batnum <= 0){
    xpos = 1000000000;
    botNum -= 1;
    if (botNum <= 0){
      text("All the bots sunk due to no battery, press restart",width/2,height/2);
      noLoop();
    }
  }
}
void storage(){
  fill(255,165,0);
  rect(xpos,ypos+30,plastored+10,3);
}
}
