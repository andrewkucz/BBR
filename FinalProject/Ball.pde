
class Ball extends Entity {

  Pointer arrow;

  // State definitions

  // 0 - inactive / invisible
  // 1 - visible, waiting to start (unmoving, attached to paddle)
  // 2 - in action - bouncing around, checking for collisions
  // 3 - dead (?)
  // 5 - fireball

  //speed should be capped at paddle height + ball width to avoid any scenario where ball will
  //pass through a brick or paddle.

  PVector velocity;
  float speed;
  float speedinc = 0.02;


  Ball()
  {
    super();
    state = 0;
    xvel = 0;
    yvel = 0;
    velocity = new PVector(0, 0);
    speed = 4.0;
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
    col = color(0);
    xvel = 0;
    yvel = 0;
    velocity = new PVector(0, 0);
    speed = 5;
  }  
  void setSpeed(float s){
    speed = s;
  }

  void update()
  { 
    if (state==1)
    {
      arrow.setLocation((int)xpos, (int)ypos);
      arrow.update();


      //wait for up pressed
      if (keyPressed /*&& key == CODED*/) {
        if (key == ' ') {
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



    //xpos += xvel;
    //ypos += yvel;
  }
  int checkCollisions(GameBoard board, Paddle[] paddles) {
    return checkCollisions(board, paddles, speed);
  }
  int checkCollisions(GameBoard board, Paddle[] paddles, float mult) {  //may have to optimize this in order to keep up with frames
    PVector newVel = new PVector(xvel, yvel);
    newVel.normalize();
    newVel.mult(mult);  //if this is a recursive call, we only want to move the ball a portion of its normal velocity
    float tempx = this.xpos + newVel.x;  //where we would move the ball if there weren't any collisions
    float tempy = this.ypos + newVel.y;
    float slope = newVel.y/newVel.x;

    int changed = 0;  //0 for no collisions, 1 to invert x, 2 to invert y;
    float newMult = 0; //maximize this to get closest collision point
    float x2 = tempx;
    float y2 = tempy;  //position of new spot for ball to be...
    PVector collisionVector;

    float x2temp, y2temp;
    float newMultTemp;
    //collison with board boundaries
    if (tempx > (board.w + board.xpos - w/2)) {//collision with Right side of board
      //move to point of collision
      x2temp = (board.w + board.xpos - w/2);
      y2temp = slope * (x2temp - xpos) + ypos;

      fill(200, 0, 0);


      collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

      newMultTemp = (newVel.mag() - collisionVector.mag());//only get the unused portion of the vector to recursively call the function
      if (newMultTemp > newMult) {
        //handle setting neccessary collision handlers here
        newMult = newMultTemp;
        x2 = x2temp;
        y2 = y2temp;
        changed = 1;
      }
    } else if (tempx < board.xpos + w/2) {

      x2temp = board.xpos + w/2;
      y2temp = slope * (x2temp - xpos) + ypos;

      fill(200, 0, 0);

      collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

      newMultTemp = (newVel.mag() - collisionVector.mag());
      if (newMultTemp > newMult) {
        //handle setting neccessary collision handlers here
        newMult = newMultTemp;
        x2 = x2temp;
        y2 = y2temp;
        changed = 1;
      }
    } else if (tempy < board.ypos + w/2) {

      y2temp = board.ypos + w/2;
      x2temp = (y2temp-ypos)/slope + xpos;

      fill(200, 0, 0);


      collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

      newMultTemp = (newVel.mag() - collisionVector.mag());
      if (newMultTemp > newMult) {
        //handle setting neccessary collision handlers here
        newMult = newMultTemp;
        x2 = x2temp;
        y2 = y2temp;
        changed = 2;
      }
    } else if (ypos > board.ypos + board.h - w/2) {
      state = 3;
      return 0; //remove ball from array
    }
    Paddle paddle;
    float closestPointx;
    float closestPointy;
    for (int i = 0; i < paddles.length; i++) {
      if (game.gamemode == 1 && i == 1) break;  //ignore second paddle in single player
      paddle = paddles[i];
      //point where collision would happen on rectangle
      closestPointx = max(paddle.xpos, min(tempx, (paddle.xpos + paddle.w)));
      closestPointy = max(paddle.ypos, min(tempy, (paddle.ypos + paddle.h)));
      //vector from point of collision to center of ball
      collisionVector = new PVector(xpos - closestPointx, ypos - closestPointy);

      if (((tempx- closestPointx) * (tempx - closestPointx) + (tempy - closestPointy) * (tempy - closestPointy)) < (w/2 * w/2)) {  //Collision!
        if (state == 5) {
          state = 2;
          setColor(color(0));
        }

        //move to collision point

        if (closestPointx == paddle.xpos) {  //left side
          x2temp = (closestPointx - w/2);
          y2temp = slope * (x2temp - xpos) + ypos;

          collisionVector = new PVector(x2temp - xpos, y2temp-ypos);
          newMultTemp = (newVel.mag() - collisionVector.mag());

          if (newMultTemp > newMult) {
            //handle setting neccessary collision handlers here
            newMult = newMultTemp;
            x2 = x2temp;
            y2 = y2temp;
            changed = 1;
          }
        }
        if (closestPointx == paddle.xpos + paddle.w) {  //right side
          x2temp = (closestPointx + w/2);
          y2temp = slope * (x2temp - xpos) + ypos;

          fill(0, 200, 0);


          collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

          newMultTemp = (newVel.mag() - collisionVector.mag());
          if (newMultTemp > newMult) {
            //handle setting neccessary collision handlers here
            newMult = newMultTemp;
            x2 = x2temp;
            y2 = y2temp;
            changed = 1;
          }
        }
        if (closestPointy == paddle.ypos) {  //top


          y2temp = closestPointy - w/2;
          x2temp = (y2temp -ypos) /slope + xpos;

          collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

          newMultTemp = (newVel.mag() - collisionVector.mag());
          if (newMultTemp > newMult) {
            //handle setting neccessary collision handlers here
            newMult = newMultTemp;
            x2 = x2temp;
            y2 = y2temp;
            changed = 2;
          }
        }
        if (closestPointy == paddle.ypos + paddle.h) {  //bottom
          y2temp = closestPointy + w/2;
          x2temp = (y2temp -ypos) /slope + xpos;

          collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

          newMultTemp = (newVel.mag() - collisionVector.mag());
          if (newMultTemp > newMult) {
            //handle setting neccessary collision handlers here
            newMult = newMultTemp;
            x2 = x2temp;
            y2 = y2temp;
            changed = 2;
          }
        }

        //adjust velocity
      }
    }

    Brick temp;
    //handle brick collisions
    for (int i = 0; i < board.rows; i++) {
      for (int j = 0; j < board.cols; j ++) {
        temp = board.board[i][j];
        //point where collision would happen on rectangle
        closestPointx = max(temp.xpos, min(tempx, (temp.xpos + temp.w)));
        closestPointy = max(temp.ypos, min(tempy, (temp.ypos + temp.h)));
        //vector from point of collision to center of ball
        collisionVector = new PVector(xpos - closestPointx, ypos - closestPointy);

        if (((tempx- closestPointx) * (tempx - closestPointx) + (tempy - closestPointy) * (tempy - closestPointy)) < (w/2 * w/2) && temp.getState() != 0) {  //Collision!

          speed += speedinc;
          int returnVal = 0;
          if (state == 5) {
            temp.setState(1); 
            returnVal = temp.hit();
            if (returnVal == -1)
              return -1;  //pass up return value from Hit
          } else {
            returnVal = temp.hit();
              if (returnVal == -1)
              return -1;  //pass up return value from Hit
            if (closestPointx == temp.xpos) {  //left side
              x2temp = (closestPointx - w/2);
              y2temp = slope * (x2temp - xpos) + ypos;

              collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

              newMultTemp = (newVel.mag() - collisionVector.mag());
              if (newMultTemp > newMult) {
                //handle setting neccessary collision handlers here
                newMult = newMultTemp;
                x2 = x2temp;
                y2 = y2temp;
                changed = 1;
              }
            }
            if (closestPointx == temp.xpos + temp.w) {  //right side
              x2temp = (closestPointx + w/2);
              y2temp = slope * (x2temp - xpos) + ypos;


              collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

              newMultTemp = (newVel.mag() - collisionVector.mag());
              if (newMultTemp > newMult) {
                //handle setting neccessary collision handlers here
                newMult = newMultTemp;
                x2 = x2temp;
                y2 = y2temp;
                changed = 1;
              }
            }
            if (closestPointy == temp.ypos) {  //top

              y2temp = closestPointy - w/2;
              x2temp = (y2temp -ypos) /slope + xpos;

              collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

              newMultTemp = (newVel.mag() - collisionVector.mag());
              if (newMultTemp > newMult) {
                //handle setting neccessary collision handlers here
                newMult = newMultTemp;
                x2 = x2temp;
                y2 = y2temp;
                changed = 2;
              }
            }
            if (closestPointy == temp.ypos + temp.h) {  //bottom
              y2temp = closestPointy + w/2;
              x2temp = (y2temp - ypos) /slope + xpos;

              collisionVector = new PVector(x2temp - xpos, y2temp-ypos);

              newMultTemp = (newVel.mag() - collisionVector.mag());
              if (newMultTemp > newMult) {
                //handle setting neccessary collision handlers here
                newMult = newMultTemp;
                x2 = x2temp;
                y2 = y2temp;
                changed = 2;
              }
            }
          }
        }
      }
    }


    xpos = x2;
    ypos = y2;
    if (newMult != 0) {  //no collision woohoo
      if (changed == 1) {
        xvel *= -1;
      } else if (changed == 2) {
        yvel *= -1;
      }
      checkCollisions(board, paddles, newMult);
    }

    return 1; //if all collisions are normal
  }
}