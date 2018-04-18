class Ball {
  float xpos, ypos;
  float xvel, yvel;
  PVector velocity;
  int size = 20;
  color ballcol = color(255, 0, 0);
  Pointer arrow;
  float speed;

  int state;
  // 0 - inactive / invisible
  // 1 - visible, waiting to start
  // 2 - in action
  // 3 - dead

  Ball()
  {
    state = 0;
    xvel = 0;
    yvel = 0;
    velocity = new PVector(0, 0);
    speed = 2.0;
  }

  Ball(int s) 
  {
    state = s;
    if (s == 1)
    {
      arrow = new Pointer();
    }
    xvel = 0;
    yvel = 0;
    velocity = new PVector(0, 0);
    speed = 2.0;
  }  



  void update()
  { 

    if (state==1)
    {
      arrow.setLocation((int)xpos, (int)ypos);
      arrow.update();


      //wait for up pressed
      if (keyPressed && key == CODED) {
        if (keyCode == UP) {
          state = 2;
          PVector vel = arrow.getStartVel();
          vel = vel.mult(speed);
          xvel = vel.x;
          yvel = vel.y;
        }
      }
    }

    fill(ballcol);
    noStroke();
    ellipse(xpos, ypos, size, size);
    xpos += xvel;
    ypos += yvel;
  }
  void checkCollisions(GameBoard board, Paddle paddle){
    
  }

  // Getters and setters

  void setColor(color c)
  {
    ballcol = c;
  }

  color getColor()
  {
    return ballcol;
  }

  void setLocation(int x, int y)
  {
    xpos = x;
    ypos = y;
  }

  float getX()
  {
    return xpos;
  }
  float getY()
  {
    return ypos;
  }
  int getState()
  {
    return state;
  }
}