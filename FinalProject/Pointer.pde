class Pointer
{
  int xpos;
  int ypos;
  int length = 60;
  int thickness = 2;
  
  float angle = 0;
  float angularvel = 0.02;
  
  Pointer()
  {
    xpos = 0;
    ypos = 0;
  }
  
  Pointer(int x, int y)
  {
    xpos = x;
    ypos = y;
  }
  
  
  void update()
  {
    translate(xpos,ypos);
    rotate(angle);
    
    stroke(0);
    strokeWeight(thickness);
    line(0, 0, 0, -length);
    
    angle += angularvel;
    
    if (angle > (PI/4) || angle < (-PI/4))
    {
      angularvel = -angularvel;
    }
    
    resetMatrix();
  }
  
  void setLocation(int x, int y)
  {
    xpos = x;
    ypos = y;
  }
  
  
  
  
  
  
  
  
  
  
  
  
}
