import g4p_controls.*;

PImage botpic;

boolean buttonPressed = false;

 int n = 500;
  String name;
  float pollution;

  float padding = 50;
  float  cellSize = (width-2*padding)/n;
  
  bot Clenser;
  bot rob;
void setup(){
 
  frameRate(20);
  ocean = new boolean[height][width];
  land = new boolean[height][width];
  size(1600,800);
  createGUI();
  PImage image;
  image = loadImage("NA.png");
  image(image, -100, 0);
  loadPixels();
  getpix();
  
  
  Clenser = new bot(100,100);
  
  
  //Write the map code here;
  
  //restart();  Guys remove the commenting part when you finished the void restart below
 
}

  
  
void restart(){
  
 // give the value of the beggining of the code here too m8s
  
}




  void draw() {
  //background(0, 0, 255);    
  float y = padding;

  if (true) {

    for (int i=0; i<n; i++) {

      for (int j=0; j<n; j++) {

        float x = padding + j*cellSize;


        try {     
          //  if  (cellscolNext[i][j] == color(255,166,0)) {
          //     fill(color(255,166,0));
          //         rect(x, y, cellSize, cellSize);
          //  println("FOUND");
          //}
         
          if ( (land[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (land[int(y)][int(x)]) || (land[int(y+cellSize)][int(x)]) || (land[int(y)][int(x+cellSize)]) || (land[int(y+cellSize)][int(x+cellSize)]) ) {
           fill(color(0,255, 0));
           rect(x, y, cellSize, cellSize);
            
          } else if ( (ocean[int((2*y+cellSize)/2)][int((2*x+cellSize)/2)])|| (ocean[int(y)][int(x)]) || (ocean[int(y+cellSize)][int(x)]) || (ocean[int(y)][int(x+cellSize)]) || (ocean[int(y+cellSize)][int(x+cellSize)]) ) {
            fill(color(0,105, 148));
           rect(x, y, cellSize, cellSize);
           
          } 
          else {
           
            // if (cellscolNext[i][j] == color(255, 165, 0)) {
            //   fill(color(255, 165, 0));
            //   NATO3[i][j] = color(255, 165, 0);

            //   rect(x, y, cellSize, cellSize);
            // } 
            // else  if (radiation[i][j]) {
            //   fill(color(0, 255, 0));



            //   rect(x, y, cellSize, cellSize);
            // }
            // else if (cellscolNext[i][j] == color(0, 255, 0)) {
            //   fill(color(0, 255, 0));



            //   rect(x, y, cellSize, cellSize);
            //  }
            //  else {
            //   fill(0, 0, 255);

            //   rect(x, y, cellSize, cellSize);
            // }
          }
        }
        catch(Exception e) {
          print("error");
        }
      }

      y += cellSize;
    }


//     genCount++;
//     setNextGeneration();
//     if (detonated) {
//       detonate();
//     }
//     if (radiations) {
//       radiation();
//     }
//     if (savestate) {
//       savestates();
//     }
//     copyNextGenerationToCurrentGeneration();
//      fireFirstMissile();
  
  
//   }
}
int x = 0;
boolean savestate;



Clenser.moveBot();



}
void getpix() {
  loadPixels();
  for (int i = 0; i < height; i++) {
    for (int b = 0; b < width; b++) {
     
       if (pixels[width*i+b] == color(255)) {
        ocean[i][b] = true;
        land[i][b] = false;

      } else if (pixels[width*i+b] == color(0)) {
        ocean[i][b] = false;
        land[i][b] = true;

        //set[i][b] = 8.740;
      }
    }
  }
  updatePixels();
}
