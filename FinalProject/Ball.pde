class Ball extends Entity {
 
  Pointer arrow;
  
  // State definitions
  
  // 0 - inactive / invisible
  // 1 - visible, waiting to start (unmoving, attached to paddle)
  // 2 - in action - bouncing around, checking for collisions
  // 3 - dead (?)
  
  Ball(int s) 
  {
    state = s;
    if(s == 1)
    {
       arrow = new Pointer(); 
    }
    w = 20;
    h = 20;
    col = color(255,0,0);
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
    
    fill(col);
    noStroke();
    ellipse(xpos, ypos, w, h);
    xpos += xvel;
    ypos += yvel;
    
  }
  
  
  void setState(int s)
  {
    state = s;
  }

  int getState()
  {
    return state;
  }
  
  
}
