class MenuButton extends Menu {
  
  int btnheight, btnwidth;
  int xpos, ypos;
  String label;
  color textColor;
  color btnColor;
  
  boolean hover;

  
  MenuButton(String l)
  {
    btnheight = 50;
    btnwidth = super.mwidth/2;
    label = l;
    textColor = color(255);
    btnColor = color(180);
  }
  
  
  MenuButton(int x, int y, int bw, int bh, String l, color t, color b)
  {
    btnheight = bh;
    btnwidth = bw;
    xpos = x;
    ypos = y;
    label = l;
    textColor = t;
    btnColor = b;
  }
  
  void update()
  {
    fill(btnColor);
    rect(xpos, ypos, btnwidth, btnheight);
  }
  
}
