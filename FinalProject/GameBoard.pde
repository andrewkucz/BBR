class GameBoard extends Screen { 

  // brick array
  Brick[][] board;
  
  // powerup list
  ArrayList<Powerup> powerups = new ArrayList<Powerup>();
  

  // rows and cols of bricks
  int rows = 6;
  int cols = 9;

  // space between bricks
  int gap = 3;

  // board level
  int level;
 //boolean hasDrawn = false;


  GameBoard() {
    board = new Brick[rows][cols];
    level = 1;
    col = color(255);
    initBoard(1);
  }

  GameBoard(int l) {
    board = new Brick[rows][cols];
    level = l;
    col = color(255);
    initBoard(l);
  }

  // init board of level L
  void initBoard(int l) {

    // brick size attributes  - calculated from board width and height using the number rows/cols and gap spacing
    int brickw = (w-((cols+1)*gap)) / cols;
    int brickh = ((h/3)-((rows+1)*gap)) / rows;

    if (l == 1)
    {
      for (int i = 0; i<rows; i++)
      {
        for (int j = 0; j<cols; j++)//change back to cols
        {
          Powerup p = new Powerup(xpos+(gap*(j+1))+(brickw*j)+(brickw/2), ypos+(gap*(i+1))+(brickh*i)+(brickh/2));
          if(p.getState() > 0)
           {
             powerups.add(p);
           }
          board[i][j] = new Brick(xpos+(gap*(j+1))+(brickw*j), ypos+(gap*(i+1))+(brickh*i), 4-((i/2)+1), l, p);
          board[i][j].w = brickw;
          board[i][j].h = brickh;
        }
      }
    }
    else if(l == 2)
    {
      
      for (int i = 0; i<rows; i++)
      {
        for (int j = 0; j<cols; j++)
        {
           int x=xpos+(gap*(j+1))+(brickw*j);
           int y=ypos+(gap*(i+1))+(brickh*i);
          
           int tempstate;
           
           Powerup p;
           
           if((j==0 && (i==1 || i==2 || i==3 || i==4)) || (j==1 && (i==2 || i==3)) || (j==2 && (i==2 || i==3)) || (j==3 && (i==0 || i==2 || i==3 || i==5)) ||
              (j==4 && (i==0 || i==1 || i==5 || i==4)) || (j==5 && (i==0 || i==2 || i==3 || i==5)) || (j==6 && (i==2 || i==3)) || (j==7 && (i==2 || i==3)) || (j==8 && (i==1 || i==2 || i==3 || i==4)) )
              {
                tempstate = 0;
                p = new Powerup(xpos+(gap*(j+1))+(brickw*j)+(brickw/2), ypos+(gap*(i+1))+(brickh*i)+(brickh/2));
                p.setState(0);
              }
              else
              {
                p = new Powerup(xpos+(gap*(j+1))+(brickw*j)+(brickw/2), ypos+(gap*(i+1))+(brickh*i)+(brickh/2));
                if(p.getState() > 0)
                {
                  powerups.add(p);
                }
                tempstate = 4;
              }
          board[i][j] = new Brick(x,y, tempstate, l, p);
          board[i][j].w = brickw;
          board[i][j].h = brickh;
        }
      }
    }
    else if(l == 3)
    {
      for (int i = 0; i<rows; i++)
      {
        for (int j = 0; j<cols; j++)
        {
           int x=xpos+(gap*(j+1))+(brickw*j);
           int y=ypos+(gap*(i+1))+(brickh*i);
          
           int tempstate;
           
           Powerup p;
           
           if(j == 0 || (j==1 && (i==0 || i==5)) || (j==2 && (i==0 || i==5)))
              {
                tempstate = 1;
              }
              else if((j==3 && i!=0) || (j==5 && i!=0) || (j==4 && (i==0 || i==3)))
              {
                tempstate = 3;
              }
              else if((j==6) || (j==7 && (i==0 || i==3)) || (j==8 && (i==1 || i==2)))
              {
                tempstate = 5;
              }
              else
              {
                tempstate = 0;
              }
              
              
                p = new Powerup(xpos+(gap*(j+1))+(brickw*j)+(brickw/2), ypos+(gap*(i+1))+(brickh*i)+(brickh/2));
                if(tempstate == 0)
                {
                  p.setState(0);
                }
                if(p.getState() > 0)
                {
                  powerups.add(p);
                }
              
          board[i][j] = new Brick(x,y, tempstate, l, p);
          board[i][j].w = brickw;
          board[i][j].h = brickh;
        }
      }
    }
  }

  void update() {
    
    background(0);
    noStroke();
    fill(col);
    
    rect(xpos, ypos, w, h);

  
    for (int i = 0; i<rows; i++)
    {
      for (int j = 0; j<cols; j++)
      {
          board[i][j].update();
      }
    }
    

    for(int i=0; i<powerups.size(); i++)
    {
      if(powerups.get(i).getState() == 0)
      {
        powerups.remove(i);
      }
      else
      {
      powerups.get(i).update();
      }
    }
  }


  boolean isEmpty()
  {
    for (int i = 0; i<rows; i++)
    {
      for (int j = 0; j<cols; j++)
      {
        if (board[i][j].state > 0)
          return false;
      }
    }
    return true;
  }


  // Returns the brick that containts the passed in coordinates x,y
  Brick getBrick(int x, int y)
  {
    for (int i = 0; i<rows; i++)
    {
      for (int j = 0; j<cols; j++)
      {
        if (board[i][j].xpos < x && board[i][j].xpos+board[i][j].w > x && board[i][j].ypos < y && board[i][j].ypos+board[i][j].h > y)
        {
          return board[i][j];
        }
      }
    }
    return new Brick();
  }
} 
