class Title extends Menu
{
  
  // animation handling
  PImage[] frames = new PImage[6];
  int counter = 0;
  int threshold = 6;
  int index = 0;
  PImage titlecard;
  PFont font;
  
  Title()
  {
    font = loadFont("Axis-32.vlw");
    for(int i=0; i<6; i++)
    {
    frames[i] = loadImage("frame" + (i+1) + ".png");
    }
    titlecard = loadImage("BBR2.png");
  }
  
 void update()
{  
  
  imageMode(CENTER);
  
  if(counter == threshold)
  {
    image(frames[index],xpos+(w/2),ypos+(h/2));
    image(titlecard, xpos+(w/2),ypos+(h/4));
  
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
  
  
  
  
  
  
  
  
  
  
}
