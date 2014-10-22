
void keyPressed()
{
  if(!console)
  {
    if(key == 'c')
      console = true;
    for(int i = 0;i < players.size() ;i++){
      try {
      user_player p = (user_player)players.get(i);
      p.keyPressed(key);
      }catch (Exception e) {}
    }
  }
  else
  {
  if(key == ENTER)
    {
      String[] com = command.split(" ");
      if(com[0].equals("newgame")){
        game = new game(0,com[1]);
      }
      if(com[0].equals("startgame")){
        game.run();
      }
      if(com[0].equals("pausgame")){
        game.paus();
      }
      if(com[0].equals("newbot")){
        game.addPlayer(new bot_player(game.getSpan(0),teams.get(parseInt(com[1])))); 
      }
      command = "";
      console = false;
    }
    else if(key == BACKSPACE)
    {
      command = command.substring(0, command.length()-1);
    }
    else
    {
      command += key;
    }
  }
  
}

void keyReleased() {
  for(int i = 0;i < players.size() ;i++){
    try {
    user_player p = (user_player)players.get(i);
    p.keyReleased(key);
    }catch (Exception e) {}
  }
  if(key =='ü' && followplayer < players.size()-1)
    followplayer++;
  if(key == 'ä'&& followplayer > 0)
    followplayer--;
}

void mousePressed() {
  for(int i = 0;i < players.size() ;i++){
    try {
    user_player p = (user_player)players.get(i);
    p.mousePressed();
    }catch (Exception e) {}
  }
}

void mouseReleased(){
  for(int i = 0;i < players.size() ;i++){
    try {
    user_player p = (user_player)players.get(i);
    p.mouseReleased();
    }catch (Exception e) {}
  }
}
