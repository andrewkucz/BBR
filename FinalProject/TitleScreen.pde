class TitleScreen extends Menu
{
  
  PImage[] bgframes = new PImage[6];
  
  int counter = 0;
  int threshold = 6;
  int index = 0;
  PImage titlecard;
  
  
  
  TitleScreen()
  {
    super();
    
    for(int i=0; i<6; i++)
    {
    bgframes[i] = loadImage("frame" + (i+1) + ".png");
    }
  
    titlecard = loadImage("BBR2.png");
    
  }
  
 void update()
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
  
  
  
  
  
  
  
  
  
  
}
