int xs = round(random(-10,10));
int ys = round(random(-10,10));
float batterylife;

class bot{
  float draining;
  float xpos;
  float ypos;
  float efficiency;
  PImage img;
  float batnum;
  
  //constructor
  bot(float e){
    
    this.xpos = random(400,500);
    this.ypos = random(400,500);
        
    
    this.draining = (100-batterylife)/500;
    this.efficiency = e;
   
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
  
  if (xpos < 0+padding){
   xs = round(random(1,10));
 }
 else if (xpos > width-padding*2){
   xs = round(random(-10,-1));
 }
 else if (ypos < 0+padding){
   ys = round(random(1,10));
 }
 else if (ypos > height-padding*2){
   ys = round(random(-10,-1));
  }
}

void detectPlastic(){
   for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
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
  
  rect(xpos,ypos+3,plastored+10,3);
}
}
