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
        for (int j = 0; j<cols; j++)
        {
          Powerup p = new Powerup(xpos+(gap*(j+1))+(brickw*j)+(brickw/2), ypos+(gap*(i+1))+(brickh*i)+(brickh/2));
          if(p.getState() > 0)
           {
             powerups.add(p);
           }
          board[i][j] = new Brick(xpos+(gap*(j+1))+(brickw*j), ypos+(gap*(i+1))+(brickh*i), (i/2)+1, l, p);
          board[i][j].w = brickw;
          board[i][j].h = brickh;
        }
      }
    }

    // other level schemes here
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
