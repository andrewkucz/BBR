class Game {

  Title titlescreen;
  PauseMenu pausemenu;
  Menu optionsmenu;
  Menu gamemodemenu, twoplayermenu;
  Screen about;
  NameEntry nameentry, nameentryp1, nameentryp2;
  GameBoard board;

  boolean initialized = false;
  int gamemode;
  // Gamemodes
  // Single player = 1
  // 2 Player Co-op = 2
  // 2 Player battle = 3


  Paddle paddle;

  ArrayList<Ball> balls = new ArrayList<Ball>();
  int score, numLives;
  String playername;

  Paddle paddle2;
  String playername2;


  int gamestate;
  Leaderboard highscores;

  boolean clicked = false;


  Game() {
    gamestate = 0;
    score = 0;
    numLives = 3;
    gamemode = 1;

    // Initialize menus
    initMenus();
  }


  // Game cycle
  void update()
  {
    if (!initialized)
    {
      initGameComponents();
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
    case 3: 
      //optionsmenu.update();
      break;
    case 4: 
      //aboutmenu.update();
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
      break;
    case 9: 
      break;
    case 10: 
      break;
      
    }


    updateGameState();

    // move collision check (?)
    checkCollisions();
  }

  // Initializes all game components (regardless of gamemode)
  // Gamemode specific rendering occurs in gameLoop();
  void initGameComponents()
  {

    // Initialize game board containing the brick array
    board = new GameBoard(1);

    // Initialize user controlled paddle object
    paddle = new Paddle(board.w/5, 15, 0, color(255, 0, 0));
    paddle.setLocation(board.xpos + ((board.w-paddle.w)/2), board.h - (paddle.h*2));

    paddle2 = new Paddle(board.w/5, 15, 0, color(0, 0, 255));

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

    // Init leaderboard
    highscores = new Leaderboard(board.xpos + board.w, board.ypos);
  }




  // Game collision  detection
  void checkCollisions()
  {
    // insert a lot of code and math here
  }


  void initMenus()
  {
    titlescreen = new Title();
    titlescreen.addButton("Start");
    titlescreen.addButton("Options");
    titlescreen.addButton("About");

    pausemenu = new PauseMenu();
    pausemenu.addButton("Resume");
    pausemenu.addButton("Quit");

    nameentry = new NameEntry("ENTER INITIALS");
    nameentryp1 = new NameEntry("ENTER P1 TAG");
    nameentryp2 = new NameEntry("ENTER P2 TAG");

    gamemodemenu = new Menu();
    gamemodemenu.addButton("1 PLAYER");
    gamemodemenu.addButton("2 PLAYER");
    gamemodemenu.addButton("BACK");

    twoplayermenu = new Menu();
    twoplayermenu.addButton("CO-OP");
    twoplayermenu.addButton("Battle");
    twoplayermenu.addButton("BACK");
  }


  // Depends on gamemode
  void gameLoop()
  {
    board.update();
    paddle.update();
    if (gamemode==2)
      paddle2.update();

    highscores.update();

    for (Ball b : balls) {
      if (b.getState() == 1)
      {
        //b.setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);
      }
      b.update();

      //ball collison checking with bounds and bricks
      b.checkCollisions(board, paddle);
    }
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
      gamestate = 6;
    }

    // Main menu options is clicked
    else if (gamestate == 0 && titlescreen.buttons.get(1).isHovered() && clicked)
    {
      gamestate = 3;
    }

    // Main menu about is clicked
    else if (gamestate == 0 && titlescreen.buttons.get(1).isHovered() && clicked)
    {
      gamestate = 4;
    }

    // Game is running and p is pressed -> pause state
    else if (gamestate == 1 && keyPressed && key == 'p')
    {
      gamestate = 2;
    }

    // Pause menu resume is clicked
    else if (gamestate == 2 && pausemenu.buttons.get(0).isHovered() && clicked)
    {
      gamestate = 1;
      pausemenu.active = false;
      background(0);
    }

    // Pause menu quit is clicked
    else if (gamestate == 2 && pausemenu.buttons.get(1).isHovered() && clicked)
    {
      gamestate = 0;
      initGameComponents();
      pausemenu.active = false;
      background(0);
    }

    // Name entry menu ok is clicked
    else if (gamestate == 5 && nameentry.ok.isHovered() && clicked && nameentry.name[2] != ' ')
    {
      gamestate = 1;
      playername = new String(nameentry.name);
    }

    // Name entry menu back is clicked 
    else if (gamestate == 5 && nameentry.back.isHovered() && clicked)
    {
      gamestate = 6;
    }

    // game mode menu 1 player is clicked 
    else if (gamestate == 6 && gamemodemenu.buttons.get(0).isHovered() && clicked)
    {
      gamestate = 5;
    }
    // game mode menu 2 player is clicked 
    else if (gamestate == 6 && gamemodemenu.buttons.get(1).isHovered() && clicked)
    {
      gamestate = 7;
    }
    // game mode menu back is clicked 
    else if (gamestate == 6 && gamemodemenu.buttons.get(2).isHovered() && clicked)
    {
      gamestate = 0;
    }
    // 2 player co-op is clicked
    else if (gamestate == 7 && twoplayermenu.buttons.get(0).isHovered() && clicked)
    {
      gamestate = 1;
      gamemode = 2;
      initGameComponents();
    }
    // 2 player battle is clicked
    else if (gamestate == 7 && twoplayermenu.buttons.get(1).isHovered() && clicked)
    {
      //gamemode = 3;
      //initGameComponents(gamemode);
    }
    // 2 player baack is clicked
    else if (gamestate == 7 && twoplayermenu.buttons.get(2).isHovered() && clicked)
    {
      gamestate = 6;
    }

    clicked = false;
  }
}