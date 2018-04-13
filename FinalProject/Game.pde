class Game {
 
 Menu mainmenu;
 Menu pausemenu;
 GameBoard board;
 Paddle paddle;
 Ball ball;
 int score, numLives;
 String playername;
 boolean paused;
 String[][] highscores = new String[5][2];
  
 Game() {
   
   score = 0;
   numLives = 3;
   
   // Initialize game board containing the brick array
   board = new GameBoard();
   
   // Initialize user controlled paddle object
   paddle = new Paddle(board.bwidth/5, 15, 0, color(0));
   paddle.setLocation(board.xpos + ((board.bwidth-paddle.padwidth)/2), board.bheight - (paddle.padheight*2));
  
   // Initialize ball object
   ball = new Ball(true);
   ball.setLocation(paddle.xpos+paddle.padwidth/2, paddle.ypos-ball.size/2);
   
 }
   
 
 // Game cycle
 void update()
 {
    board.update();
    paddle.update();
    ball.update();
    
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
  
  

  
  
  
  
}
