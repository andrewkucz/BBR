class Brick {
  
  int powerup;
  int state; // ranges from 0 (invisible) to 3 (or 5?) 
  color brickcol;
  int level;
  
  // do bricks need an x and y for collision detection
  
  
  Brick()
  {
    state=1;
    powerup=0;
    brickcol = color(0);
  }
  
  Brick(int s, int p, int l)
  {
    state = s;
    powerup = p;
    level = l;
    
    if(l == 1)
    {
      brickcol = color(0,0,map(s, 1, 3, 30, 255));
    }
    
    // other level color schemes here
    
    

  }
    
  void hit()
  {
    if(state>0)
    state--;
    
    powerup = 0;
  }
  
  
  
}