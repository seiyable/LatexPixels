//=========== global variables ===========
var modules = [];
var initialModulesN = 37;
var eManager;

//=========== setup() ===========
function setup() {
  var canvas = createCanvas(window.innerWidth, window.innerHeight);
  canvas.mousePressed(express);
  //canvas.touchStarted(express);
  var options = {
    preventDefault: true
  };

  var polyN = 6;
  // if user is accessing this page from computer
  var r = 40;
  var moduleWidth = 2*r*sin((PI - (2*PI/polyN))/2);
  var moduleSide = 2*r*sin(PI/polyN);

  // if user is accessing this page from mobile devices
  if(navigator.userAgent.search(/iPhone/) != -1 || navigator.userAgent.search(/iPad/) != -1 || navigator.userAgent.search(/iPod/) != -1 || navigator.userAgent.search(/Android/) != -1){
    var gap = width*0.05;
    moduleWidth = (width-gap*2) / 7;
    r = moduleWidth / (2*sin((PI - (2*PI/polyN))/2));
    moduleSide = 2*r*sin(PI/polyN);
  }

  for (var i = 1; i <= initialModulesN; i++) {
    var lx = 0;
    var ly = 0;
    
    if (i >= 1 && i <= 4) {
      lx = width/2 - moduleWidth*3/2 + moduleWidth*(i-1);
      ly = height/2 - r*3 - moduleSide*3/2;
    } else if (i >= 5 && i <= 9) {
      lx = width/2 - moduleWidth*2 + moduleWidth*(i-5);
      ly = height/2 - r*2 - moduleSide;
    } else if (i >= 10 && i <= 15) {
      lx = width/2 - moduleWidth*5/2 + moduleWidth*(i-10);
      ly = height/2 - r - moduleSide*1/2;
    } else if (i >= 16 && i <= 22) {
      lx = width/2 - moduleWidth*3 + moduleWidth*(i-16);
      ly = height/2;
    } else if (i >= 23 && i <= 28) {
      lx = width/2 - moduleWidth*5/2 + moduleWidth*(i-23);
      ly = height/2 + r + moduleSide*1/2;
    } else if (i >= 29 && i <= 33) {
      lx = width/2 - moduleWidth*2 + moduleWidth*(i-29);
      ly = height/2 + r*2 + moduleSide;
    } else if (i >= 34 && i <= 37) {
      lx = width/2 - moduleWidth*3/2 + moduleWidth*(i-34);
      ly = height/2 + r*3 + moduleSide*3/2;
    }

  var id = i;    
  modules.push(new Module(polyN, r, lx, ly, id));
  }

  eManager = new ExpManager();
  for (var i = 0; i < modules.length; i++) {
    modules[i].setMyNeighbors();
  }
}

//=========== draw() ===========
function draw() {
  background(230);
  textSize(12);

  eManager.loop();

  for(var i = 0; i < modules.length; i++){
    modules[i].display();
  }

}

//=========== touchStarted() / mousePressed() ===========
function express() {
  var x = mouseX || touchX;
  var y = mouseY || touchY;

  var id = 0;
    //get module's id at the current mouse position
    for(var i = 0; i < modules.length; i++) {
      var incircleRadius = modules[i].radius*0.7;
      if ((x > modules[i].location.x - incircleRadius && x < modules[i].location.x + incircleRadius) &&
        (y > modules[i].location.y - incircleRadius && y < modules[i].location.y + incircleRadius)) {
        id = modules[i].id;
      }
    }
  console.log(id);
  eManager.expressHandler(id);
  //eManager.keyHandler(key, id);

}

//=========== mousePressed() ===========

//=========== radioButtonPressed() ===========
$("input[type='radio']").bind( "change", function(event, ui) {
  eManager.changeDrawType(event.target.value);
});
