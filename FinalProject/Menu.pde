class Menu {

  int mheight, mwidth;
  int xpos, ypos;
  
  // bg color
  color bgcolor = color(255);
  ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
  String windowtitle;
  
  int counter = 0;
  int threshold = 6;
  int index = 0;
  
  PImage[] bgframes = new PImage[6];
  PImage titlecard;
  

Menu()
{
  mheight = height-20;
  mwidth = 588;
  ypos = (height-mheight)/2;
  xpos = (width-mwidth)/2;
  
  for(int i=0; i<6; i++)
  {
    bgframes[i] = loadImage("frame" + (i+1) + ".png");
  }
  
  titlecard = loadImage("BBR2.png");
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

void updateAnimated()
{  
  
  imageMode(CENTER);
  
  if(counter == threshold)
  {
    image(bgframes[index],xpos+(mwidth/2),ypos+(mheight/2));
    image(titlecard, xpos+(mwidth/2),ypos+(mheight/4));
  
  for (MenuButton mb : buttons) {
     mb.update();
  }

  
  counter = 0;
  index++;
  if(index == 6)
    index=0;
  }
  counter++;


}




} // end class
