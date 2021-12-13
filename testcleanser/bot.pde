class bot{
  float batteryLife;
  int xpos;
  int ypos;
  float efficiency;
  int botNum;
  PImage img;
  
  //constructor
  bot(float b, float e){
    this.batteryLife = b;
    this.xpos = round(random(400,600));
    this.ypos = round(random(400,600));
    this.efficiency = e;
    
    this.botNum = 0;
  }
  
  void moveBot(){
    int x = round(random(-10,10));
    int y = round(random(-10,10));
  
    if (x > 0){
      botpic = loadImage("clenser right-1.png.png");
    }
    else if (x < 0){
      botpic = loadImage("clenser left-1.png.png");
    }
    else if (y > 0){
      botpic = loadImage("clenser front-1.png.png");
    }
    else {
      botpic = loadImage("clenser back-1.png.png");
    }
  
  image(botpic, this.xpos, this.ypos);
  
  xpos += x;
  ypos += y;
  }
}
