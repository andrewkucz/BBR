class Leaderboard {
 
  int xpos, ypos;
  ArrayList<Scoreline> board = new ArrayList<Scoreline>();
  
  BufferedReader reader;
  PrintWriter writer;
 
  String filename = "leaderboard.txt";
  int bheight = (height-20)/3; 
  int bwidth = (width-588)/2;
  
  
  Leaderboard()
  {
    xpos = 0;
    ypos = 0;
    parseFile(); 
  }
  
  Leaderboard(int x, int y)
  {
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
        if(board.size() <=5)
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
    for(int i=0; i<board.size(); i++)
    {
      if(s > board.get(i).getScore())
      {
        board.add(i, new Scoreline(n,s));
        break;
      }
    }
    
    // Trim back down to 5
    while(board.size()>5)
    {
      board.remove(board.size()-1);
    }
    
  }
 
 void setLocation(int x, int y)
 {
   xpos = x;
   ypos = y;
 }
  
 void update()
 {
   fill(255,0,0);
   rect(xpos, ypos, bwidth, bheight);
   fill(255);
   textFont(loadFont("Axis-24.vlw"));
   
   for(int i=0; i<5; i++)
   {
    
     text((i+1) + " | " + board.get(i).getName() + " | " + board.get(i).getScore() + "pts", xpos+(bwidth/2), ypos+(30*i)+(bheight*0.25));
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
 
  
}
