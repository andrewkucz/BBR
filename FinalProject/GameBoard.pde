class GameBoard { 

  // brick array
  Brick[][] board;
  // rows and cols of bricks
  int rows, cols;
  // top left coordinates of gameboard and height and width of it
  int bheight, bwidth;
  int xpos, ypos;
  // space between bricks
  int gap = 3;
  // brick size attributes
  int brickh, brickw;
  
  // board color
  color bgcolor = color(255);
  // game level
  int level;
  
  GameBoard() {
    rows = 6;
    cols = 9;
    board = new Brick[rows][cols];
    
    bheight = height-20;
    bwidth = 588;
    ypos = (height-bheight)/2;
    xpos = (width-bwidth)/2;
    
    level = 1;
    initBoard(level);
  }

   
  GameBoard(int r, int c, int l) {
    rows = r;
    cols = c;
    board = new Brick[rows][cols];
    
    bheight = height-20;
    bwidth = 600;
    ypos = (height-bheight)/2;
    xpos = (width-bwidth)/2;
    
    level = l;
    initBoard(l);
    

  }
  
  void initBoard(int lev) {
    
    brickw = (bwidth-((cols+1)*gap)) / cols;
    brickh = ((bheight/3)-((rows+1)*gap)) / rows;
    
    
    if(lev == 1)
    {
      for(int i = 0; i<rows; i++)
      {
        for(int j = 0; j<cols; j++)
        {
          board[i][j] = new Brick((i/2)+1,0,lev);
        }
      }
   
    }
    
    // other level schemes here
    
}
  
  void drawBoard() {
    
    strokeWeight(1);
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
          rect(xpos+(gap*(j+1))+(brickw*j), ypos+(gap*(i+1))+(brickh*i), brickw, brickh);
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
  
  void setBGcolor(color c)
  {
    bgcolor = c;
  }
  
  
  
} 