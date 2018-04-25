import java.util.*;
class Game {

  Title titlescreen;
  PauseMenu pausemenu;
  Menu optionsmenu;
  Menu gamemodemenu, twoplayermenu;
  Menu aboutmenu;
  NameEntry nameentry;
  GameBoard board;
  HUD gameinfo;
  Menu gameovermenu;
  
  SoundFile bgmusic, menuclick, collision, shoot, die, win, lose;  

  boolean initialized = false;
  int gamemode;
  // Gamemodes
  // Single player = 1
  // 2 Player Co-op = 2
  // 2 Player battle = 3


  Paddle paddle;

  ArrayList<Ball> balls = new ArrayList<Ball>();
  int score;
  
  //for h2h
  int player1score;
  int player2score;
  int numLives;
  int rounds;
  String playername;
  String playername2;

  Paddle paddle2;
  Paddle[] paddles;
  


  int gamestate;
  Leaderboard highscores;

  boolean clicked = false;


  Game(PApplet p) {
    
    bgmusic = new SoundFile(p, "bgmusic.mp3");
    bgmusic.loop();
    bgmusic.amp(0.3);
    gamestate = 0;
    score = 0;
    numLives = 3;
    rounds = 5;
    gamemode = 1;
    shoot = new SoundFile(p, "shoot.wav");
    collision = new SoundFile(p, "collision.wav");
    menuclick = new SoundFile(p, "menuclick.wav");
    die = new SoundFile(p, "die.wav");
    win = new SoundFile(p, "win.wav");
    lose = new SoundFile(p, "lose.wav");
    
    Entity e = new Entity(this);
    
    // Initialize menus
    initMenus();
  }


  // Game cycle
  void update()
  {
    if (!initialized)
    {
      initGameComponents(1);
      initialized = true;
    }

    switch(gamestate) {

    case 0: 
      titlescreen.update();
      break;
    case 1: 
      gameLoop();
      break;
    case 2: 
      pausemenu.update();
      break;
    case 4: 
      aboutmenu.update();
      break;
    case 5: 
      nameentry.update();
      break;
    case 6: 
      gamemodemenu.update();
      break;
    case 7: 
      twoplayermenu.update();
      break;
    case 8: 
      nameentry.update();
      break;
    case 9:
      nameentry.update();
      break;
    case 10:
      gameovermenu.update();
      if(gamemode != 3)
      gameinfo.update(score, numLives, paddle.getState(), paddle2.getState());
      break;
      
    }


    updateGameState();

  }

  // Initializes all game components (regardless of gamemode)
  // Gamemode specific rendering occurs in gameLoop();
  void initGameComponents(int l)
  {
    if(l == 1)
    {
      numLives = 3;
    }
    
    // Initialize game board containing the brick array
    if (gamemode == 3)
      l = -1;  //special 1v1 level
    board = new GameBoard(l);

    // Initialize user controlled paddle object
    paddle = new Paddle(118, 15, 0, color(255, 0, 0));
    paddle.setLocation(board.xpos + ((board.w-paddle.w)/2), board.h - (paddle.h*2));

    paddle2 = new Paddle(118, 15, 0, color(0, 0, 255));
    paddles = new Paddle[2];
    paddles[0] = paddle;
    paddles[1] = paddle2;
    // Initialize ball object
    balls.clear();
    balls.add(new Ball(1));
    balls.get(0).setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);


