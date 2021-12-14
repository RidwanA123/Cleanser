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
    buttonPressed = false;
    pauseButton.setText("Pause");
   
  }
} //_CODE_:pauseButton:933206:

public void ResetButtonPressed(GButton source, GEvent event) { //_CODE_:Reset:608023:
  reset();
  //restart();

} //_CODE_:Reset:608023:

public void PlasticAmountClick(GSlider source, GEvent event) { //_CODE_:PlasticAmount:528106:
  removePol();
  pollutionChance = PlasticAmount.getValueF();
  getpix();


} //_CODE_:PlasticAmount:528106:

public void Amount_They_pick(GSlider source, GEvent event) { //_CODE_:CleanserStorage:536613:
  println("CleanserStorage - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:CleanserStorage:536613:

public void textfield1_change1(GTextField source, GEvent event) { //_CODE_:NumberOfCleanser:985657:
  println("NumberOfCleanser - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:NumberOfCleanser:985657:

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:BatteryQuality:496630:
  batterylife = BatteryQuality.getValueF();
  Clenser.batteryLife();
} //_CODE_:BatteryQuality:496630:

public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:Oceans:849723:
  println("Oceans - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:Oceans:849723:

public void slider1_change2(GSlider source, GEvent event) { //_CODE_:Efficiency:809885:
  println("Efficiency - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:Efficiency:809885:



// Create all the GUI controls.
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window2 = GWindow.getWindow(this, "Window title", 0, 0, 255, 320, JAVA2D);
  window2.noLoop();
  window2.setActionOnClose(G4P.KEEP_OPEN);
  window2.addDrawHandler(this, "win_draw1");
  pauseButton = new GButton(window2, 2, 5, 80, 30);
  pauseButton.setText("Pause");
  pauseButton.addEventHandler(this, "pauseButtonPressed");
  Reset = new GButton(window2, 91, 4, 85, 29);
  Reset.setText("Restart");
  Reset.setLocalColorScheme(GCScheme.RED_SCHEME);
  Reset.addEventHandler(this, "ResetButtonPressed");
  PlasticAmount = new GSlider(window2, 3, 100, 100, 40, 10.0);
  PlasticAmount.setLimits(1, 1, 100);
  PlasticAmount.setNumberFormat(G4P.INTEGER, 0);
  PlasticAmount.setOpaque(false);
  PlasticAmount.addEventHandler(this, "PlasticAmountClick");
  CleanserStorage = new GSlider(window2, 3, 54, 100, 40, 10.0);
  CleanserStorage.setLimits(10.0, 5.0, 20.0);
  CleanserStorage.setNumberFormat(G4P.DECIMAL, 2);
  CleanserStorage.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  CleanserStorage.setOpaque(false);
  CleanserStorage.addEventHandler(this, "Amount_They_pick");
  NumberOfCleanser = new GTextField(window2, 134, 177, 111, 17, G4P.SCROLLBARS_NONE);
  NumberOfCleanser.setText("0");
  NumberOfCleanser.setPromptText("0");
  NumberOfCleanser.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  NumberOfCleanser.setOpaque(true);
  NumberOfCleanser.addEventHandler(this, "textfield1_change1");
  label1 = new GLabel(window2, 113, 162, 155, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Number Of Cleansers");
  label1.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  label1.setOpaque(false);
  BatteryLevel = new GLabel(window2, 7, 139, 90, 20);
  BatteryLevel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  BatteryLevel.setText("Battery Quality");
  BatteryLevel.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  BatteryLevel.setOpaque(false);
  BatteryQuality = new GSlider(window2, 5, 142, 100, 40, 10.0);
  BatteryQuality.setLimits(0.5, 0.0, 1.0);
  BatteryQuality.setNumberFormat(G4P.DECIMAL, 2);
  BatteryQuality.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  BatteryQuality.setOpaque(false);
  BatteryQuality.addEventHandler(this, "slider1_change1");
  label2 = new GLabel(window2, 2, 47, 97, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Clenser Storage");
  label2.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label2.setOpaque(false);
  label3 = new GLabel(window2, 7, 93, 91, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Plastic Amountl");
  label3.setOpaque(false);
  Oceans = new GDropList(window2, 145, 58, 90, 100, 4, 10);
  Oceans.setItems(loadStrings("list_849723"), 0);
  Oceans.addEventHandler(this, "dropList1_click1");
  Efficiency = new GSlider(window2, 5, 183, 100, 40, 10.0);
  Efficiency.setLimits(0.5, 0.0, 1.0);
  Efficiency.setNumberFormat(G4P.DECIMAL, 2);
  Efficiency.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  Efficiency.setOpaque(false);
  Efficiency.addEventHandler(this, "slider1_change2");
  label4 = new GLabel(window2, 11, 180, 80, 20);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Efficiency");
  label4.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  label4.setOpaque(false);
  window2.loop();
}

// Variable declarations
// autogenerated do not edit
GWindow window2;
GButton pauseButton;
GButton Reset;
GSlider PlasticAmount;
GSlider CleanserStorage;
GTextField NumberOfCleanser;
GLabel label1;
GLabel BatteryLevel;
GSlider BatteryQuality;
GLabel label2;
GLabel label3;
GDropList Oceans;
GSlider Efficiency;
GLabel label4; 
