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
    textColor = color(255);
    btnColor = color(180);
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
      noFill();
      stroke(255,0,0);
      strokeWeight(1);
      rect(xpos, ypos, btnwidth, btnheight);
      fill(0);
    }
    else
    {
      fill(btnColor);
    }
    noStroke();
    rect(xpos, ypos, btnwidth, btnheight);
    fill(textColor);
    textSize(btnheight/2);
    textAlign(CENTER);
    text(label, xpos+(btnwidth/2), ypos+(btnheight/2)+(btnheight*0.2)); 
  }
  
  void setY(int y)
  {
    ypos = y;
  }
  
  
}
