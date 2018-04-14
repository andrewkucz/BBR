class GameBoard { 

  // brick array
  Brick[][] board;
  
  // rows and cols of bricks
  int rows = 6;
  int cols = 9;
  // top left coordinates of gameboard and height and width of it
  int bheight = height-20;
  int bwidth = 588;
  int ypos = (height-bheight)/2;
  int xpos = (width-bwidth)/2;
  // space between bricks
  int gap = 3;
  // board background color
  color bgcolor = color(255);
  // ---------------
  // brick size attributes  - autocalculated from board width and height
  int brickh, brickw;
  // board level
  int level;
  // ---------------
  
  GameBoard() {
    board = new Brick[rows][cols];
    level = 1;
    initBoard(1);
  }
   
  GameBoard(int l) {
    board = new Brick[rows][cols];
    level = l;
    initBoard(l);
  }
  
  void initBoard(int blevel) {
    
    brickw = (bwidth-((cols+1)*gap)) / cols;
    brickh = ((bheight/3)-((rows+1)*gap)) / rows;
    
    if(blevel == 1)
    {
      for(int i = 0; i<rows; i++)
      {
        for(int j = 0; j<cols; j++)
        {
          board[i][j] = new Brick(xpos+(gap*(j+1))+(brickw*j), ypos+(gap*(i+1))+(brickh*i), (i/2)+1, blevel, new Powerup(xpos+(gap*(j+1))+(brickw*j)+(brickw/2), ypos+(gap*(i+1))+(brickh*i)+(brickh/2)));
          board[i][j].brickw = brickw;
          board[i][j].brickh = brickh;
        }
      }
   
    }
    // other level schemes here
  }
  
  void update() {
    
    noStroke();
    fill(bgcolor);
    rect(xpos, ypos, bwidth, bheight);
    
    for(int i = 0; i<rows; i++)
    {
      for(int j = 0; j<cols; j++)
      {
        if(board[i][j].state > 0)
        {
          fill(board[i][j].brickcol);
          noStroke();
          board[i][j].drawBrick();
        }
        
      }
    }
  }
  
  
  boolean isEmpty()
  {
    for(int i = 0; i<rows; i++)
    {
      for(int j = 0; j<cols; j++)
      {
        if(board[i][j].state > 0)
          return false;
      }
    }
    return true;
  }
  
  void setBackgroundColor(color c)
  {
    bgcolor = c;
  }
  
  // Returns the brick that containts the passed in coordinates x,y
  Brick getBrick(int x, int y)
  {
    for(int i = 0; i<rows; i++)
    {
      for(int j = 0; j<cols; j++)
      {
        if(board[i][j].xpos < x && board[i][j].xpos+brickw > x && board[i][j].ypos < y && board[i][j].ypos+brickh > y)
        {
          return board[i][j];
        }
      }
    }
    return new Brick();
  }
  
  
  
} 
