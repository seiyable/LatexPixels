class MShape {
  int polyN;
  float radius;
  PVector[] polyVertexes;

  MShape(int _polyN, float _radius) {
    polyN = _polyN;
    radius = _radius;
    polyVertexes = new PVector[polyN];
    PVector outline = new PVector(0, -radius);
    for (int i = 0; i < polyN; i++) {
      polyVertexes[i] = new PVector(outline.x, outline.y);
      outline.rotate(2*PI / polyN);
    }
  }

  void display() {
    beginShape();
    for (int i = 0; i < polyN; i++) {
      vertex(polyVertexes[i].x, polyVertexes[i].y);
    }
    endShape(CLOSE);
  }
}

