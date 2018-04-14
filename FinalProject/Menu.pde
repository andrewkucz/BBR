class Menu {

  int mheight, mwidth;
  int xpos, ypos;
  
  // bg color
  color bgcolor = color(255);
  ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
  String title;
  
  int counter = 0;
  int threshold = 6;
  
  color[] rainbow = {color(255,0,0), color(255,140,0), color(250,250,0),
                     color(0,255,0), color(0,0,255), color(153,50,200)};
  PImage titlecard;
  

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

void updateAnimated()
{  
  titlecard = loadImage("BB2.png");
  imageMode(CENTER);
  
  int sqsize = mwidth/28;

                     
  if(counter == threshold)
  {
  color temp;
  temp = rainbow[0];
  for(int i=0; i<rainbow.length-1; i++)
  {
    rainbow[i] = rainbow[i+1];
  }
  rainbow[rainbow.length-1] = temp;
  noStroke();
  for(int i=1; i<(mwidth/sqsize)+1 ; i++) // cols
  {
    for(int j=1; j<(mheight/sqsize)+2; j++) // rows
    {
      
      fill( rainbow[(j+(i-1))%6] );     
      rect(xpos + (i-1)*sqsize, ypos + (j-1)*sqsize, sqsize, sqsize);
    } 
  }
  counter = 0;
  fill(0);
  rect(xpos, ypos+mheight, mwidth, 10);
  image(titlecard, xpos+mwidth/2, ypos+mheight/4);
  }
  counter++;                  

  for (MenuButton mb : buttons) {
     mb.update();
  }

}



}
