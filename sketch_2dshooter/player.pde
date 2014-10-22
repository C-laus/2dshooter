class player
{
  Body body;
  Vec2 aim;
  Vec2 span;
  int weaponselect = 0;
  weapon[] weapons = new weapon[3];
  float w,h;
  float health = 1;
  String sendstring;
  boolean healthbar = true;
  player lastbulletplayer;
  team t;
  int jump;
  
  player()
  {
    w = 5;
    h = 20;
    aim = new Vec2(10,5);
    span = box2d.coordPixelsToWorld(width/2,height/4);
    init(); 
    weapons[0] = new weapon(this);
    lastbulletplayer = null;
  }
  
  player(Vec2 span,team t)
  {
    w = 5;
    h = 20;
    aim = new Vec2(10,5);
    this.span = box2d.coordPixelsToWorld(span.x,span.y);
    init();
    weapons[0] = new weapon(this);
    this.t = t;
    lastbulletplayer = null;
  }
  
  private void init()
  {
    BodyDef bd = new BodyDef();
    bd.position.set(span);
    bd.type = BodyType.DYNAMIC;
    bd.fixedRotation = true;
    body = box2d.createBody(bd);
    
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW,box2dH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 100;
    fd.friction = 0;
    fd.restitution = 0.1;
            
    body.createFixture(fd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = 2.0;
    
    fd = new FixtureDef();
    fd.shape = cs;
    fd.isSensor = true;
    
    body.createFixture(fd);
    
    body.setUserData(this);
    
    sendstring = "";
    jump = 0;
  }
  
  private void jump()
  {
    if(jump < 2){
      Vec2 v = body.getLinearVelocity();
      body.setLinearVelocity(new Vec2(v.x, 14.0f));
      jump++;
    }
  }
  
  public void jumpreset()
  {
    jump = 0;
  }
  
  private void left()
  {
    Vec2 v = body.getLinearVelocity();
    body.setLinearVelocity(new Vec2(-10.0f, v.y));
  }
  
 private void right()
  {
    Vec2 v = body.getLinearVelocity();
    body.setLinearVelocity(new Vec2(10.0f, v.y));
  }
  
  private void stop()
  {
    Vec2 v = body.getLinearVelocity();
    body.setLinearVelocity(new Vec2(0.0f,v.y));
  }
  
  private void shoot()
  {
    weapons[weaponselect].shoot(box2d.getBodyPixelCoord(body),aim);
  }
  
  private void stopshoot()
  {
    weapons[weaponselect].resetshoot();
  }
  
  private void placemine()
  {
    mines.add(new mine(this));
  }
  
  Vec2 getPos(){
    return box2d.getBodyPixelCoord(body);
  }
  
  Vec2 getWorldPos(){
    return body.getPosition();
  }
  
  Vec2 getAim()
  {
    return aim;
  }
  
  void setAim(Vec2 aim)
  {
    this.aim = aim;
    weapons[weaponselect].setAim(aim);
  }
  
  void subHealth(float h)
  {
    health -= h;
  }
  
  float getHealth()
  {
    return health;
  }
  
  boolean isAlive()
  {
    return (health>0);
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  
  team getTeam()
  {
    return t;
  }
  
  void setLastBulletPlayer(player p)
  {
    lastbulletplayer = p;
  }
  
  player getLastBulletPlayer()
  {
    return lastbulletplayer;
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    //float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
   // rotate(-a);              // translate and rotate the rectangle
    fill(t.getColor());
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    if(healthbar)
    {
      fill(map(health,0,1,0,255),0,0);
      rect(0,-20,health*20,5);
    }
    weapons[weaponselect].display();
    popMatrix();
  }
}
