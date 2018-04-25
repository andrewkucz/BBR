class Paddle extends Entity {


  Gun blaster;
  int speed = 4;

  // Paddle power up (state definitions)
  // 0 - Normal / nothing
  // 1 - Longer paddle
  // 2 - Faster paddle
  // 3 - Galaga mode
  
  boolean leftpressed = false, rightpressed = false;
  boolean inBounds = true;
  
  int counter = 0;
  int duration = 750;

  Paddle(int pw, int ph, int pus, color c) {
    super();
    w = pw;
    h = ph;
    state = pus;
    col = c;
    xvel = 0;
    blaster = new Gun();
  }


  void update() {
    
    
    if(counter<=duration)
    {
      if(state==1)
      {
        w = 200;
        counter++;
      }
      else if(state==2)
      {
        speed = 8;
        counter++;
      }
      else if(state==3)
      {
        blaster.setState(1);
        blaster.setLocation(xpos+(w/2)-(blaster.w/2), ypos);
        blaster.update();
        counter++;
      }
      else
      {
        counter++;
      }
    }
    else
    {
      blaster.setState(0);
      state = 0;
      counter = 0;
      speed = 4;
      w = 118;
    }
    
    
    fill(col);
    noStroke();
    rect(xpos, ypos, w, h);
    
    if(rightpressed & !leftpressed & inBounds)
    {
      xvel = speed;
    }
    else if(leftpressed & !rightpressed & inBounds)
    {
      xvel = -speed;
    }
    else
    {
      xvel = 0;
    }
   
    xpos += xvel;

  }
  
  boolean inBoundaries(GameBoard b)
  {
    if(xpos <= b.xpos && !rightpressed)
    {
      return false;
    }
    else if(xpos+w > b.xpos+b.w && !leftpressed)
    {
     return false; 
    }
    else
    {
      return true;
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