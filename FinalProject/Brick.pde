class Brick {
  
  Powerup power;
  int state; // ranges from 0 (invisible) to 3 (or 5?) 
  color brickcol;
  int level;
  int xpos, ypos, brickh, brickw;
  
  
  Brick()
  {
    state=0;
  }
  
  Brick(int x, int y, int s, int l, Powerup p)
  {
    xpos = x;
    ypos = y;
    state = s;
    level = l;
    power = p;
    
    if(l == 1)
    {
      brickcol = color(0,0,map(s, 1, 3, 30, 255));
    }
    else
    {
      brickcol = color(255,0,0);
    }
    
    // other level color schemes here
  }
  
  void drawBrick()
  {
    rect(xpos, ypos, brickw, brickh);
    power.update();
  }
  
  
  void hit()
  {
    if(state>0)
    state--;
  }
  
  int getState()
  {
    return state;
  }
  
  
  
}