class Leaderboard extends Entity {

  ArrayList<Scoreline> board = new ArrayList<Scoreline>();
  BufferedReader reader;
  PrintWriter writer;
  String filename = "leaderboard.txt";
  int textsize = 16;
  PFont font = loadFont("ArcadeNormal-48.vlw");


  Leaderboard(int x, int y)
  {
    w = (width-588)/2;
    h = (height-20)/3;
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
    writer = createWriter(filename);

    for (Scoreline s : board)
    {
      writer.println(s.getName() + " | " + s.getScore());
    }

    writer.flush();
    writer.close();
  }

  void insertScore(String n, int s)
  {
    for (int i=0; i<board.size(); i++)
    {
      if (s > board.get(i).getScore())
      {
        board.add(i, new Scoreline(n, s));
        break;
      }
    }

    // Trim back down to 5
    while (board.size()>5)
    {
      board.remove(board.size()-1);
    }
    writeFile();
  }


  void update()
  {
    fill(0);
    rect(xpos, ypos, w, h);
    fill(255);
    textFont(font);
    textSize(textsize);

    text("Highscores", xpos+(w/2), ypos + h*0.1);

    for (int i=0; i<board.size(); i++)
    {
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