class bot{
  float batteryLife;
  float sxpeed;
  float syspeed;
  float efficiency;
  int botNum;
  PImage img;
  
  //constructor
  void bot(float b, float sx, float sy, float e){
    this.batteryLife = b;
    this.sxpeed = sx;
    this.syspeed = sy;
    this.efficiency = e;
    this.botNum = 0;
    
    if (sx > 0){
      img = loadImage("clenser right-1.png");
    }
    else if (sx < 0){
      img = loadImage("clenser left-1.png");
    }
    else if (sy > 0){
      img = loadImage("clenser front-1.png");
    }
    else {
      img = loadImage("clenser back-1.png");
    }
  }
  
  
  
  
}
