class Bullet extends Entity {
  
  // States
  // 0 - non-existant
  // 1 - in action
  
  Bullet(int x, int y)
  {
    yvel = -6;
    h=13;
    w=13;
    state = 1;
    xpos = x;
    ypos = y;
  }
  
  
  void update()
  {
    if(state > 0)
    {
    fill(0);
    ellipse(xpos, ypos, h, w);
    ypos += yvel;
    }
  }
  
  
  
  
}
