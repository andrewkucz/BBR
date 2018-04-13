class Menu {

  int mheight, mwidth;
  int xpos, ypos;
  
  // bg color
  color bgcolor = color(200);
  
  boolean open;
  

Menu() 
{
  mheight = height-20;
  mwidth = 588;
  ypos = (height-bheight)/2;
  xpos = (width-bwidth)/2;
}


void update()
{
  strokeWeight(1);
  noStroke();
  fill(bgcolor);
  rect(xpos, ypos, mwidth, mheight);
}






}
