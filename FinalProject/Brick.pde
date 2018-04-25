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
    
    if (l==-1)
    {
      col = color(0, 0, map(state, 3, 1, 30, 255));
    }
    if (l==1)
    {
      col = color(0, 0, map(state, 3, 1, 30, 255));
    } else if(l==2)
    {
      col = color(map(state, 4, 1, 50, 255), 0, 0);
    } else if(l==3)
    {
      col = color(0, map(state, 5, 1, 25, 255), 0);
    }

  }

  void update()
  {

    if (state>0)
    {
      fill(col);
      noStroke();
      rect(xpos, ypos, w, h);
    }  
    //power.update();
  }


  int hit()
  {
    if (game.score>99999)
    {
      game.score = 99999;
    } else
    {
      game.score += 10;
    }

    if (state>0) {
      if (state==1)
      {
        power.setYVel(3);
      } 
      state--;
      updateColor(level);
    }
    if (state == 0){      ///check whether or not the game board is empty after a brick hit to prevent extra checks
      
      if(game.board.isEmpty())
      {
        return -1;
      }
      
    
    }
    return 0;
  }
  int getState() {
    return state;
  }
  
  
  void updateColor(int l)
  {
    if (l==-1)
    {
      col = color(0, 0, map(state, 3, 1, 30, 255));
    } 
    if (l==1)
    {
      col = color(0, 0, map(state, 3, 1, 30, 255));
    } else if(l==2)
    {
      col = color(map(state, 3, 1, 30, 255), 0, 0);
    } else if(l==3)
    {
      col = color(0, map(state, 3, 1, 30, 255), 0);
    }
  }
  
}