import processing.sound.*;
Game game;

void setup()
{
  size(1280, 720);
  background(0);

  frameRate(60);
  game = new Game(this);
}

void draw()  //main draw function
{
  game.update();
}


void keyPressed()//next functions handle user input
{

  if (game.nameentry.isValid(key) && (game.getGameState() == 5 || game.getGameState() == 8 || game.getGameState() == 9))
  {
    game.nameentry.appendChar(key);
  } else if (key == BACKSPACE && (game.getGameState() == 5 || game.getGameState() == 8 || game.getGameState() == 9))
  {
    game.nameentry.removeChar();
  }

  if (key == CODED && keyCode == UP && game.paddle.getState()==3 && game.gamestate==1)
  {
    game.paddle.blaster.spawnBullet();
  }
  if (key == 'w' && game.paddle2.getState()==3 && game.gamestate==1)
  {
    game.paddle2.blaster.spawnBullet();
  }



  if (key == CODED)
  {
    if (keyCode == RIGHT)
    {
      if (!game.balls.isEmpty()) {
        if (game.balls.get(0).getState() != 1)
          game.paddle.rightpressed = true;
      }
    } else if (keyCode == LEFT)
    {
      if (!game.balls.isEmpty()) {
        if (game.balls.get(0).getState() != 1)
          game.paddle.leftpressed = true;
      }
    }
  }

  if (key == 'a') {
    if (!game.balls.isEmpty()) {
      if (game.balls.get(0).getState() != 1)
        game.paddle2.leftpressed = true;
    }
  } else if (key == 'd') {
    if (!game.balls.isEmpty()) {
      if (game.balls.get(0).getState() != 1)
        game.paddle2.rightpressed = true;
    }
  }
}




void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == RIGHT)
    {
      game.paddle.rightpressed = false;
    } else if (keyCode == LEFT)
    {
      game.paddle.leftpressed = false;
    }
  }
  if (key == 'a') {
    game.paddle2.leftpressed = false;
  } else if (key == 'd') {
    game.paddle2.rightpressed = false;
  }
}

void mousePressed()
{
  game.clicked = true;
}