abstract class Entity {

  int xpos, ypos;
  int w, h;
  int state;
  float xvel, yvel;
  color col;

  void setLocation(int x, int y)
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

  int getX()
  {
    return xpos;
  }

  int getY()
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

  // each draw method is unique
  abstract void update();
}
