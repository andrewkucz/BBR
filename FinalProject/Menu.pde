class Menu extends Screen {


  ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
  String title;


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

    for (MenuButton mb : buttons) {
      mb.update();
    }
  }
} // end class
