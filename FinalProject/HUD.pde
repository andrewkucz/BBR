class HUD {
 
  int xpos, ypos;
  int h, w;
  int textsize = 20;
  PFont font = loadFont("ArcadeNormal-48.vlw");
  String name;
  int score = 0;
  int numlives;
  Powerup[] powerups;
  
  HUD(int x, int y, String s, int l)
  {
    xpos = x;
    ypos = y;
    h = height;
    w = (width-588)/2;
    name = s;
    numlives = l;
    powerups = new Powerup[5];
    for (int i = 0; i < powerups.length; i++){
     powerups[i] = new Powerup(xpos + 40,340 + i * 50,i+1); 
    }
  }

  void update(int s, int l, int ps, int ps1)
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
    for (int i = 0; i < game.paddles.length; i ++){
      if(game.gamemode == 1 && i ==1) break;
      if(i == 1) ps = ps1;  //hacky but it'll work
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
    
    text("PADDLE" + ((game.gamemode == 1) ? "" : " " + (i + 1)) + ": " + power, xpos+30, 250 + i*50);
    }
    for (int i = 0; i < powerups.length; i ++ ){
      powerups[i].drawPowerUp();
    }
    fill(255);
    text(": LONG", xpos+80, 350);
    text(": FAST", xpos+80, 400);
    text(": SHOOT", xpos+80, 450);
    text(": MULTI", xpos+80, 500);
    text(": FIRE", xpos+80, 550);
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