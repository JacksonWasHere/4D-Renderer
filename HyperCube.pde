class HyperCube {
  P4Vector[] points = new P4Vector[16];
  P4Vector[] projected = new P4Vector[16];
  
  public HyperCube (float x, float y, float z, float w) {
    points[0] = new P4Vector(x-0.5, y-0.5, z-0.5,w-0.5);
    points[1] = new P4Vector(x+0.5, y-0.5, z-0.5,w-0.5);
    points[2] = new P4Vector(x+0.5, y+0.5, z-0.5,w-0.5);
    points[3] = new P4Vector(x-0.5, y+0.5, z-0.5,w-0.5);
    points[4] = new P4Vector(x-0.5, y-0.5, z+0.5,w-0.5);
    points[5] = new P4Vector(x+0.5, y-0.5, z+0.5,w-0.5);
    points[6] = new P4Vector(x+0.5, y+0.5, z+0.5,w-0.5);
    points[7] = new P4Vector(x-0.5, y+0.5, z+0.5,w-0.5);
    points[8] = new P4Vector(x-0.5, y-0.5, z-0.5,w+0.5);
    points[9] = new P4Vector(x+0.5, y-0.5, z-0.5,w+0.5);
    points[10] = new P4Vector(x+0.5, y+0.5, z-0.5,w+0.5);
    points[11] = new P4Vector(x-0.5, y+0.5, z-0.5,w+0.5);
    points[12] = new P4Vector(x-0.5, y-0.5, z+0.5,w+0.5);
    points[13] = new P4Vector(x+0.5, y-0.5, z+0.5,w+0.5);
    points[14] = new P4Vector(x+0.5, y+0.5, z+0.5,w+0.5);
    points[15] = new P4Vector(x-0.5, y+0.5, z+0.5,w+0.5);
    for(int i = 0; i<projected.length; i++){
      projected[i] = points[i];
    }
  }
  
  void drawCube(float dist){
    cproject(dist);
    
    for(P4Vector pp:projected){
      stroke(255);
      strokeWeight(16);
      point(pp.x,pp.y);
    }
    
    for(int i = 0; i < 4; i++){
      //outer cube
      connect(i,(i+1)%4,projected);
      connect(i+4,((i+5)%4)+4,projected);
      connect(i,i+4, projected);
      
      //inner cube
      connect(i+8,(i+1)%4+8,projected);
      connect(i+12,((i+13)%4)+12,projected);
      connect(i+4,i+12, projected);
      
      //inout
      connect(i,i+8,projected);
      connect(i+8,i+12,projected);
    }
    for(int i = 0; i<projected.length; i++){
      projected[i] = points[i];
    }
  }
  
  void cproject(float dist){
    int index = 0;
    while(index<projected.length){
      projected[index] = project4(dist,projected[index]);
      projected[index].mult(100);
      index++;
    }
  }
  
  void crotateXY(float angle){
    for (int i = 0; i < points.length; i++) {
      float[][] ang = {
        {1,0,0,0},
        {0,1,0,0},
        {0,0,cos(angle),-sin(angle)},
        {0,0,sin(angle),cos(angle)}
      };
      projected[i] = matmul4(ang, projected[i]);
    }
  }
  
  void crotateXZ(float angle){
    for (int i = 0; i < points.length; i++) {
      float[][] ang = {
        {1, 0, 0, 0},
        {0,cos(angle),0,-sin(angle)},
        {0, 0, 1, 0},
        {0,sin(angle),0,cos(angle)}
      };
      projected[i] = matmul4(ang, projected[i]);
    }
  }
  
  void crotateZW(float angle){
    for (int i = 0; i < points.length; i++) {
      float[][] ang = {
        {cos(angle),-sin(angle),0,0},
        {sin(angle),cos(angle),0,0},
        {0,0,1,0},
        {0,0,0,1}
      };
      projected[i] = matmul4(ang, projected[i]);
    }
  }
  
  void connect(int i, int j, P4Vector[] points){
    P4Vector a = points[i];
    P4Vector b = points[j];
    strokeWeight(2);
    stroke(255);
    line(a.x,a.y,b.x,b.y);
  }
}
