Game game;
boolean leftpressed, rightpressed;
PFont font;



void setup()
{
  size(1400,800);
  background(0);
  font = loadFont("Axis-32.vlw");
  
  game = new Game();
  game.highscores.insertScore("Stephanie", 2);
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
