class Game {

  Title titlescreen;
  Menu pausemenu;
  Menu optionsmenu;
  Menu gamemodemenu, twoplayermenu;
  Screen about;
  NameEntry nameentry;
  GameBoard board;
  
  Paddle paddle;
  ArrayList<Ball> balls = new ArrayList<Ball>();
  int score, numLives;
  String playername;
  int gamestate;
  Leaderboard highscores;


  Game() {
    gamestate = 5;
    score = 0;
    numLives = 3;
    initGameComponents();
  }


  // Game cycle
  void update()
  {


    if (gamestate == 0)
    {
      titlescreen.update();
    } else if (gamestate == 1)
    {
      gameLoop();
    } else if (gamestate == 2)
    {
      pausemenu.update();
    } else if (gamestate == 3)
    {
      //optionsmenu.update();
    } else if (gamestate == 4)
    {
      //about.update();
    } else if (gamestate == 5)
    {
      nameentry.update();
    }


    updateGameState();
    
    // move collision check (?)
    checkCollisions();
  }

  void initGameComponents()
  {
    // Initialize game board containing the brick array
    board = new GameBoard(1);

    // Initialize user controlled paddle object
    paddle = new Paddle(board.w/5, 15, 0, color(0));
    paddle.setLocation(board.xpos + ((board.w-paddle.w)/2), board.h - (paddle.h*2));

    // Initialize ball object
    balls.clear();
    balls.add(new Ball(1));
    balls.get(0).setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);

    // Initialize menus
    initMenus();

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

    pausemenu = new Menu();
    pausemenu.addButton("Resume");
    pausemenu.addButton("Quit");
    
    nameentry = new NameEntry();
    
    gamemodemenu = new Menu();
    gamemodemenu.addButton("1 Player");
    gamemodemenu.addButton("2 Player");
    
    gamemodemenu = new Menu();
    gamemodemenu.addButton("1 Player");
    gamemodemenu.addButton("2 Player");
  }


  void gameLoop()
  {
    board.update();
    paddle.update();
    highscores.update();

    for (Ball b : balls) {
      if (b.getState() == 1)
      {
        b.setLocation(paddle.xpos+paddle.w/2, paddle.ypos-balls.get(0).h/2);
      }
      b.update();
    }
  }
  
  int getGameState()
  {
    return gamestate;
  }
  
  void updateGameState()
  {

    // Main menu start is clicked
    if (gamestate == 0 && titlescreen.buttons.get(0).isHovered() && mousePressed)
    {
      gamestate = 1;
    }

    // Main menu options is clicked
    if (gamestate == 0 && titlescreen.buttons.get(1).isHovered() && mousePressed)
    {
      gamestate = 3;
    }

    // Main menu about is clicked
    if (gamestate == 0 && titlescreen.buttons.get(1).isHovered() && mousePressed)
    {
      gamestate = 4;
    }

    // Game is running and p is pressed -> pause state
    if (gamestate == 1 && keyPressed && key == 'p')
    {
      gamestate = 2;
    }

    // Pause menu resume is clicked
    if (gamestate == 2 && pausemenu.buttons.get(0).isHovered() && mousePressed)
    {
      gamestate = 1;
    }

    // Pause menu quit is clicked
    if (gamestate == 2 && pausemenu.buttons.get(1).isHovered() && mousePressed)
    {
      gamestate = 0;
      initGameComponents();
    }
    
    // Name entry menu ok is clicked
    if (gamestate == 5 && nameentry.ok.isHovered() && mousePressed && nameentry.name[2] != ' ')
    {
      gamestate = 1;
      playername = new String(nameentry.name);
    }
    
    // Name entry menu back is clicked 
    if (gamestate == 5 && nameentry.back.isHovered() && mousePressed)
    {
      gamestate = 0;
    }
    
  }
}
