class NameEntry extends Screen { //<>//

  char[] validchars = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
  char[] name = new char[3];
  int cursor;
  boolean blink = true;
  int counter = 0;
  int threshold = 24;
  
  PFont font;
  int textsize;
  
  MenuButton ok, back;

  NameEntry()
  {
    font = loadFont("ArcadeNormal-48.vlw");
    col = color(255);
    textsize = 36;
    cursor = -1;
    name[0] = ' ';
    name[1] = ' ';
    name[2] = ' ';
    
    ok = new MenuButton("OK");
    back = new MenuButton("BACK");
    ok.setY(13*h/20);
    back.setY(8*h/10);
  }

  void update()
  {
    noStroke();
    fill(col);
    rect(xpos, ypos, w, h);

    noFill();
    strokeWeight(2);
    stroke(0);
    rectMode(CENTER);
    rect(xpos+(w/2), ypos+(h/2)-16, 150, 50);

    rectMode(CORNER);



    textAlign(CENTER);
    textFont(font);
    textSize(textsize);
    fill(0);
    text("ENTER INITIALS", xpos+(w/2), ypos+(h/3));

    for (int i=0; i<3; i++)
    {
      text(name[i], xpos+(w/2)-35+(35*i), ypos+(h/2));
    }

    strokeWeight(3);
    stroke(0);


    if (blink)
    {
      stroke(255);
    } else
    {
      stroke(0);
    }

    line(xpos+(w/2)-52+(35*(cursor+1)), ypos+(h/2)-2, xpos+(w/2)-52+(35*(cursor+1)), ypos+(h/2)-31);

    if (counter == threshold)
    {
      blink = !blink;
      counter = 0;
    }
    counter++;
    
    ok.update();
    back.update();
  }

  void appendChar(char c)
  {
    if (cursor >= 2)
    {
      return;
    }

    if (cursor <= 1)
    {
      name[cursor+1] = c;
    }

    if (cursor <= 2)
    {
      cursor++;
    }
  }

  // removes char wherever cursor is (backspace)
  void removeChar()
  {
    if (cursor == -1)
      return;

    name[cursor] = ' ';

    if (cursor >= -1)
    {
      cursor--;
    }
  }

  boolean isValid(char c)
  {
    for (int i=0; i<validchars.length; i++)
    {
      if (c == validchars[i])
      {
        return true;
      }
    }
    return false;
  }


}
