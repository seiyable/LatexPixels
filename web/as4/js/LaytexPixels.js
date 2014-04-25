//=========== global variables ===========
var modules = [];

var initialModulesN = 2;
var arduino;

//=========== setup() ===========
function setup() {
  var canvas = createCanvas(window.innerWidth, window.innerHeight);
  canvas.mousePressed(dragOnOff);

  for (var i = 0; i < initialModulesN; i++) {
    var polyN = 6; //must be even number
    var r = 20;
    var modWidth = 2*r*sin((PI - (2*PI/polyN))/2);
    var gapN = 1; //determine space between modules
    var space = modWidth*gapN;
    var lx = width / 2 - ((modWidth+space)*initialModulesN/2 - space/2) + (modWidth+space)*i;
    var ly = height / 2;
    var id = i+1;
    modules.push(new Module(polyN, r, lx, ly, id));
  }

  arduino = new Arduino(width - 150, height / 2, 100);
}

//=========== draw() ===========
function draw() {
  background(230);
  text("Click on a module to drag it", 20, 20);
  text("Press 'A' to add a new module", 20, 40);
  text("Press 'R' on a module to rotate it", 20, 60);


  //arduino.display();

  for(var i = 0; i < modules.length; i++){
    modules[i].display();
  }

  for(var i = 0; i < modules.length; i++){
    modules[i].draggingOn();
  }

  for(var i = 0; i < modules.length; i++){
    modules[i].sinwaveBlink();
  }

  for(var i = 0; i < modules.length; i++){
    modules[i].updateClock();
  }

}

//=========== keyPressed() ===========
function keyPressed() {
  console.log(key + " pressed");

  //check dragging
  var keyOK = false;
  var count = 0;
  for(var i = 0; i < modules.length; i++){
    count += modules[i].checkDragging();
  }
  if (count == 0) {
    keyOK = true;
  }

  if (keyOK == true) {
    //add a new module
    if (key == 'A') {
      var polyN = 6;
      var r = 20;
      var lx = mouseX;
      var ly = mouseY;
      var id = modules.length + 1;
      modules.push(new Module(polyN, r, lx, ly, id));
      modules[modules.length - 1].startOrStopDragging();
    }

    //rotate the module
    else if (key == 'R') {
      for(var i = 0; i < modules.length; i++){
        modules[i].rotateModule();
      }
    }
  }
}

//=========== mousePressed() ===========
function dragOnOff() {
  for(var i = 0; i < modules.length; i++){
    modules[i].startOrStopDragging();
  }
}
