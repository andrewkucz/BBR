class Menu extends Screen {


  ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
  String title = "";
  PFont font = loadFont("ArcadeNormal-48.vlw");
  int textsize = 24;

  Menu()
  {
    col = color(255);
  }


  void addButton(String s)
  {
    PFont f = loadFont("Axis-48.vlw");
    buttons.add(new MenuButton(s));

    for (int i=0; i<buttons.size(); i++) {
      float temp = ((0.666*h) * (i+1)/(buttons.size()+1) - 20) + (0.333*h);
      buttons.get(i).setY((int)temp);
    }
  }

  void update()
  {
    strokeWeight(1);
    noStroke();
    fill(col);
    rect(xpos, ypos, w, h);
    
    if(!title.equals(""))
    {
    textAlign(CENTER);
    textFont(font);
    textSize(textsize);
    fill(255);
    rectMode(CENTER);
    rect(xpos+(w/2), ypos+215, textWidth(title) + 20, 40);
    fill(0);
    text(title, xpos+(w/2), ypos+225);
    rectMode(CORNER);
    }

    for (MenuButton mb : buttons) {
      mb.update();
    }
  }
  
  
  void setBGColor(color c)
  {
    col = c; 
  }
  
  void setTitle(String s)
  {
    title = s;
  }
  
  
  
} // end class



class PauseMenu extends Menu 
{
  PImage currentscreen;
  boolean active = false;
  
  PauseMenu()
  {
    super();
  }
  
  
  @Override
  void update()
  {
    if(!active)
    {
      filter(BLUR, 3);
      active = true;
    }

    
    for (MenuButton mb : buttons) {
      mb.update();
    }
  }
  
}








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
