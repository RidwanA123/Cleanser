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

  if (buttonPressed == false) { //if when we pressed the button, it had not yet pressed

    noLoop(); //pauses 
    buttonPressed = true;  //record that we pressed it
    pauseButton.setText("Resume"); //button changes to resume
  } 
  else {

    loop(); //resumes
    buttonPressed = false; //record the button has returned to its previous value
    pauseButton.setText("Pause"); //button changes to pause
  }
} //_CODE_:pauseButton:933206:

public void ResetButtonPressed(GButton source, GEvent event) { //_CODE_:Reset:608023:
  loop(); //reloop incase someone paused then restarted
  reset();  //reset function in main
  //restart();
} //_CODE_:Reset:608023:

public void PlasticAmountClick(GSlider source, GEvent event) { //_CODE_:PlasticAmount:528106:
  removePol(); //removes initial pollution
  pollutionChance = PlasticAmount.getValueF(); //changes pollution chance
  loop();
  reset(); //resetting changes plastic amount. Done to discourage people from changing it while bot is making progress
} //_CODE_:PlasticAmount:528106:

public void slider_change2(GSlider source, GEvent event) { //_CODE_:CleanserStorage:536613:
  storSize = CleanserStorage.getValueF(); //storage size of the bot (refer to bot tab)
} //_CODE_:CleanserStorage:536613:

public void textfield1_change1(GTextField source, GEvent event) { //_CODE_:NumberOfCleanser:985657:
  botNum = int(NumberOfCleanser.getText()); //changes amount of bots 

  if (botNum == 0) { //makes sure you can never have anything less than 1
    botNum = 1;
  } 
  else if (botNum > 5) { //makes sure you can never have anything more than 5
    botNum = 5;
  }

  if (botNum < lastBot) {
    int count = lastBot - botNum;

    for (int i = 0; i < count; i++) {  //if botNum is lower than lastBot, function in bot tab is called
      Clenser.decreaseBot();
    }
  } 
  else if (botNum > lastBot) {        //if botNum is higher than lastBot, function in bot tab is called
    int count = botNum - lastBot;

    for (int i = 0; i < count; i++) {
      Clenser.increaseBot();
    }
  }
  lastBot = botNum;            //at the end, LastBot = botNum allows program to remove bots should someone put a lower value then their previous one
} //_CODE_:NumberOfCleanser:985657:

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:BatteryQuality:496630:
  batterylife = BatteryQuality.getValueF(); //alters batteryLife depending on user settings
  Clenser.batteryLife(); //batteryLife function in bot tab
} //_CODE_:BatteryQuality:496630:

public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:Oceans:849723: //allows for the change of map
  int index = Oceans.getSelectedIndex(); //each part of the droplist has an index

  mapChanged = true; //map change becomes true
  //It will sometimes load another map while loading the main so it can reset the map better
  if (index == 1) { //parameters change if index 1 is selected


    Clenser.resetBot();
    resetLand();              
    removePol();

    loadArcticOcean();
    loadPixels();
    getpix();
    Clenser.resetBot();


    resetLand();
    removePol();
    pollutionChance = PlasticAmount.getValueF();
    loadIndianOcean();
    loadPixels();
    getpix();
    Clenser.resetBot();
  } 
  else if (index == 2) {//parameters change if index 2 is selected


    resetLand();
    removePol();
    pollutionChance = PlasticAmount.getValueF();
    loadIndianOcean();
    loadPixels();                //to not mess up land;
    getpix();
    Clenser.resetBot();




    Clenser.resetBot();
    resetLand();
    removePol();

    loadArcticOcean();
    loadPixels();
    getpix();
    Clenser.resetBot();
  } 
  else if (index == 3) {//parameters change if index 3 is selected

    resetLand();
    removePol();

    pollutionChance = PlasticAmount.getValueF();
    loadAtlanticOcean();
    loadPixels();
    getpix();

    Clenser.resetBot();
  } 
  else {//parameters change if index 0 is selected

    resetLand();
    removePol();
    pollutionChance = PlasticAmount.getValueF();
    loadPacificOcean();
    loadPixels();
    getpix();
    Clenser.resetBot();
  }
} //_CODE_:Oceans:849723:

public void checkbox1_clicked1(GCheckbox source, GEvent event) { //_CODE_:efficiencyCheckbox:302654:
  reset();
} //_CODE_:efficiencyCheckbox:302654:

public void checkbox2_clicked1(GCheckbox source, GEvent event) { //_CODE_:scatteredVal:486988:

  removePol();
  plasticGeneration();
} //_CODE_:scatteredVal:486988:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window2 = GWindow.getWindow(this, "Control Module", 0, 0, 255, 220, JAVA2D);
  window2.noLoop();
  window2.setActionOnClose(G4P.KEEP_OPEN);
  window2.addDrawHandler(this, "win_draw1");
  pauseButton = new GButton(window2, 34, 3, 80, 30);
  pauseButton.setText("Pause");
  pauseButton.addEventHandler(this, "pauseButtonPressed");
  Reset = new GButton(window2, 142, 3, 85, 29);
  Reset.setText("Restart");
  Reset.setLocalColorScheme(GCScheme.RED_SCHEME);
  Reset.addEventHandler(this, "ResetButtonPressed");
  PlasticAmount = new GSlider(window2, 3, 100, 100, 40, 10.0);
  PlasticAmount.setLimits(1, 1, 60);
  PlasticAmount.setNumberFormat(G4P.INTEGER, 0);
  PlasticAmount.setOpaque(false);
  PlasticAmount.addEventHandler(this, "PlasticAmountClick");
  CleanserStorage = new GSlider(window2, 3, 54, 100, 40, 10.0);
  CleanserStorage.setLimits(5.0, 5.0, 90.0);
  CleanserStorage.setNumberFormat(G4P.DECIMAL, 2);
  CleanserStorage.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  CleanserStorage.setOpaque(false);
  CleanserStorage.addEventHandler(this, "slider_change2");
  NumberOfCleanser = new GTextField(window2, 132, 115, 111, 17, G4P.SCROLLBARS_NONE);
  NumberOfCleanser.setText("1");
  NumberOfCleanser.setPromptText("1");
  NumberOfCleanser.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  NumberOfCleanser.setOpaque(true);
  NumberOfCleanser.addEventHandler(this, "textfield1_change1");
  label1 = new GLabel(window2, 114, 96, 155, 20);
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
  BatteryQuality.setLimits(50.0, 10.0, 90.0);
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
  label3.setText("Plastic Amount");
  label3.setOpaque(false);
  Oceans = new GDropList(window2, 145, 58, 90, 100, 4, 10);
  Oceans.setItems(loadStrings("list_849723"), 0);
  Oceans.addEventHandler(this, "dropList1_click1");
  efficiencyCheckbox = new GCheckbox(window2, 126, 152, 120, 20);
  efficiencyCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  efficiencyCheckbox.setText("Efficient");
  efficiencyCheckbox.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  efficiencyCheckbox.setOpaque(false);
  efficiencyCheckbox.addEventHandler(this, "checkbox1_clicked1");
  scatteredVal = new GCheckbox(window2, 127, 176, 120, 20);
  scatteredVal.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  scatteredVal.setText("Plastic Scattered");
  scatteredVal.setLocalColorScheme(GCScheme.RED_SCHEME);
  scatteredVal.setOpaque(false);
  scatteredVal.addEventHandler(this, "checkbox2_clicked1");
  label4 = new GLabel(window2, 140, 37, 80, 20);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Ocean:");
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
GCheckbox efficiencyCheckbox; 
GCheckbox scatteredVal; 
GLabel label4; 
