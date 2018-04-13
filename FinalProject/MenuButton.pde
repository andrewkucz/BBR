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
    btnColor = color(40);
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
      stroke(255);
      strokeWeight(3);
      rect(xpos-1, ypos-1, btnwidth+1, btnheight+1);
      fill(200,0,0);
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
    textFont(font);
    text(label, xpos+(btnwidth/2), ypos+(btnheight/2)+(btnheight*0.2)); 
  }
  
  void setY(int y)
  {
    ypos = y;
  }
  
  
}
