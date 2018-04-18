class Brick extends Entity {

  Powerup power;

  int level; // needed (?)

  // State defitions
  // 0 - invisible / not present
  // 1-3 - n hits remaining to destroy brick


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

    if (l == 1)
    {
      col = color(0, 0, map(s, 1, 3, 30, 255));
    } else
    {
      col = color(255, 0, 0);
    }

    // other level color schemes here
  }

  void update()
  {
    rect(xpos, ypos, w, h);
    power.update();
  }


  void hit()
  {
    if (state>0)
      state--;
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
