PVector location;
PVector mLocation;

float radius = 20;
int polyN = 6;
int regionWidth = 10;

void setup() {
  size(600, 400, P2D);
  location = new PVector(300, 200);
  mLocation = new PVector(400, 100);
}

void draw() {
  background(255);
  location.set(mouseX, mouseY);
  
  //vectors about this module  
  PVector thisVertex1 = new PVector(0, -radius);
  PVector thisVertex2 = new PVector(0, -radius);
  thisVertex2.rotate(2*PI / polyN);

  //vectors about each one of other modules
  PVector otherVertex1 = new PVector(0, -radius);
  PVector otherVertex2 = new PVector(0, -radius);
  otherVertex1.rotate(PI); //opposite side of the module above
  otherVertex2.rotate(PI); //opposite side of the module above        
  otherVertex2.rotate(2*PI / polyN);


  //calc the location of the middle point on each face of this module
  PVector thisFaceMiddle = new PVector(location.x, location.y);
  PVector thisFaceSegment = new PVector(0, 0);
  thisFaceSegment = PVector.sub(thisVertex2, thisVertex1);
  thisFaceSegment.mult(0.5);
  thisFaceMiddle.add(thisVertex1);
  thisFaceMiddle.add(thisFaceSegment);

  //calc the location of the ends of the face, which corresponds to the module's face calced above, of each one of other modules
  PVector otherFaceEnd1 = new PVector(mLocation.x, mLocation.y);
  PVector otherFaceEnd2 = new PVector(mLocation.x, mLocation.y);
  otherFaceEnd1.add(otherVertex1);
  otherFaceEnd2.add(otherVertex2);

  //magnet region box
  PVector boxVertex1 = otherFaceEnd1.get();
  PVector boxVertex2 = otherFaceEnd1.get();
  PVector boxVertex3 = otherFaceEnd2.get();
  PVector boxVertex4 = otherFaceEnd2.get();

  PVector boxWidth = new PVector(0, -regionWidth);
  boxWidth.rotate((2*PI / polyN) - (2*PI / polyN) / 2);
  boxVertex1.add(boxWidth);
  boxVertex3.add(boxWidth);
  boxWidth.rotate(PI);
  boxVertex2.add(boxWidth);
  boxVertex4.add(boxWidth);

  //region
  ////////////////////////////////
  fill(150);
  noStroke();
  beginShape();
  vertex(boxVertex1.x, boxVertex1.y);
  vertex(boxVertex2.x, boxVertex2.y);
  vertex(boxVertex4.x, boxVertex4.y);
  vertex(boxVertex3.x, boxVertex3.y);
  endShape(CLOSE);
  
  text("1", boxVertex1.x, boxVertex1.y);
  text("2", boxVertex2.x, boxVertex2.y);
  text("3", boxVertex3.x, boxVertex3.y);
  text("4", boxVertex4.x, boxVertex4.y);
  ////////////////////////////////

  //points
  ////////////////////////////////
  strokeWeight(3);
  stroke(0);
  point(location.x, location.y);
  stroke(0, 0, 255);
  point(thisFaceMiddle.x, thisFaceMiddle.y);

  stroke(255, 0, 0);
  point(mLocation.x, mLocation.y);
  strokeWeight(1);
  line(otherFaceEnd1.x, otherFaceEnd1.y, otherFaceEnd2.x, otherFaceEnd2.y);
  ////////////////////////////////

  line(0, 0, boxVertex1.x, boxVertex1.y);
  line(0, 0, boxVertex2.x, boxVertex2.y);
  line(0, 0, boxVertex3.x, boxVertex3.y);
  line(0, 0, boxVertex4.x, boxVertex4.y);

 
  //change original points to "(location.x, location.y)"
  thisFaceMiddle.sub(location);
  boxVertex1.sub(location);
  boxVertex2.sub(location);
  boxVertex3.sub(location);
  boxVertex4.sub(location);

  pushMatrix();
  translate(300, 200);
  stroke(0, 255, 0);
  line(0, 0, thisFaceMiddle.x, thisFaceMiddle.y);
  line(0, 0, boxVertex1.x, boxVertex1.y);
  line(0, 0, boxVertex2.x, boxVertex2.y);
  line(0, 0, boxVertex3.x, boxVertex3.y);
  line(0, 0, boxVertex4.x, boxVertex4.y);
  popMatrix();  

  
  //rotate them to line them and thisFaceMiddle up vertically
  thisFaceMiddle.rotate(-((2*PI / polyN) - (2*PI / polyN) / 2));
  boxVertex1.rotate(-((2*PI / polyN) - (2*PI / polyN) / 2));
  boxVertex2.rotate(-((2*PI / polyN) - (2*PI / polyN) / 2));
  boxVertex3.rotate(-((2*PI / polyN) - (2*PI / polyN) / 2));
  boxVertex4.rotate(-((2*PI / polyN) - (2*PI / polyN) / 2));  
  
  pushMatrix();
  translate(300, 200);
  stroke(255, 0, 0);
  line(0, 0, thisFaceMiddle.x, thisFaceMiddle.y);
  line(0, 0, boxVertex1.x, boxVertex1.y);
  line(0, 0, boxVertex2.x, boxVertex2.y);
  line(0, 0, boxVertex3.x, boxVertex3.y);
  line(0, 0, boxVertex4.x, boxVertex4.y);
  popMatrix();  

  
  if (
  ((thisFaceMiddle.x > boxVertex3.x) && (thisFaceMiddle.y > boxVertex3.y)) &&
  ((thisFaceMiddle.x < boxVertex2.x) && (thisFaceMiddle.y < boxVertex2.y))  
  ){
    text("true", 20, 20);
  }
}
