boolean plastics[][];
int n = 100;
int padding = 0; 
float plasticSize;
float plasticProbability = 0.4;
int z = n-100;

color [][] cells = new color [n][n];
color [][] cellsNext = new color [n][n];

color plasticColour = color (128,98,90);
color cleansedColour = color (255);
color backgroundColour = color (0,0,253);

boolean f = false;
boolean t = true;

void setup(){
 
  size (600,600);
  plasticSize = (width-2*padding)/n;
  
  PlantFirstGeneration();
 
}



void draw(){
  
 background(backgroundColour); 
 noStroke();
 float y1 = padding;
 
  for (int i=0; i < n; i++ ) {

    for (int j=0; j< n; j++) {

      float x1 = padding + j*plasticSize;  
      fill( cells[i][j] );
      rect(x1, y1, plasticSize, plasticSize);
    }
    y1 += plasticSize;

  }
}



void PlantFirstGeneration() {
  println("First");

  for (int i=55; i<n-20; i++) {

    for (int j=10; j<n-50; j++) {
      
      float r = random(0,1);
      
      if (r<0.3){
        
        cells[i][j] = plasticColour;
      }
      
      else{
        
        cells[i][j] = backgroundColour;
      
   }
  }
 }
}
