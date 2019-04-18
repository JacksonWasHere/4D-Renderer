float[][] vecToMat4(P4Vector v){
  float[][] m = new float[4][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  m[3][0] = v.w;
  return m;
}

P4Vector matToVec4(float[][] m){
  P4Vector v = new P4Vector(m[0][0],m[1][0],0,0);
  if(m.length >= 4){
    v.z = m[2][0];
    v.w = m[3][0];
  } else if(m.length >= 3){
    v.z = m[2][0];
  }
  return v;
}

P4Vector project4(float distance,P4Vector v){
  float w = 1/(distance - v.z);
  float[][] projection = {
    {w, 0, 0, 0}, 
    {0, w, 0, 0},
    {0, 0, w, 0}
  };
  matmul4(projection,v);
  float[][] projection2 = {
    {w, 0, 0, 0}, 
    {0, w, 0, 0}
  };
  return matmul4(projection2,v);
}

P4Vector matmul4(float[][] a, P4Vector bv) {
  float[][] b = vecToMat4(bv);
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length; 
  
  if(colsA != rowsB){
    println("Columns of A must match rows of B");
    return null;
  } 
  
  float[][] result = new float[rowsA][colsB];
  
  for (int i = 0; i < rowsA; i++){
    for(int j = 0; j < colsB; j++){
       float sum = 0;
       for( int k = 0; k < colsA; k++){
         sum += a[i][k] * b[k][j];
       }
       result[i][j] = sum;
    }
  }
  return matToVec4(result);
}
