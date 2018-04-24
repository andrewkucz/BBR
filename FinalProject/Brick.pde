class Brick extends Entity {

  Powerup power;

  int level; // needed (?)

  // State defitions
  // 0 - invisible / not present
  // 1-3 - n hits remaining to destroy brick


  Brick()
  {
    super();
    state=0;
  }

  Brick(int x, int y, int s, int l, Powerup p)
  {
    super();
    xpos = x;
    ypos = y;
    state = s;
    level = l;
    power = p;

    if (l == 1)
    {
      col = color(0, 0, map(state, 3, 1, 30, 255));
    } else
    {
      col = color(255, 0, 0);
    }

    // other level color schemes here
  }

  void update()
  {

    if(state>0)
    {
      fill(col);
      noStroke();
      rect(xpos, ypos, w, h);
    }  
    //power.update();
  }


  void hit()
  {
    if(game.score>99999)
    {
      game.score = 99999;
    }
    else
    {
      game.score += 10;
    }
    
    if (state>0){
    if(state==1)
    {
      power.setYVel(3);
    } 
      state--;
      col = color(0, 0, map(state, 3, 1, 30, 255));
    }
  }
  int getState() {
    return state;
  }
}
