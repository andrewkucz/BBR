abstract class Screen
{

  int w = 588;
  int h = height-20;
  int ypos = (height-h)/2;
  int xpos = (width-w)/2;

  color col;

  abstract void update();

  void setBGColor(color c)
  {
    col = c;
  }
  color getBGColor()
  {
    return col;
  }
  
}
