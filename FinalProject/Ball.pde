class Ball {
 
  int xpos, ypos;
  float xvel, yvel;
  int size = 20;
  color ballcol = color(255,0,0);
  
  boolean active;
    
  Ball()
  {
    active = false;
    xvel = 0;
    yvel = 0;
  }
  
  Ball(boolean a) 
  {
    active = a;
    xvel = 0;
    yvel = 0;
  }  
  

  
  void update()
  { 
    fill(ballcol);
    noStroke();
    ellipse(xpos, ypos, size, size);
    xpos += xvel;
    ypos += yvel;
  }
  
  
  // Getters and setters
  
  void setColor(color c)
  {
    ballcol = c;
  }
  
  color getColor()
  {
    return ballcol;
  }
  
  void setLocation(int x, int y)
  {
    xpos = x;
    ypos = y;
  }
  
  int getX()
  {
    return xpos;
  }
  int getY()
  {
    return ypos;
  }
  
  
}
