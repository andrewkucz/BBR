class Pointer extends Entity
{


  int length = 60;
  int thickness = 2;
  float angle = 0;
  float angularvel = 0.02;
  float endPosx;
  float endPosy;
  float direction;  //1 = up, 0 = down (for 2 player mode)

  Pointer()
  {
    xpos = 0;
    ypos = 0;

    direction = 1;
    angle = -PI/2;
  }

  Pointer(int x, int y)
  {
    xpos = x;
    ypos = y;
    //direction should eventually be passed in to constructor
    direction = 1;
    angle = -PI/2;
  }


  void update()
  {

    endPosx = length * cos(angle);
    endPosy = length * sin(angle);
    //translate(xpos,ypos);
    //rotate(angle);

    stroke(0);
    strokeWeight(thickness);
    //line(0, 0, 0, -length);
    line(xpos, ypos, xpos + endPosx, ypos + endPosy);
    angle += angularvel;

    if (direction == 1) {
      if (angle > (-PI/4) || angle < (-3 * PI/4))
      {
        angularvel = -angularvel;
      }
    }
    if (direction == 0) {
      if (angle > (-PI/4) || angle < (-3 * PI/4))
      {
        angularvel = -angularvel;
      }
    }
    resetMatrix();
  }

  void setLocation(int x, int y)
  {
    xpos = x;
    ypos = y;
  }
  PVector getStartVel() {
    //PVector vel = new PVector(0, 0);
    PVector vel = new PVector(endPosx,endPosy);
    vel = vel.normalize();

    return vel;
  }
}
