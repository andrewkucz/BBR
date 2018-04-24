class HUD {
 
  int xpos, ypos;
  int h, w;
  int textsize = 20;
  PFont font = loadFont("ArcadeNormal-48.vlw");
  String name;
  int score = 0;
  int numlives;
  
  HUD(int x, int y, String s, int l)
  {
    xpos = x;
    ypos = y;
    h = height;
    w = (width-588)/2;
    name = s;
    numlives = l;
  }

  void update(int s, int l, int ps)
  {
    fill(0);
    noStroke();
    rect(xpos,ypos,w, h);
    fill(255);
    textFont(font);
    textSize(textsize);
    textAlign(LEFT);
    text("PLAYER: " + name, xpos+30, 100);
    score = s;
    text("SCORE: " + scoreToString(), xpos+30, 150);
    numlives = l;
    text("LIVES:   " + l, xpos+30, 200);
    
    
    String power = "";
    
    if(ps == 1)
    {
      power = "LONG";
    }
    else if(ps == 2)
    {
      power = "FAST";
    }
    else if(ps == 3)
    {
      power = "SHOOT";
    }
    else
    {
      power = "None";
    }
    
    text("PADDLE: " + power, xpos+30, 250);
  }
  
  
  String scoreToString()
  {
    String s = "";
    
    for (int i=0; i<5-Integer.toString(score).length(); i++)
    {
      s+="0";
    }
    s += score;
    
    return s;
  }
  
  
  
}
