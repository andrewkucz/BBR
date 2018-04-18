Game game;

void setup()
{
  size(1400, 800);
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
  
  if(game.nameentry.isValid(key) && game.getGameState() == 5)
  {
      game.nameentry.appendChar(key);
  }
  else if (key == BACKSPACE && game.getGameState() == 5)
  {
      game.nameentry.removeChar();
  }
  
}




void keyReleased()
{
  
}

void mousePressed()
{
  game.clicked = true;
}