
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
    col = color(0);
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

  int checkCollisions(GameBoard board, Paddle paddle)
  {
    
    //collison with board boundaries
    if (this.xpos > (board.w + board.xpos - w/2) || this.xpos < board.xpos + w/2) {
      this.xvel = -this.xvel;
    }
    if (this.ypos < board.ypos + w/2) {
      this.yvel = -this.yvel;
    }
    //if (ypos > board.ypos + board.bheight - size/2) {
      //this.yvel = -this.yvel;
      //return -1; //remove ball from array
    //}
    
    //get vertical distance from center of paddle
    float vertDist = abs(ypos - (paddle.ypos + paddle.w/2));
    //get position compared to horizontal
    float horDist = abs(xpos - ( paddle.xpos + paddle.w/2));
    //println(vertDist);
    if (vertDist <= (w/2 + paddle.w/2)){
      println(vertDist <= (w/2 + paddle.w/2));
      yvel = 1;
      //if(horDist <= (size/2 + paddle.padwidth/2)){
      //  yvel = abs(yvel);
      //}
    }
    
    
    
    
    //collision with paddle
    //circleDistance.x = abs(circle.x - rect.x);
    //circleDistance.y = abs(circle.y - rect.y);
  /*
    float distx = abs(xpos - paddle.xpos);
    float disty = abs(ypos - paddle.ypos);

    if (!(distx > (paddle.padwidth/2 + size/2))) { //dont do anything
    if (distx <= (paddle.padwidth/2)) { 
      //handle Collision
      xvel *= -1;
      
      println("first");
      println(distx + "\t" + paddle.padwidth/2);
    } 
    }
    if (!(disty > (paddle.padheight/2 + size/2))) { //dont do anything
    if (disty <= (paddle.padheight/2)) { 
      //handleCollision
      yvel *= -1;
      println("second");
    }
    }

    
    //if (disty <= (paddle.padheight/2)) { 
    //  //handleCollision
    //  yvel *= -1;
    //  println("second");
    //}
    
    if(pow((distx - paddle.padwidth/2),2) +
      pow((disty - paddle.padheight/2),2) <= pow(size/2,2)){
       //handle collision 
       
       if(ypos >= paddle.ypos){
         yvel *=-1;
         println("third");
       }
      }

    //return (cornerDistance_sq <= (circle.r^2));
  
*/
  return 1; //if all collisions are normal
  
  }
  
}