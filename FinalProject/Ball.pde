class Ball {
 
  int xpos, ypos;
  float xvel, yvel;
  int size = 20;
  color ballcol = color(255,0,0);
  Pointer arrow;
  
  int state;
  // 0 - inactive / invisible
  // 1 - visible, waiting to start
  // 2 - in action
  // 3 - dead
    
  Ball()
  {
    state = 0;
    xvel = 0;
    yvel = 0;
  }
  
  Ball(int s) 
  {
    state = s;
    if(s == 1)
    {
       arrow = new Pointer(); 
    }
    xvel = 0;
    yvel = 0;
  }  
  

  
  void update()
  { 
    
    if(state==1)
    {
      arrow.setLocation(xpos, ypos);
      arrow.update();
    }
    
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
  int getState()
  {
    return state;
  }
  
  
}
