class MenuButton extends Menu {
  
  int w, h;
  int xpos, ypos;
  String label;
  color textColor = color(0);
  color btnColor = color(255);
  boolean hover;

  MenuButton(String l)
  {
    h = super.h/13;
    w = super.w/2;
    xpos = super.xpos + ((super.w - w)/2);
    label = l;
    hover = false;
  }
  
  
  void update()
  {
    if(mouseX >= xpos && mouseX <= xpos+w && mouseY >= ypos && mouseY <= ypos+h)
    {
      hover = true;      
    }
    else
    {
      hover = false;
    }
    
    if(hover)
    {
      fill(200,200,200);
      stroke(255);
    }
    else
    {
      fill(btnColor);
      stroke(0);
    }
    strokeWeight(2);
    rect(xpos, ypos, w, h);
    fill(textColor);
    textSize(h/2);
    textAlign(CENTER);
    textFont(font);
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
