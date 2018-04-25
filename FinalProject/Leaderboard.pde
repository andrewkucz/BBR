class Leaderboard extends Entity {

  ArrayList<Scoreline> board = new ArrayList<Scoreline>();
  BufferedReader reader;
  PrintWriter writer;
  String filename = "leaderboard.txt";
  int textsize = 16;
  PFont font = loadFont("ArcadeNormal-48.vlw");


  Leaderboard(int x, int y)
  {
    super();
    w = (width-588)/2;
    h = (height)/3;
    xpos = x;
    ypos = y;
    parseFile();
  }

  void parseFile()
  {

    reader = createReader(filename);
    String line = null;
    String[] arr;

    try {

      line = reader.readLine();

      while (line != null)
      {
        arr = split(line, " | ");
        if (board.size() <=5)
        {
          board.add(new Scoreline(arr[0], arr[1]));
        }
        line = reader.readLine();
      }


      reader.close();
    } 

    catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  void writeFile()
  {
    writer = createWriter("./data/" + filename);

    for (Scoreline s : board)
    {
      writer.println(s.getName() + " | " + s.getScore());
      println(s.getName() + " | " + s.getScore());
    }

    writer.flush();
    writer.close();
    println("done");
  }

  void insertScore(String n, int s)
  {
    boolean added = false;
    for (int i=0; i<board.size(); i++)
    {
      if (s > board.get(i).getScore())
      {
        board.add(i, new Scoreline(n, s));
        added = true;
        break;
      }
    }
    if (!added)
      board.add(new Scoreline(n, s));

    // Trim back down to 5
    while (board.size()>5)
    {
      board.remove(board.size()-1);
    }
    writeFile();
    update();
  }


  void update()
  {
    fill(0);
    noStroke();
    rect(w+588, 0, w, height);
    rect(xpos, ypos, w, h);
    fill(255);
    textFont(font);
    textSize(textsize);
    textAlign(CENTER);
    text("Highscores", xpos+(w/2), ypos + h*0.1);

    for (int i=0; i<board.size(); i++)
    {
      if (game.playername.equals(board.get(i).getName()) && game.score == board.get(i).getScore())
      {
        fill(255, 0, 0);
      } else
      {
        fill(255);
      }
      text(board.get(i).toString(), xpos+(w/2), ypos+(30*i)+(h*0.25));
    }
  }
}





class Scoreline {

  int score;
  String name;

  Scoreline() {
    score = 0;
    name = "";
  }

  Scoreline(String n, int s)
  {
    score = s;
    name = n;
  }

  Scoreline(String n, String s)
  {
    score = Integer.parseInt(s);
    name = n;
  }

  int getScore()
  {
    return score;
  }
  String getName()
  {
    return name;
  }
  String toString()
  {
    String s = "";
    s+= name;
    s += "........";
    for (int i=0; i<5-Integer.toString(score).length(); i++)
    {
      s+="0";
    }
    s += Integer.toString(score);
    return s;
  }
}