class MenuButton extends Entity {

  color textColor = color(0);
  boolean hover;  
  String label;
  PFont font = loadFont("ArcadeNormal-48.vlw");
  int textsize = 24;
  

  MenuButton(String l)
  {
    col = color(255);
    h = (height-20)/13;
    w = 588/2;
    xpos = ((width-588)/2) + (((588/2) - w)/2) + (w/2);
    label = l;
    hover = false;
  }
 


  void update()
  {
    if (mouseX >= xpos && mouseX <= xpos+w && mouseY >= ypos && mouseY <= ypos+h)
    {
      hover = true;
    } else
    {
      hover = false;
    }

    if (hover)
    {
      fill(200, 200, 200);
      stroke(255);
    } else
    {
      fill(col);
      stroke(0);
    }
    strokeWeight(2);
    rect(xpos, ypos, w, h);
    fill(textColor);
    textAlign(CENTER);
    textFont(font);
    textSize(textsize);
    text(label, xpos+(w/2), ypos+(h/2)+(h*0.2));
  }

  void setY(int y)
  {
    ypos = y;
  }

  boolean isHovered()
  {
    return hover;
  }
}
