class Menu {

  int mheight, mwidth;
  int xpos, ypos;
  
  // bg color
  color bgcolor = color(255);
  ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
  String title;
  

  

Menu()
{
  mheight = height-20;
  mwidth = 588;
  ypos = (height-mheight)/2;
  xpos = (width-mwidth)/2;
}

void addButton(String s)
{
  buttons.add(new MenuButton(s));
  
  for (int i=0; i<buttons.size(); i++) {
   float temp = ((0.666*mheight) * (i+1)/(buttons.size()+1) - 20) + (0.333*mheight);
    buttons.get(i).setY((int)temp);
  }
  
}



void update()
{
  strokeWeight(1);
  noStroke();
  fill(bgcolor);
  rect(xpos, ypos, mwidth, mheight); 
  
  for (MenuButton mb : buttons) {
     mb.update();
  }
  
}






} // end class
