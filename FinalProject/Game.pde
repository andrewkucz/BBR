class Game {
 
 Menu mainmenu;
 Menu pausemenu;
 Menu optionsmenu;
 GameBoard board;
 Paddle paddle;
 ArrayList<Ball> balls = new ArrayList<Ball>();
 int score, numLives;
 String playername;
 int gamestate = 0;
 String[][] highscores = new String[5][2];
  
 Game() {
   
   //gamestate = 1;
   score = 0;
   numLives = 3;
   
   // Initialize game board containing the brick array
   board = new GameBoard();
   
   // Initialize user controlled paddle object
   paddle = new Paddle(board.bwidth/5, 15, 0, color(0));
   paddle.setLocation(board.xpos + ((board.bwidth-paddle.padwidth)/2), board.bheight - (paddle.padheight*2));
  
   // Initialize ball object
   balls.add(new Ball(true));
   balls.get(0).setLocation(paddle.xpos+paddle.padwidth/2, paddle.ypos-balls.get(0).size/2);
   
   // Initialize menus
   initMenus();;
   
 }
   
 
 // Game cycle
 void update()
 {
    if(gamestate == 0)
    {
      mainmenu.update();
    }
    else if(gamestate == 1)
    {
    board.update();
    paddle.update();
    
    for (Ball b : balls) {
      b.update();
    }
    
    
    }
    else if(gamestate == 2)
    {
      pausemenu.update();
    }
    

    
    
    checkCollisions();
 }
 
 
 
 // Game collision  detection
 void checkCollisions()
 {
   
   // Paddle collision with the walls
   if((paddle.xpos <= board.xpos && !rightpressed) || (paddle.xpos+paddle.padwidth >= board.xpos+board.bwidth && !leftpressed))
   {
     paddle.xvel = 0;
   }  
   
   
   
   
   
 }
 
 
 void initMenus()
 {
   mainmenu = new Menu();
   mainmenu.addButton("START");
   mainmenu.addButton("OPTIONS");
   mainmenu.addButton("ABOUT");
   
   
 }
  
  

  
  
  
  
}
