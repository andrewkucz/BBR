class Powerup extends Entity {

  int[] weighting = {0, 0, 0, 4, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 
    0, 0, 0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 1, 2, 
    0, 2, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4, 0, 4, 5, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 5, 5, 0, 0, 0, 0, 0, 
    5, 0, 4, 3, 5, 0, 0, 0, 0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    4, 5, 4, 3, 5, 0, 0, 0, 0, 1, 2, 0, 4, 5, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  color[] colors = {color(255), color(0, 200, 0), color(0, 200, 200), color(255, 165, 0), color(200, 0, 0)};
  //int[] weighting = {0, 0, 0, 3, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 3, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3, 0, 
  //    0, 0, 0, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 3, 3, 
  //    0, 3, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 3, 0, 3, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
  //    0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 0, 0, 0, 0, 0, 
  //    3, 0, 3, 3, 3, 0, 0, 0, 0, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
  //    3, 3, 3, 3, 3, 0, 0, 0, 0, 3, 3, 0, 3, 3, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
  //    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};



  // Powerup types (state definitions)
  // 0 - Nothing/null
  // 1 - Longer paddle
  // 2 - Faster paddle
  // 3 - Galaga mode
  // 4 - Multi-ball
  // 5 - Fireball 

  color outline = color(0);


  Powerup(int x, int y)
  {
    super();
    w = 14;
    h = 14;
    xpos = x;
    ypos = y;
    yvel = 0;


    state = weighting[(int)random(weighting.length)];
    if (state != 0)
      col = colors[state-1];
    else col = color(255);
  }
  Powerup(int x, int y, int state) {
    super();
    w = 14;
    h = 14;
    xpos = x;
    ypos = y;
    yvel = 0;
    col = colors[state-1];

    this.state = state;
  }


  void update()
  {
    strokeWeight(3);
    stroke(outline);
    fill(col);
    ellipse(xpos, ypos, w, h);
    ypos += yvel;
  }
  void drawPowerUp() {
    strokeWeight(3);
    stroke(outline);
    fill(col);
    ellipse(xpos, ypos, w, h);
  }

  void checkCollisions(GameBoard b, Paddle p)
  {
    if (ypos > p.ypos && xpos > p.xpos && xpos < p.xpos+p.w)
    {
      if (state == 1|| state == 2 || state == 3) {
        if (p.getState() == state)
        {
          p.counter = 0;
        } else
        {
          p.setState(state);
        }
      } else if ( state == 4) {  // multi Ball
      ArrayList<Ball> newBalls = new ArrayList();
        for (Ball ball : game.balls) {//create new Balls
          ball.setVelocity(0, -ball.speed);
          PVector newVel = new PVector(0, -ball.speed);
          newVel.rotate(-PI/2);
          for (int i = 0; i <= 4; i++) {
            newVel.rotate(PI/6);
            if (i != 2) {
              Ball temp = new Ball(2);
              temp.setSpeed(ball.speed);
              temp.setLocation(ball.xpos, ball.ypos);
              temp.setVelocity(newVel.x, newVel.y);
              newBalls.add(temp);
            }
          }
        }
        //add new balls to the game Balls Array
        for (Ball ball : newBalls){
          game.balls.add(ball);
        }
      } 
      else if (state == 5) {  //fire Ball
        for (Ball ball : game.balls) {  //check for paddle collisions in ball function
          if (ball.getState() == 2) {
            ball.setColor(color(200, 0, 0));
            ball.setState(5) ;
          }
        }
      }
      state = 0;
    } else if (ypos+h/2 > b.h)
    {
      state = 0;
    }
  }
}