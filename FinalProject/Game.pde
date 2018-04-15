class Game {
 
 TitleScreen mainmenu;
 Menu pausemenu;
 Menu optionsmenu;
 GameBoard board;
 Paddle paddle;
 ArrayList<Ball> balls = new ArrayList<Ball>();
 int score, numLives;
 String playername;
 int gamestate;
 String[][] highscores = new String[5][2];
  
 Game() {
   gamestate = 0;
   score = 0;
   numLives = 3;
   initGameComponents();
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
      gameLoop();
    }
    else if(gamestate == 2)
    {
      pausemenu.update();
    }
    else if(gamestate == 3)
    {
      //optionsmenu.update();
    }
    
    updateGameState();
    
    // move collision check (?)
    checkCollisions();
 }
 
 void initGameComponents()
 {
   // Initialize game board containing the brick array
   board = new GameBoard();
   
   // Initialize user controlled paddle object
   paddle = new Paddle(board.bwidth/5, 15, 0, color(0));
   paddle.setLocation(board.xpos + ((board.bwidth-paddle.padwidth)/2), board.bheight - (paddle.padheight*2));
  
   // Initialize ball object
   balls.clear();
   balls.add(new Ball(true));
   balls.get(0).setLocation(paddle.xpos+paddle.padwidth/2, paddle.ypos-balls.get(0).size/2);
   
   // Initialize menus
   initMenus();
 }
 
 
 
 
 // Game collision  detection
 void checkCollisions()
 {
   
   // Paddle collision with the walls
   if((paddle.xpos <= board.xpos && !rightpressed) || (paddle.xpos+paddle.padwidth >= board.xpos+board.bwidth && !leftpressed))
   {
     paddle.xvel = 0;
   }  
   
   // insert a lot of code and math here
   
 }
 
 
 void initMenus()
 {
   mainmenu = new TitleScreen();
   mainmenu.addButton("Start");
   mainmenu.addButton("Options");
   mainmenu.addButton("About");
   
   pausemenu = new Menu();
   pausemenu.addButton("Resume");
   pausemenu.addButton("Quit");
 }
 
 
 void gameLoop()
 {
    board.update();
    paddle.update();
    
    for (Ball b : balls) {
      b.update();
    }
 }
  
  
  void updateGameState()
  {
    
    // Main menu start is clicked
    if(gamestate == 0 && mainmenu.buttons.get(0).isHovered() && mousePressed)
    {
      gamestate = 1;
    }
    
    // Main menu options is clicked
    if(gamestate == 0 && mainmenu.buttons.get(1).isHovered() && mousePressed)
    {
      gamestate = 3;
    }
    
    // Main menu about is clicked
    if(gamestate == 0 && mainmenu.buttons.get(1).isHovered() && mousePressed)
    {
      gamestate = 4;
    }
    
    // Game is running and p is pressed -> pause state
    if(gamestate == 1 && keyPressed && key == 'p')
    {
      gamestate = 2;
    }
    
    // Pause menu resume is clicked
    if(gamestate == 2 && pausemenu.buttons.get(0).isHovered() && mousePressed)
    {
      gamestate = 1;
    }
    
    // Pause menu quit is clicked
    if(gamestate == 2 && pausemenu.buttons.get(1).isHovered() && mousePressed)
    {
      gamestate = 0;
      initGameComponents();
    }
    
  }
  

  
  
  
  
}
