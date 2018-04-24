Game game;

void setup()
{
  size(1280, 720);
  background(0);

  frameRate(60);
  game = new Game();
  
}

void draw()
{
  game.update();
}


void keyPressed()
{
  
  if(game.nameentry.isValid(key) && (game.getGameState() == 5 || game.getGameState() == 8 || game.getGameState() == 9))
  {
      game.nameentry.appendChar(key);
  }
  else if (key == BACKSPACE && (game.getGameState() == 5 || game.getGameState() == 8 || game.getGameState() == 9))
  {
      game.nameentry.removeChar();
  }
  
  if(key == ' ' && game.paddle.getState()==3 && game.gamestate==1)
  {
    game.paddle.blaster.spawnBullet();
  }
  

  
  
  if(key == CODED)
  {
    if(keyCode == RIGHT)
    {
      game.paddle.rightpressed = true;
    }
    else if(keyCode == LEFT)
    {
      game.paddle.leftpressed = true;
    }    
  }


  
  
}




void keyReleased()
{
    if(key == CODED)
  {
    if(keyCode == RIGHT)
    {
      game.paddle.rightpressed = false;
    }
    else if(keyCode == LEFT)
    {
      game.paddle.leftpressed = false;
    }
  }
  
}

void mousePressed()
{
  game.clicked = true;
}
