Game game;
boolean leftpressed, rightpressed;

void setup()
{
  size(1400,800);
  background(0);
  game = new Game();
}

void draw()
{
  game.update();
}





void keyPressed()
{
  if (key == CODED && (keyCode == RIGHT))
  {
    rightpressed = true;
  }
  if (key == CODED && (keyCode == LEFT))
  {
    leftpressed = true;
  }
}
void keyReleased()
{
  if (key == CODED && (keyCode == RIGHT))
  {
    rightpressed = false;
  }
  if (key == CODED && (keyCode == LEFT))
  {
    leftpressed = false;
  }
}
