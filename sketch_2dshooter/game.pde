class game
{
  int type;
  boolean run;
  
  game(int type,String mapurl)
  {
    box2d.createWorld();
    box2d.listenForCollisions();
    box2d.setGravity(0, -10);
    
    run = false;
    
    boxes = new ArrayList<box>();
    bridges = new ArrayList<bridge>();
    bullets = new ArrayList<bullet>(); 
    players = new ArrayList<player>();
    spanpoints = new ArrayList<Vec2>();
    teams = new ArrayList<team>();
    
    setmap(mapurl);
    teams.add(new team(color(255,0,0),"R"));
    teams.add(new team(color(0,255,0),"G"));
    teams.add(new team(color(0,0,255),"B"));
    
    players.add(new user_player(getSpan(0),teams.get(2)));
    //players.add(new mariusbot_player());
    /*for(int i = 0; i < 2;i++)
    {
      players.add(new bot_player(getSpan(0),teams.get(0)));  
    }
    for(int i = 0; i < 2;i++)
    {
      players.add(new bot_player(getSpan(0),teams.get(1)));  
    }
    for(int i = 0; i < 1;i++)
    {
      players.add(new bot_player(getSpan(0),teams.get(2)));  
    }*/
  }
  
  void addPlayer(player p)
  {
    players.add(p);
  }
  
  void addTeam(team t)
  {
    teams.add(t);
  }
  
  void run()
  {
    run = true;
  }
  
  void paus()
  {
    run = false;
  }
  
  void setmap(String mapurl)
  {
    XML xml; 
    xml = loadXML(mapurl);
    println(xml.getString("name"));
    w = xml.getInt("width");
    h = xml.getInt("height");
    println("Mapp size:"+w+"*"+h);
  
    XML[] elements = xml.getChildren("element");
    println("Elemente zu laden:"+elements.length);
    for(int i = 0;i <elements.length;i++)
    {
      String typ = elements[i].getString("typ");
      if(typ.equals("box"))
      {
        println("New Box");
        boxes.add(new box(elements[i].getInt("x"),elements[i].getInt("y"),elements[i].getInt("w"),elements[i].getInt("h")));
      }
      if(typ.equals("bridge"))
      {
        println("New Bridge");
        bridges.add(new bridge(new Vec2(elements[i].getInt("x0"),elements[i].getInt("y0")),new Vec2(elements[i].getInt("x1"),elements[i].getInt("y1")),elements[i].getInt("len"),elements[i].getInt("parts")));
      }
      if(typ.equals("span"))
      {
        spanpoints.add(new Vec2(elements[i].getInt("x"),elements[i].getInt("y")));
      }
    }
  }
  
  Vec2 getSpan(int t)
  {
    return spanpoints.get((int)random(0,spanpoints.size()));
  }
  
  void clearLists()
  {  
    for(box b:boxes)
    {
      b.killBody();
    }
    for(bridge b:bridges)
    {
      
    }
    for(bullet b:bullets)
    {
      b.killBody();
    }
    for(mine m:mines)
    {
      m.killBody();
    }
    for(player p:players)
    {
      p.killBody();
    }
    
    boxes = new ArrayList<box>();
    bridges = new ArrayList<bridge>();
    bullets = new ArrayList<bullet>(); 
    players = new ArrayList<player>();
    spanpoints = new ArrayList<Vec2>();
    teams = new ArrayList<team>();
    mines = new ArrayList<mine>();
  }
  
  void display()
  {
   if(run)
    box2d.step();
  for(int i = 0;i <= players.size()-1;i++)
  {
    player p = players.get(i);
    if(p.getClass() == user_player.class)
      followplayer = i;
  }
  Vec2 pos = new Vec2(0,0);
  player p = null;
  if(players.size() != 0)
  {
    p = players.get(followplayer);
    pos = p.getPos();
  }
  //println(p.getHealth()); 
  pushMatrix();
  translate(-pos.x+width/2,-pos.y+height/2);
  for (int i = 0;i <= players.size()-1;i++)
  {
    player play = players.get(i);
    play.display();
    team t = play.getTeam();
    Vec2 Pos = play.getPos();
    if(Pos.x>w||Pos.y>h)
      play.subHealth(10);
    if(!play.isAlive()){
      play.killBody();
      if(play.getLastBulletPlayer() == null)
      {
        play.getTeam().addScoor(-1);
      }
      else
      {
        if(play.getLastBulletPlayer().getTeam() == t)
        {
          play.getLastBulletPlayer().getTeam().addScoor(-1);
        }       
        else {
          play.getLastBulletPlayer().getTeam().addScoor(1);
        }
      }
      players.remove(i);
      if(play.getClass() == bot_player.class){
        players.add(new bot_player(getSpan(0),t));
      }
      else if(play.getClass() == user_player.class){
        players.add(new user_player(getSpan(0),t));
      }
    }
  }
  for (box b: boxes) {
    b.display();
  }
  for (bridge b:bridges) {
    b.display();
  }
  for (int i = 0;i <= bullets.size()-1;i++) {
    bullet b = bullets.get(i);
    if(b.isalive())
      b.display();
    else{
        b.killBody();
        bullets.remove(b);
    }
  }
  
  for (int i = 0;i <= mines.size()-1;i++) {
    mine m = mines.get(i);
    if(m.isAlive())
      m.display();
    else{
        m.killBody();
        bullets.remove(m);
    }
  }
  
  if(p.getClass() == user_player.class)
    p.setAim(new Vec2(pos.x+mouseX-width/2,pos.y+mouseY-height/2));
  Vec2 aim = p.getAim();
  translate(aim.x,aim.y);
  rectMode(CENTER);
  rect(0,0,5,5);
  popMatrix();
  }
}
