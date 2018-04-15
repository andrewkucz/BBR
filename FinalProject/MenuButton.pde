class MenuButton extends Menu {
  
  int btnheight, btnwidth;
  int xpos, ypos;
  String label;
  color textColor;
  color btnColor;
  
  boolean hover;

  
  MenuButton(String l)
  {
    btnheight = super.mheight/13;
    btnwidth = super.mwidth/2;
    label = l;
    textColor = color(0);
    btnColor = color(255);
    xpos = super.xpos + ((super.mwidth - btnwidth)/2);
    hover = false;
  }
  
  
  void update()
  {
    if(mouseX >= xpos && mouseX <= xpos+btnwidth && mouseY >= ypos && mouseY <= ypos+btnheight)
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
    rect(xpos, ypos, btnwidth, btnheight);
    fill(textColor);
    textSize(btnheight/2);
    textAlign(CENTER);
    textFont(font);
    text(label, xpos+(btnwidth/2), ypos+(btnheight/2)+(btnheight*0.2)); 
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
