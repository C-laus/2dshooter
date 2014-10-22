class mine
{
  
  Body body;
  player p;
  float w,h;
  int explode = 10;
  int lifetime = 100;
  
  mine(player p)
  {
    this.p = p;
    w = 4;
    h = 4;
    
    BodyDef bd = new BodyDef();
    bd.position.set(p.getWorldPos());
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
    fd.friction = 1;
    fd.restitution = 0.1;
            
    body.createFixture(fd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = 2.0;
    
    fd = new FixtureDef();
    fd.shape = cs;
    fd.isSensor = true;
    
    body.createFixture(fd);
    
    body.setUserData(this);
  }
  
  boolean isAlive()
  {
    return lifetime > (0 - explode);
  }
  
  void killBody() {
    println("Kill Mine");
    box2d.destroyBody(body);
  }
  
  void display() {
    lifetime--;
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(lifetime <= 0)
    {
      for(int i = 0;i <= 10; i++)
      {
        pos.addLocal(new Vec2(0,2.5)); //<>//
        Vec2 velocityvec = new Vec2(random(-1,1),random(0,1));
        velocityvec.normalize();
        velocityvec.mulLocal(200);
        bullets.add(new bullet(pos,velocityvec,1000,100,p));  
      }
    }
    pos = box2d.getBodyPixelCoord(body);
    pushMatrix();          
    translate(pos.x,pos.y);
    fill(0,0,0);
    noStroke();
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
}
