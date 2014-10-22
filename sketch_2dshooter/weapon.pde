class weapon
{
  Vec2 Emitterofset;
  int shootdelay;
  int shootcounter = 0;
  float force;
  float maxspeed;
  int lifespan;
  float angle;
  float len;
  Vec2 aim;
  player p;
  
  weapon(player p)
  {
    Emitterofset = new Vec2(0,-15);
    shootdelay = 500;
    this.force = 150 ;
    maxspeed = 250;
    lifespan = 75;
    this.p = p;
    aim = new Vec2(2,5);
    len = 20;
  }
  
  void shoot(Vec2 Pos,Vec2 aim)
  {
    if(shootcounter == 0)
    {
      shootcounter = 0;
      Vec2 velocityvec = Pos;
      Pos.addLocal(Emitterofset);
      velocityvec = aim.sub(velocityvec);
      velocityvec.normalize();
      velocityvec.mulLocal(force);
      velocityvec.y *= -1;
      bullets.add(new bullet(Pos,velocityvec,maxspeed,lifespan,p));     
    }
    if(shootcounter >= shootdelay)
      shootcounter = 0;  
  }
  
  void display()
  {
    Vec2 a = aim.sub(p.getPos());
    angle = -atan2(a.x,a.y);
    fill(0,0,0);
    pushMatrix();
      rotate(angle);
      rectMode(CORNER);
      rect(0,-5,2,20);
    popMatrix();
  }
  
  void resetshoot()
  {
    shootcounter = 0;
  }
  
  void setAim(Vec2 aim)
  {
    this.aim = aim;
    Emitterofset.x = -sin(angle)*len;
    Emitterofset.y = cos(angle)*len;
  }
}
