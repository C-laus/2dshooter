// Collison Events

void beginContact(Contact cp)
{
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  if(f1.isSensor() || f2.isSensor())
    println("Sensor");
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  player p = null;
  if((o1.getClass() == user_player.class || o1.getClass() == user_player.class) && f1.isSensor() && (o2.getClass() == box.class || o2.getClass() == bridge_particle.class))
    p = (player)o1;
  if((o2.getClass() == user_player.class || o2.getClass() == user_player.class) && f2.isSensor() && (o1.getClass() == box.class || o1.getClass() == bridge_particle.class))
    p = (player)o2;
  if(p!=null)
    p.jumpreset();
  
  if(o1.getClass() == bullet.class)
  {
    bullet bullet1 = (bullet) o1;
    if(o2.getClass() == bullet.class)
    {
      bullet bullet2 = (bullet) o2;
      bullet2.setLifespan(0);
      bullet1.setLifespan(0);
    }
    else if((o2.getClass() == user_player.class || o2.getClass() == bot_player.class) && !f2.isSensor())
    {
      bullet1.setLifespan(0);
      player player2 = (player) o2;
      player2.subHealth(0.05);
      player2.setLastBulletPlayer(bullet1.getPlayer());  // bullet1.getPlayer()
    }
    else if(o2.getClass() == box.class || o2.getClass() == bridge_particle.class)
    {
      bullet1.setLifespan(0);
    }
  }
  else if((o1.getClass() == user_player.class || o1.getClass() == bot_player.class) && !f2.isSensor())
  {
    if(o2.getClass() == bullet.class)
    {
      bullet bullet2 = (bullet) o2;
      bullet2.setLifespan(0);
      player player1 = (player) o1;
      player1.subHealth(0.05);
      player1.setLastBulletPlayer(bullet2.getPlayer());
    }
  }
  else if(o1.getClass() == box.class || o1.getClass() == bridge_particle.class)
  {
    if(o2.getClass() == bullet.class)
    {
      bullet bullet1 = (bullet) o2;
      bullet1.setLifespan(0);
    }
  }
}
