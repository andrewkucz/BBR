class Paddle extends Entity {
  
  
  int speed = 4;
  
  // Paddle power up (state definitions)
  // 0 - Normal / nothing
  // 1 - Longer paddle
  // 2 - Faster paddle
  // 3 - Galaga mode

  
  
  Paddle(int pw, int ph, int pus, color c) {
        
    w = pw;
    h = ph;
    state = pus;
    col = c;
    xvel = 0;
}
  
 
  void update() {
    
    fill(col);
    noStroke();
    rect(xpos, ypos, w, h);
    
    xpos += xvel;
    
    if(leftpressed && rightpressed)
    {
      xvel = 0;
    }
    else if(leftpressed)
    {
      xvel = -speed;
    } 
    else if (rightpressed)
    {
      xvel = speed;
    }
    else
    {
      xvel = 0;
    }
    
  }
  
  void setSpeed(int s)
  {
    speed = s;
  }
  int getSpeed()
  {
    return speed;
  }


}
