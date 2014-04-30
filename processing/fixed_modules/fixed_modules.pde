//=========== global variables ===========
ArrayList<Module> modules = new ArrayList<Module>();
int initialModulesN = 37;
ExpManager eManager = new ExpManager();

//=========== setup() ===========
void setup() {
  size(1000, 600, P2D); 
  colorMode(HSB, 360, 100, 100);


  for (int i = 1; i <= initialModulesN; i++) {
    int polyN = 6;
    float r = 40;
    float moduleWidth = 2*r*sin((PI - (2*PI/polyN))/2);
    float moduleSide = 2*r*sin(PI/polyN);
    float lx = 0;
    float ly = 0;

    if (i >= 1 && i <= 4) {
      lx = width/2 - moduleWidth*3/2 + moduleWidth*(i-1);
      ly = height/2 - r*3 - moduleSide*3/2;
    } 
    else if (i >= 5 && i <= 9) {
      lx = width/2 - moduleWidth*2 + moduleWidth*(i-5);
      ly = height/2 - r*2 - moduleSide;
    } 
    else if (i >= 10 && i <= 15) {
      lx = width/2 - moduleWidth*5/2 + moduleWidth*(i-10);
      ly = height/2 - r - moduleSide*1/2;
    } 
    else if (i >= 16 && i <= 22) {
      lx = width/2 - moduleWidth*3 + moduleWidth*(i-16);
      ly = height/2;
    } 
    else if (i >= 23 && i <= 28) {
      lx = width/2 - moduleWidth*5/2 + moduleWidth*(i-23);
      ly = height/2 + r + moduleSide*1/2;
    } 
    else if (i >= 29 && i <= 33) {
      lx = width/2 - moduleWidth*2 + moduleWidth*(i-29);
      ly = height/2 + r*2 + moduleSide;
    } 
    else if (i >= 34 && i <= 37) {
      lx = width/2 - moduleWidth*3/2 + moduleWidth*(i-34);
      ly = height/2 + r*3 + moduleSide*3/2;
    }

    int id = i;    
    modules.add(new Module(polyN, r, lx, ly, id));
  }

  for (Module m : modules) {
    m.setMyNeighbors();
  }
}

//=========== draw() ===========
void draw() {
  background(200);

  eManager.process();

  for (Module m : modules) {
    m.display();
  }
}

//=========== keyPressed() ===========
void keyPressed() {
  int id = 0;
    //get module's id at the current mouse position
    for (Module m : modules) {
      float incircleRadius = m.radius*0.7;
      if ((mouseX > m.location.x - incircleRadius && mouseX < m.location.x + incircleRadius) &&
        (mouseY > m.location.y - incircleRadius && mouseY < m.location.y + incircleRadius)) {
        id = m.id;
      }
    }
    
  eManager.keyHandler(key, id);

  //-------- debug --------
  if (key == 'z') {
    for (Module m : modules) {
      m.showState();
    }
  }
}

//=========== mousePressed() ===========
void mousePressed() {
}