    if (gamemode==2)
    {
      paddle.setLocation(board.xpos + ((board.w-paddle.w)/3), board.h - (paddle.h*2));
      paddle2.setLocation(board.xpos + (2*(board.w-paddle.w)/3), board.h - (paddle.h*2));
      balls.add(new Ball(1));
      balls.get(1).setLocation(paddle2.xpos+paddle.w/2, paddle2.ypos-balls.get(1).h/2);
      balls.get(0).setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);
    }
    if (gamemode == 3)
    {
      //set up paddles and balls
      paddle.setLocation(board.xpos + ((board.w-paddle.w)/2), board.h - (paddle.h*2));
      paddle2.setLocation(board.xpos + ((board.w-paddle.w)/2), paddle.h);
      balls.add(new Ball(1));
      balls.get(1).setLocation(paddle2.xpos+paddle.w/2, paddle2.ypos + paddle.h + balls.get(1).h/2);//set this to the bottom of the paddle
      balls.get(1).rotatePointerDown();
      balls.get(0).setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);
      //adjust grid location
    }

    // Init leaderboard
    highscores = new Leaderboard(board.xpos + board.w, board.ypos+30);
    
    // Init game info display
    if (gamemode ==1 || gamemode == 2){
    gameinfo = new HUD(0,0, playername, numLives);
    }
    if(gamemode == 3){
    gameinfo = new HUD(playername,playername2);
    }
  }




  // Game collision  detection
  void checkCollisions()
  { 
    
    for(Powerup p : board.powerups)
    {
      p.checkCollisions(board, paddle);
      if(gamemode == 2){
        p.checkCollisions(board,paddle2);
      }
    }
    
    paddle.blaster.checkCollisions(board);
    if (gamemode == 2){
      paddle2.blaster.checkCollisions(board);
    }
  }


  void initMenus()
  {
    titlescreen = new Title();
    titlescreen.addButton("Start");
    titlescreen.addButton("About");

    pausemenu = new PauseMenu();
    pausemenu.addButton("Resume");
    pausemenu.addButton("Quit");
    

    nameentry = new NameEntry("ENTER INITIALS");

    gamemodemenu = new Menu();
    gamemodemenu.addButton("1 PLAYER");
    gamemodemenu.addButton("2 PLAYER");
    gamemodemenu.addButton("BACK");

    twoplayermenu = new Menu();
    twoplayermenu.addButton("CO-OP");
    twoplayermenu.addButton("Battle");
    twoplayermenu.addButton("BACK");
    twoplayermenu.buttons.get(1).setColor(color(200));
    twoplayermenu.buttons.get(1).textColor = color(210);
    
    gameovermenu = new Menu();
    gameovermenu.setTitle("GAME OVER");
    gameovermenu.addButton("RESTART");
    gameovermenu.addButton("QUIT");
    gameovermenu.setBGColor(color(255,255,255,0));
    
    aboutmenu = new Menu();
    aboutmenu.addButton("BACK");
  }


  // Depends on gamemode
  void gameLoop()
  {
    board.update();
    
    paddle.inBounds = paddle.inBoundaries(board);
    
    paddle.update();
    if (gamemode==2 || gamemode == 3){
      paddle2.inBounds = paddle2.inBoundaries(board);
      paddle2.update();
    }
    if (gamemode == 1 || gamemode == 2){
      gameinfo.update(score, numLives, paddle.getState(), paddle2.getState());
    }
    if(gamemode == 3){
       gameinfo.update(player1score,player2score, rounds); 
    }
    highscores.update();
    
    if (!balls.isEmpty()){
      int returnVal = 0;
    for (Ball b : balls) {
      if (b.getState() == 1)
      {
        //b.setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);
      }
      if (b.getState() != 3) //draw for all states except 3
      b.update();

      //ball collison checking with bounds and bricks
      if(b.state == 2 || b.state == 5){
        returnVal = b.checkCollisions(board, paddles);
        if (returnVal == -1) break;
      }
    }

    for (int i = 0; i < balls.size(); i ++){
      if (balls.get(i).getState() == 3){
        balls.remove(i);
        i--;
      }
    }
    if (returnVal == -1){
      nextLevel();
    }
    }
    else{
      if(gamemode == 1 || gamemode == 2){
         loseLife(); 
      }
      else if(gamemode == 3){
         nextRound(); 
      }
    }
    checkCollisions();
    
  }



  int getGameState()
  {
    return gamestate;
  }

  void updateGameState()
  {

    // Main menu start is clicked
    if (gamestate == 0 && titlescreen.buttons.get(0).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 6;
    }


    // Main menu about is clicked
    else if (gamestate == 0 && titlescreen.buttons.get(1).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 4;
    }

    // Game is running and p is pressed -> pause state
    else if (gamestate == 1 && keyPressed && key == 'p')
    {
      game.menuclick.play();
      gamestate = 2;
    }

    // Pause menu resume is clicked
    else if (gamestate == 2 && pausemenu.buttons.get(0).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 1;
      pausemenu.active = false;
      background(0);
    }
    // Pause menu quit is clicked
    else if (gamestate == 2 && pausemenu.buttons.get(1).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 0;
      initGameComponents(1);
      pausemenu.active = false;
      background(0);
    }
    // Name entry menu "OK" is clicked
    else if (gamestate == 5 && nameentry.ok.isHovered() && clicked && nameentry.name[2] != ' ')
    {
      game.menuclick.play();
      playername = new String(nameentry.name);
      gamestate = 1;
      initGameComponents(1);
    }
    // Single player name entry menu "BACK" is clicked 
    else if (gamestate == 5 && nameentry.back.isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 6;
      if(gamemode==2)
      {
        gamestate = 7;
      }
    }
    // Gamemode menu "1 Player" is clicked
    else if (gamestate == 6 && gamemodemenu.buttons.get(0).isHovered() && clicked)
    {
      game.menuclick.play();
      nameentry.setDirections("ENTER INITIALS");
      nameentry.cleararr();
      gamestate = 5;
      gamemode = 1;
    }
    // Gamemode menu "2 Player" is clicked
    else if (gamestate == 6 && gamemodemenu.buttons.get(1).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 7;
    }
    // Gamemode menu "Back" is clicked
    else if (gamestate == 6 && gamemodemenu.buttons.get(2).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 0;
    }
    // 2 player menu "co-op" is clicked
    else if (gamestate == 7 && twoplayermenu.buttons.get(0).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 5;
      nameentry.setDirections("ENTER TEAM TAG");
      nameentry.cleararr();
      gamemode = 2;
    }
    // 2 player menu "battle" is clicked
    else if (gamestate == 7 && twoplayermenu.buttons.get(1).isHovered() && clicked)
    {

      game.menuclick.play();
      gamemode = 3;
      nameentry.setDirections("ENTER P1 TAG");
      nameentry.cleararr();
      gamestate = 8;
      
    }
    // 2 player menu "back" is clicked
    else if (gamestate == 7 && twoplayermenu.buttons.get(2).isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 6;
    }
    // 2 player 1st player name entry screen "OK" is clicked
    else if (gamestate == 8 && nameentry.ok.isHovered() && clicked && nameentry.name[2] != ' ')
    {
      game.menuclick.play();
      gamestate = 9;
      playername = new String(nameentry.name);
      println(playername);
      nameentry.setDirections("ENTER P2 TAG");
      nameentry.cleararr();
    }
    // 2 player 2nd player name entry screen "OK" is clicked
    else if (gamestate == 9 && nameentry.ok.isHovered() && clicked && nameentry.name[2] != ' ')
    {
      game.menuclick.play();
      gamestate = 1;
      playername2 = new String(nameentry.name);
      initGameComponents(1);
    }
    // 2 player 2nd player name entry screen "BACK" is clicked
    else if (gamestate == 9 && nameentry.back.isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 8;
      nameentry.setDirections("ENTER P1 TAG");
      nameentry.name[0] = playername.charAt(0);
      nameentry.name[1] = playername.charAt(1);
      nameentry.name[2] = playername.charAt(2);
      nameentry.cursor = 2;
    }
    // 2 player 1st player name entry screen "BACK" is clicked
    else if (gamestate == 8 && nameentry.back.isHovered() && clicked)
    {
      game.menuclick.play();
      gamestate = 7;
    }
    // Game end menu restart is clicked
    else if(gamestate == 10 && gameovermenu.buttons.get(0).isHovered() && clicked)
    {
      game.score = 0;
      game.menuclick.play();
      gamestate = 1;
      initGameComponents(1);
    }
    else if(gamestate == 10 && gameovermenu.buttons.get(1).isHovered() && clicked)
    {
      game.score = 0;
      game.menuclick.play();
      gamestate = 0;
    }
    else if(gamestate == 4 && aboutmenu.buttons.get(0).isHovered() && clicked)
    {
      gamestate = 0;
    }


    clicked = false;
  }
  void nextRound(){
    rounds --;
    
    if (rounds > 0){
      paddle.leftpressed = false;
      paddle.rightpressed = false;
      paddle2.leftpressed = false;
      paddle2.rightpressed = false;
      balls.add(new Ball(1));
      balls.add(new Ball(1));
      
      balls.get(1).setLocation(paddle2.xpos+paddle.w/2, paddle2.ypos + paddle.h + balls.get(1).h/2);//set this to the bottom of the paddle
      balls.get(1).rotatePointerDown();
      balls.get(0).setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);
    }
    else {
      int winner = 0;
      if(player1score > player2score){
        winner = 1;
        gameovermenu.setTitle("Player " + winner + " wins!");
      }
      else if(player2score > player1score){
        winner = 2;
        gameovermenu.setTitle("Player " + winner + " wins!");
      }
      else {
        gameovermenu.setTitle("Draw!");
      }
      
     gamestate = 10;
    }
  }
  void loseLife(){
    numLives --;
    if (numLives > 0){
      
      balls.add(new Ball(1));
      paddle.leftpressed = false;
        paddle.rightpressed = false;//stop paddle movement
      if (gamemode == 1){
        balls.get(0).setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);
        
      }
      else if(gamemode == 2){  //set ball to random paddle location if in co-op mode
        paddle2.leftpressed = false;
        paddle2.rightpressed = false;
        int pad = (int)random(2);
        if (pad == 0){
          balls.get(0).setLocation(paddle.xpos + paddle.w/2, paddle.ypos - balls.get(0).h/2);
        }
        else{
          balls.get(0).setLocation(paddle2.xpos + paddle.w/2, paddle2.ypos - balls.get(0).h/2);
        }
      }
    }
    else {
     
     lose.play();
     gameovermenu.setTitle("GAME OVER");
     gamestate = 10;
     highscores.insertScore(playername, score);
     
    }
  }
  
  void nextLevel()
  {
    win.play();
    board.level++;
    
    if(board.level == 4)
    {
      board.level = 1;
      gameovermenu.setTitle("YOU WIN");
      gamestate = 10;
      highscores.insertScore(playername, score);
    }
    
    initGameComponents(board.level);
     
  }
  
}