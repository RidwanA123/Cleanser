int xs = round(random(-10,10));
int ys = round(random(-10,10));

class bot{
  float batteryLife;
  int xpos;
  int ypos;
  float efficiency;
  PImage img;
  
  //constructor
  bot(float b, float e){
    this.batteryLife = b;
    this.xpos = round(random(400,600));
    this.ypos = round(random(400,600));
    this.efficiency = e;
  }
  
  void moveBot(){
  
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
      int ix = round(cellsize + i);
      int iy = round(cellsize + j);
      
      if (xpos >= ix && ypos >= iy){
        pollution[i][j] = false;
      }
    }
  }
}
}
