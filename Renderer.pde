float angle = 0;
HyperCube steve = new HyperCube(0,0,0,0);
HyperCube jane = new HyperCube(0,1,0,0);
void setup() {
  size(600, 400);
}
void draw() {
  background(0);
  translate(width/2, height/2);
  steve.crotateXY(angle);
  steve.crotateXZ(angle);
  steve.drawCube(1.5);
  jane.crotateXY(angle);
  jane.crotateXZ(angle);
  jane.drawCube(1.5);
  angle += 0.01;
}
