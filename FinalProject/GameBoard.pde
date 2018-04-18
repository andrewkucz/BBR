class GameBoard extends Screen { 

  // brick array
  Brick[][] board;

  // rows and cols of bricks
  int rows = 6;
  int cols = 9;

  // space between bricks
  int gap = 3;

  // board level
  int level;


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
          board[i][j] = new Brick(xpos+(gap*(j+1))+(brickw*j), ypos+(gap*(i+1))+(brickh*i), (i/2)+1, l, new Powerup(xpos+(gap*(j+1))+(brickw*j)+(brickw/2), ypos+(gap*(i+1))+(brickh*i)+(brickh/2)));
          board[i][j].w = brickw;
          board[i][j].h = brickh;
        }
      }
    }

    // other level schemes here
  }

  void update() {

    noStroke();
    fill(col);
    rect(xpos, ypos, w, h);

    for (int i = 0; i<rows; i++)
    {
      for (int j = 0; j<cols; j++)
      {
        if (board[i][j].state > 0)
        {
          fill(board[i][j].col);
          noStroke();
          board[i][j].update();
        }
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
        if (board[i][j].xpos < x && board[i][j].xpos+w > x && board[i][j].ypos < y && board[i][j].ypos+h > y)
        {
          return board[i][j];
        }
      }
    }
    return new Brick();
  }
} 
