/*
super.jump();
super.left();
super.right();
super.stop();
super.shoot();
super.setAim(Vec2);

for(player p:players)
{
	Vec2 = p.getPos();
}
*/

class bot_player extends player
{
	player p;

  bot_player()
  {
    super();
  }
  
  bot_player(Vec2 v,team t)
  {
    super(v,t);
  }
  void display()
  {
    if(random(0,1)<0.002)
      super.jump();
    else if(random(0,1)<0.02)
      super.left();
    else if(random(0,1)<0.02)
      super.right();
    else if(random(0,1)<0.05)
      super.stop();
    if(random(0,1)<0.02)
      super.shoot();
    player p = players.get(0);
    int teamcount = 0;
    while(this.getTeam() == p.getTeam()){
      teamcount++;
      p = players.get(teamcount);
    }
    super.setAim(p.getPos());
    
    super.display();
  }
}
