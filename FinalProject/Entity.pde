static class Entity {

  float xpos, ypos;
  int w, h;
  int state;
  float xvel, yvel;
  color col;
  static Game game;
  
  Entity(Game g)//gives every subclass a reference to the game object
  {
    game = g;
  }
  
  Entity()
  {
    
  }
  
  void setLocation(float x, float y)
  {
    xpos = x;
    ypos = y;
  }

  void setX(int x)
  {
    xpos = x;
  }

  void setY(int y)
  {
    ypos = y;
  }

  void setVelocity(float x, float y)
  {
    xvel = x;
    yvel = y;
  }

  void setXVel(float x)
  {
    xvel = x;
  }

  void setYVel(float y)
  {
    yvel = y;
  }

  void setColor(color c)
  {
    col = c;
  }

  color getColor()
  {
    return col;
  }

  float getX()
  {
    return xpos;
  }

  float getY()
  {
    return ypos;
  }

  float getYVel()
  {
    return yvel;
  }

  float getXVel()
  {
    return xvel;
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