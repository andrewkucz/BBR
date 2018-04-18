
class Ball extends Entity {

  Pointer arrow;

  // State definitions

  // 0 - inactive / invisible
  // 1 - visible, waiting to start (unmoving, attached to paddle)
  // 2 - in action - bouncing around, checking for collisions
  // 3 - dead (?)

  PVector velocity;
  float speed;


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
    w = 20;
    h = 20;
    col = color(255, 0, 0);
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


    fill(col);

    noStroke();
    ellipse(xpos, ypos, w, h);
    xpos += xvel;
    ypos += yvel;
  }

  void checkCollisions(GameBoard board, Paddle paddle)
  {
  }
  void setState(int s)
  {
    state = s;
  }

  int getState()
  {
    return state;
  }
}
