class Paddle {
 
  int xpos, ypos;
  float xvel;
  int padwidth;
  int padheight;
  color paddlecol;
  int maxspeed = 4;
  
  int powerupstate;
  // Powerups
  // 0 - Nothing
  // 1 - Longer paddle
  // 2 - Faster paddle
  // 3 - Galaga mode
  // 4 - Multi-ball
  // 5 - Fireball 
  
  
  Paddle(int pw, int ph, int pus, color c) {
        
    padwidth = pw;
    padheight = ph;
    powerupstate = pus;
    paddlecol = c;
    xvel = 0;
  
}
  
 
  void update() {
    
    fill(paddlecol);
    rect(xpos, ypos, padwidth, padheight);
    
    xpos += xvel;
    
    if(leftpressed && rightpressed)
    {
      xvel = 0;
    }
    else if(leftpressed)
    {
      xvel = -maxspeed;
    } 
    else if (rightpressed)
    {
      xvel = maxspeed;
    }
    else
    {
      xvel = 0;
    }
    
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
  
  
  color getColor()
  {
    return paddlecol;
  }
  void setColor(color c)
  {
    paddlecol = c;
  }
  
  void setMaxSpeed(int s)
  {
    maxspeed = s;
  }
  
}