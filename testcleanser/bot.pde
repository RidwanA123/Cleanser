float batterylife; //globalizes both values to be changed in gui
float storSize;

class bot {
  float draining; // variable becomes formula for draining battery at certain speed
  float xpos; //x position
  float ypos;//y position
  float stored;//variable becomes formula for storage capacity
  int minBot = 1; //minimum bot is always 1
  PImage img; 
  boolean storageFull; //if storageFull == true; plastic cant be eaten

  int xs = round(random(-20, 20)); //gives random initial xSpeed and ySpeed
  int ys = round(random(-20, 20));


  float rand = 0;

  float plastored;
  float full;

  //constructor bot, only has minimum amount of bots as a parameter, used for Cleanser Amount
  bot(int n) {
    this.minBot = n;
    draining = (100-batterylife)/500; //formulas mentioned above^^
    stored = (100-storSize)/500;

    storageFull = false;//if storageFull == true; plastic cant be eaten

    full = 30; //the length of a full bar
    plastored = 2; //initial storage bar length, starts small because not in full capacity
    resetBot();
  }
  void sendBackToBase() {   //any bots that wander off get sent back to base but thier battery and storage amount don't get altered
    for (int i = 0; i<n; i++) {
      for (int j = 0; j<n; j++) {
        if (baseBlock[i][j] == true) { //resets all bots in grey base
          rand = random(1, 3);
          if (rand >= 2) {
            xpos = j*9;
            ypos = i*9;
          }
        }
      }
    }
  }
  void resetBot() {

    for (int i = 0; i<n; i++) {
      for (int j = 0; j<n; j++) {
        if (baseBlock[i][j] == true) { //resets all bots in grey base
          rand = random(1, 3);
          if (rand >= 2) {
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
  void moveBot() {
    if (storageFull == false) {
      this.detectPlastic();//detects plastic function becaus storage is not full
    } else {
      resetBot();
    }
    this.storage();
    this.batteryLife();
    if (efficiencyCheckbox.isSelected() && (Oceans.getSelectedIndex() != 1 || Oceans.getSelectedIndex() != 2)) {
      //if efficiency is true;
      if (xMove == false && yMove == false) { 
        randomPlastic();     
        xMove = true;
        yMove = false;
      }
      if (xs > 0 && abs(xs) > abs(ys)) {
        botpic = loadImage("clenser right-1.png.png");
      } 
      else if (xs < 0 && abs(xs) > abs(ys)) {
        botpic = loadImage("clenser left-1.png.png");
      } 
      else if (ys > 0 && abs(ys) > abs(xs)) {
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
      if (xpos < -30) {
        sendBackToBase();
        targetX = 0;                //these statements sends the bot back to base if it wanders off the map
        targetY = 0;
        randomPlastic();
      } 
      else if (xpos > width+30) {
        xs = round(random(-10, -1));
        sendBackToBase();
        targetX = 0;
        targetY = 0;
        randomPlastic();
      } 
      else if (ypos < -30) {
        ys = round(random(1, 10));
        sendBackToBase();
        targetX = 0;
        targetY = 0;
        randomPlastic();
      } 
      else if (ypos > height-40+35) {
        ys = round(random(-10, -1));
        sendBackToBase();
        targetX = 0;
        targetY = 0;
        randomPlastic();
      }
      landDetection();
    } else {

      if (xs > 0 && abs(xs) > abs(ys)) {
        botpic = loadImage("clenser right-1.png.png");
      } 
      else if (xs < 0 && abs(xs) > abs(ys)) {
        botpic = loadImage("clenser left-1.png.png");          //pictures to load
      } 
      else if (ys > 0 && abs(ys) > abs(xs)) {
        botpic = loadImage("clenser front-1.png.png");
      } 
      else {
        botpic = loadImage("clenser back-1.png.png");
      }

      image(botpic, this.xpos, this.ypos);

      xpos += xs;
      ypos += ys;

      if (xs == 0 || ys == 0) {
        xs = round(random(1, 10));
        ys = round(random(1, 10));
      }

      if (xpos < 0+padding+20) {
        xs = round(random(1, 10));
      } else if (xpos > width-40-padding) {
        xs = round(random(-10, -1));                  //Bots will just bounce off borders if unefficient
      } else if (ypos < 0+padding+20) {
        ys = round(random(1, 10));
      } else if (ypos > height-40-padding) {
        ys = round(random(-10, -1));
      }
      landDetection();
    }
  }
  void BotMovementInXDirection() {
    int xCell = round(this.xpos/ cellSize);

    iDelta = targetY - xCell;  


    if (iDelta>0) {
      xpos = xpos + xs;
    }

    if (iDelta<0) {

      xpos = xpos -xs;
    }

    if (iDelta == 0||iDelta == -1||iDelta == 1) {
      xMove = false;
      yMove = true;
    }
  }
  void BotMovementInYDirection() {
    int yCell = round(this.ypos/ cellSize);
    jDelta = targetX - yCell;  

    if (jDelta>0) {

      ypos = ypos - ys;
    }

    if (jDelta<0) {

      ypos = ypos +ys;
    }

    if (jDelta == 0||jDelta == -1||jDelta == 1) {
      xMove = false;
      yMove = false;
    }
  }
  void landDetection() {
    int xCell = round(this.xpos/ cellSize);
    int yCell = round(this.ypos/ cellSize);

    try {
      if (landBlock[yCell][xCell] == true) {

        xs = xs *-1;
        ys = ys * -1;
        randomPlastic();
      }
    }
    catch(Exception e) {
    }
  }
  void randomPlastic() {

    boolean foundTarget = false;
    int i=0, j=0;

    while ( !foundTarget ) {
      i = int(random(0, n));
      j = int(random(0, n));

      if (pollution[i][j]) {
        foundTarget = true;
        target[i][j] = true; 
        targetX = i;
        targetY = j;
      } else if ( oceanBlock[i][j] || landBlock[i][j] || baseBlock[i][j]) {
        foundTarget = false;
        target[i][j] = false;
      }
    }
  }
  void detectPlastic() {
    int xCell = round(this.xpos/ cellSize);
    int yCell = round(this.ypos/ cellSize);                //picks a random plastic in the grid when efficiency is turned on
    boolean foundTarget = false;
    int i=0, j=0;

    while ( !foundTarget ) {
      i = int(random(0, 100));
      j = int(random(0, 100));

      if (pollution[i][j]) {
        foundTarget = true;
        target[i][j] = true;
      } 
      else if ( oceanBlock[i][j] || landBlock[i][j] || baseBlock[i][j]) {
        foundTarget = false;
        target[i][j] = false;
      }
    }
    // println(xCell,yCell);


    try {
      if (pollution[yCell-1][xCell-1] == true || pollution[yCell][xCell] == true || pollution[yCell+1][xCell+1] == true) {

        pollution[yCell-1][xCell-1] = false;
        pollution[yCell][xCell] = false;          //if the bot within a radius goes over a plastic, delete it
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

  void batteryLife() {

    fill(0, 255, 0);

    rect(xpos, ypos-3, full, 3);

    int s = second(); //Tracks time from 0s-59s

    if (s%2 == 0) {
      full -= draining;
    }
    if (full <= 0) {
      xpos = 1000000000;
      Clenser.decreaseBot();
      if (lastBot <= 0) {
        noLoop();
      }
    }
  }
  void storage() {
    fill(255, 165, 0);
    rect(xpos, ypos+40, plastored, 3);    //the main storage 

    if (plastored >= full) {
      storageFull = true;
    }
  }

  void increaseBot() {
    if (this.minBot < 5) {
      this.minBot++;
    }
  }

  void decreaseBot() {
    if (this.minBot > 1) {
      this.minBot--;
    }
  }
}
