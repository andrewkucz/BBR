
class Ball extends Entity {

  Pointer arrow;

  // State definitions

  // 0 - inactive / invisible
  // 1 - visible, waiting to start (unmoving, attached to paddle)
  // 2 - in action - bouncing around, checking for collisions
  // 3 - dead (?)

  //speed should be capped at paddle height + ball width to avoid any scenario where ball will
  //pass through a brick or paddle.

  PVector velocity;
  float speed;


  Ball()
  {
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
    speed = 15;
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



    //xpos += xvel;
    //ypos += yvel;
  }
  int checkCollisions(GameBoard board, Paddle paddle) {
    return checkCollisions(board, paddle, speed);
  }
  int checkCollisions(GameBoard board, Paddle paddle, float mult) {  //may have to optimize this in order to keep up with frames
    PVector newVel = new PVector(xvel, yvel);
    ////println(newVel.x + " " + newVel.y);
    newVel.normalize();
    newVel.mult(mult);  //if this is a recursive call, we only want to move the ball a portion of its normal velocity
    float tempx = this.xpos + newVel.x;  //where we would move the ball if there weren't any collisions
    float tempy = this.ypos + newVel.y;

    float slope = newVel.y/newVel.x;
    int changed = 0;  //0 for no collisions, 1 to invert x, 2 to invert y;
    float newMult = 0; //maximize this to get closest collision point
    float x2, y2;
    PVector collisionVector;

    //collison with board boundaries
    if (tempx > (board.w + board.xpos - w/2)) {//collision with Right side of boar
      //move to point of collision
      x2 = (board.w + board.xpos - w/2);
      y2 = slope * (x2 - xpos) + ypos;
      //debugging 
      fill(200, 0, 0);
      ellipse(x2, y2, 20, 20);

      //println(x2 +" " +y2);
      //println(xpos + " " + ypos);

      collisionVector = new PVector(x2 - xpos, y2-ypos);
      ////println("New Vector: " + collisionVector.x + " " + collisionVector.y);
      this.xpos = x2;
      this.ypos = y2;
      newMult = (newVel.mag() - collisionVector.mag());//only get the unused portion of the vector to recursively call the function

      ////println("newMult: "+ newMult);
      //adjust velocity
      this.xvel *= -1;
      //get length of next vector and call check Collisions again
      checkCollisions(board, paddle, newMult);
      return 1;  //not sure
    } else if (tempx < board.xpos + w/2) {

      x2 = board.xpos + w/2;
      y2 = slope * (x2 - xpos) + ypos;

      fill(200, 0, 0);
      ellipse(x2, y2, 20, 20);

      collisionVector = new PVector(x2 - xpos, y2-ypos);
      this.xpos = x2;
      this.ypos = y2;
      newMult = (newVel.mag() - collisionVector.mag());
      this.xvel *= -1;

      checkCollisions(board, paddle, newMult);
      return 1;
    } else if (tempy < board.ypos + w/2) {

      y2 = board.ypos + w/2;
      x2 = (y2-ypos)/slope + xpos;

      fill(200, 0, 0);
      ellipse(x2, y2, 20, 20);

      collisionVector = new PVector(x2 - xpos, y2-ypos);
      this.xpos = x2;
      this.ypos = y2;
      newMult = (newVel.mag() - collisionVector.mag());
      this.yvel *= -1;

      checkCollisions(board, paddle, newMult);
      return 1;
    } else if (ypos > board.ypos + board.h - w/2) {
      yvel = -abs(yvel);
      //return 0; //remove ball from array
    }


    //float vertDist = abs(tempy - (paddle.ypos + paddle.w/2));
    //float horDist = abs(tempx - ( paddle.xpos + paddle.w/2));

    //point where collision would happen on rectangle
    float closestPointx = max(paddle.xpos, min(tempx, (paddle.xpos + paddle.w)));
    float closestPointy = max(paddle.ypos, min(tempy, (paddle.ypos + paddle.h)));
    //vector from point of collision to center of ball
    collisionVector = new PVector(xpos - closestPointx, ypos - closestPointy);
    //float preserveMag = collisionVector.mag();
    //collisionVector.normalize();
    //println(collisionVector.mag());
    //fill(0, 200, 0);
    //ellipse(closestPointx, closestPointy, 5, 5);
    //println("--------------------------");
    //println("Previous point: " + "(" + tempx + ", " + tempy + ")");
    //println("temp - closest point: " + "(" + (tempx- closestPointx) + ", " + (tempy - closestPointy) + ")");
    //println("Collision Factor: " + ((tempx- closestPointx) * (tempx - closestPointx) + (tempy - closestPointy) * (tempy - closestPointy)));
    //println("must be less than " + (w/2 * w/2));
    //println("--------------------------");
    if (((tempx- closestPointx) * (tempx - closestPointx) + (tempy - closestPointy) * (tempy - closestPointy)) < (w/2 * w/2)) {  //Collision!
      println("Collision With Paddle! ");
      //move to collision point

      if (closestPointx == paddle.xpos) {  //left side
        x2 = (closestPointx - w/2);
        y2 = slope * (x2 - xpos) + ypos;
        //println("Previous point: " + "(" + xpos + ", " + ypos + ")");
        //println("New point: " + "(" + x2 + ", " + y2 + ")");
        //fill(0, 200, 0);
        //ellipse(x2, y2, 20, 20);

        collisionVector = new PVector(x2 - xpos, y2-ypos);
        this.xpos = x2;
        this.ypos = y2;
        newMult = (newVel.mag() - collisionVector.mag());
        this.xvel *= -1;
        checkCollisions(board, paddle, newMult);
        return 1;
      }
      if (closestPointx == paddle.xpos + paddle.w) {  //right side
        x2 = (closestPointx + w/2);
        y2 = slope * (x2 - xpos) + ypos;
        println("Previous point: " + "(" + xpos + ", " + ypos + ")");
        println("New point: " + "(" + x2 + ", " + y2 + ")");
        fill(0, 200, 0);
        ellipse(x2, y2, 20, 20);

        collisionVector = new PVector(x2 - xpos, y2-ypos);
        this.xpos = x2;
        this.ypos = y2;
        newMult = (newVel.mag() - collisionVector.mag());
        this.yvel *= -1;
        checkCollisions(board, paddle, newMult);
        return 1;
      }
      if (closestPointy == paddle.ypos) {  //top

        println("PADDLE COLLISION TOP");
        y2 = closestPointy - w/2;
        x2 = (y2 -ypos) /slope + xpos;
        println("Previous point: " + "(" + xpos + ", " + ypos + ")");
        println("New point: " + "(" + x2 + ", " + y2 + ")");
        fill(0, 200, 0);
        ellipse(x2, y2, 20, 20);

        collisionVector = new PVector(x2 - xpos, y2-ypos);
        this.xpos = x2;
        this.ypos = y2;
        newMult = (newVel.mag() - collisionVector.mag());
        this.yvel *= -1;
        checkCollisions(board, paddle, newMult);
        return 1;
      }
      if (closestPointy == paddle.ypos + paddle.h) {  //bottom
        y2 = closestPointy + w/2;
        x2 = (y2 -ypos) /slope + xpos;
        println("Previous point: " + "(" + xpos + ", " + ypos + ")");
        println("New point: " + "(" + x2 + ", " + y2 + ")");
        fill(0, 200, 0);
        ellipse(x2, y2, 20, 20);

        collisionVector = new PVector(x2 - xpos, y2-ypos);
        this.xpos = x2;
        this.ypos = y2;
        newMult = (newVel.mag() - collisionVector.mag());
        this.yvel *= -1;
        checkCollisions(board, paddle, newMult);
        return 1;
      }

      //adjust velocity
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
        //float preserveMag = collisionVector.mag();
        //collisionVector.normalize();
        //println(collisionVector.mag());
        //fill(0, 200, 0);
        //ellipse(closestPointx, closestPointy, 5, 5);
        //println("--------------------------");
        //println("Previous point: " + "(" + tempx + ", " + tempy + ")");
        //println("temp - closest point: " + "(" + (tempx- closestPointx) + ", " + (tempy - closestPointy) + ")");
        //println("Collision Factor: " + ((tempx- closestPointx) * (tempx - closestPointx) + (tempy - closestPointy) * (tempy - closestPointy)));
        //println("must be less than " + (w/2 * w/2));
        //println("--------------------------");
        if (((tempx- closestPointx) * (tempx - closestPointx) + (tempy - closestPointy) * (tempy - closestPointy)) < (w/2 * w/2)) {  //Collision!
          println("Collision! ");
          //move to collision point

          if (closestPointx == temp.xpos) {  //left side
            x2 = (closestPointx - w/2);
            y2 = slope * (x2 - xpos) + ypos;
            println("Previous point: " + "(" + xpos + ", " + ypos + ")");
            println("New point: " + "(" + x2 + ", " + y2 + ")");
            fill(0, 200, 0);
            ellipse(x2, y2, 20, 20);

            collisionVector = new PVector(x2 - xpos, y2-ypos);
            this.xpos = x2;
            this.ypos = y2;
            newMult = (newVel.mag() - collisionVector.mag());
            this.xvel *= -1;
            checkCollisions(board, paddle, newMult);
            return 1;
          }
          if (closestPointx == temp.xpos + temp.w) {  //right side
            x2 = (closestPointx + w/2);
            y2 = slope * (x2 - xpos) + ypos;
            println("Previous point: " + "(" + xpos + ", " + ypos + ")");
            println("New point: " + "(" + x2 + ", " + y2 + ")");
            fill(0, 200, 0);
            ellipse(x2, y2, 20, 20);

            collisionVector = new PVector(x2 - xpos, y2-ypos);
            this.xpos = x2;
            this.ypos = y2;
            newMult = (newVel.mag() - collisionVector.mag());
            this.yvel *= -1;
            checkCollisions(board, paddle, newMult);
            return 1;
          }
          if (closestPointy == temp.ypos) {  //top

            println("PADDLE COLLISION TOP");
            y2 = closestPointy - w/2;
            x2 = (y2 -ypos) /slope + xpos;
            println("Previous point: " + "(" + xpos + ", " + ypos + ")");
            println("New point: " + "(" + x2 + ", " + y2 + ")");
            fill(0, 200, 0);
            ellipse(x2, y2, 20, 20);

            collisionVector = new PVector(x2 - xpos, y2-ypos);
            this.xpos = x2;
            this.ypos = y2;
            newMult = (newVel.mag() - collisionVector.mag());
            this.yvel *= -1;
            checkCollisions(board, paddle, newMult);
            return 1;
          }
          if (closestPointy == temp.ypos + temp.h) {  //bottom
            y2 = closestPointy + w/2;
            x2 = (y2 -ypos) /slope + xpos;
            //println("Previous point: " + "(" + xpos + ", " + ypos + ")");
            //println("New point: " + "(" + x2 + ", " + y2 + ")");
            fill(0, 200, 0);
            ellipse(x2, y2, 20, 20);

            collisionVector = new PVector(x2 - xpos, y2-ypos);
            this.xpos = x2;
            this.ypos = y2;
            newMult = (newVel.mag() - collisionVector.mag());
            this.yvel *= -1;
            checkCollisions(board, paddle, newMult);
            return 1;
          }

          //adjust velocity
        }
      }
    }




    xpos = tempx;
    ypos = tempy;

    return 1; //if all collisions are normal
  }
}