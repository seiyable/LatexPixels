//=========== global variables ===========
ArrayList<Module> modules = new ArrayList<Module>();
int initialModulesN = 2;
Arduino arduino;

//=========== setup() ===========
void setup() {
  size(1000, 600, P2D); 
  colorMode(HSB, 360, 100, 100);

  for (int i = 0; i < initialModulesN; i++) {
    float gap = 100;
    float lx = width / 2 - (gap/2) + gap*i;
    float ly = height / 2;
    int id = i+1;
    modules.add(new Module(lx, ly, id));
  }

  arduino = new Arduino(width - 150, height / 2, 100);
}

//=========== draw() ===========
void draw() {
  background(200);
  text("Click on a module to drag it", 20, 20);
  text("Press 'A' to add a new module", 20, 40);
  text("Press 'R' on a module to rotate it", 20, 60);


  arduino.display();

  for (Module m : modules) {
    m.display();
  }

  for (Module m : modules) {
    m.dragging();
  }
}

//=========== keyPressed() ===========
void keyPressed() {
  //check dragging
  boolean keyOK = false;
  int count = 0;
  for (Module m : modules) {
    count += m.checkDragging();
  }
  if (count == 0) {
    keyOK = true;
  }

  if (keyOK == true) {
    //add a new module
    if (key == 'a') {
      float lx = mouseX;
      float ly = mouseY;
      int id = modules.size() + 1;
      modules.add(new Module(lx, ly, id));
      Module m = modules.get(modules.size() - 1);
      m.startOrStopDragging();
    }

    //rotate the module
    else if (key == 'r') {
      for (Module m : modules) {
        m.rotateModule();
      }
    }
  }
}

//=========== mousePressed() ===========
void mousePressed() {
  for (Module m : modules) {
    m.startOrStopDragging();
  }
}

