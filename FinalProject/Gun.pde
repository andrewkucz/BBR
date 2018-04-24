class Gun extends Entity {

  ArrayList<Bullet> bullets;

  //State
  //0 inacticce
  //1 active

  Gun()
  {
    bullets = new ArrayList<Bullet>();
    w = 20;
    h = 20;
    state = 0;
  }



  void update()
  {
    fill(0);
    noStroke();
    triangle(xpos, ypos, xpos+(w/2), ypos-h, xpos+w, ypos);

    if (state == 0)
    {
      bullets.clear();
    }
    
    else
    {

      for (int i=0; i<bullets.size(); i++)
      {
        if (bullets.get(i).getState() == 0)
        {
          bullets.remove(i);
        } else
        {
          bullets.get(i).update();
        }
      }
    }
  }

  void checkCollisions(GameBoard b)
  {
    for (Bullet bul : bullets)
    {
      if (b.getBrick((int)bul.xpos, (int)bul.ypos).getState() > 0)
      {
        bul.setState(0);
        b.getBrick((int)bul.xpos, (int)bul.ypos).hit();
      } else if (bul.ypos < 0)
      {
        bul.setState(0);
      }
    }
  }

  void spawnBullet()
  {
    bullets.add(new Bullet((int)xpos+(w/2), (int)ypos-h));
  }
}