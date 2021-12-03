/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window2:307537:
  appc.background(230);
} //_CODE_:window2:307537:

public void pauseButtonPressed(GButton source, GEvent event) { //_CODE_:pauseButton:933206:

  if (buttonPressed == false){
    
    noLoop();
    buttonPressed = true;
    pauseButton.setText("Resume");
  }

  else{
   
    loop();
    buttonPressed= false;
    pauseButton.setText("Pause");
    
  }
} //_CODE_:pauseButton:933206:

public void ResetButtonPressed(GButton source, GEvent event) { //_CODE_:Reset:608023:
  
  //restart();

} //_CODE_:Reset:608023:

public void PlasticAmountClick(GSlider source, GEvent event) { //_CODE_:PlasticAmount:528106:

  //Polution_Speed = PlasticAmount.getValueF();


} //_CODE_:PlasticAmount:528106:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window2 = GWindow.getWindow(this, "Window title", 0, 0, 240, 240, JAVA2D);
  window2.noLoop();
  window2.setActionOnClose(G4P.KEEP_OPEN);
  window2.addDrawHandler(this, "win_draw1");
  pauseButton = new GButton(window2, 2, 5, 80, 30);
  pauseButton.setText("Pause");
  pauseButton.addEventHandler(this, "pauseButtonPressed");
  Reset = new GButton(window2, 149, 5, 80, 30);
  Reset.setText("Restart");
  Reset.setLocalColorScheme(GCScheme.RED_SCHEME);
  Reset.addEventHandler(this, "ResetButtonPressed");
  PlasticAmount = new GSlider(window2, 6, 49, 100, 40, 10.0);
  PlasticAmount.setLimits(60, 20, 100);
  PlasticAmount.setNumberFormat(G4P.INTEGER, 0);
  PlasticAmount.setOpaque(false);
  PlasticAmount.addEventHandler(this, "PlasticAmountClick");
  window2.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window2;
GButton pauseButton; 
GButton Reset; 
GSlider PlasticAmount; 
