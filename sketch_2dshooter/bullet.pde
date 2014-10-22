class bullet
{
  float w,h;
  Body body;
  int lifespan;
  Vec2 force;
  float maxspeed;
  player p;
  
  bullet(Vec2 location,Vec2 force,float maxspeed,int lifespan,player p)
  {
    this.w = 2;
    this.h = 2;
    this.force = force;
    this.maxspeed = maxspeed;
    this.lifespan = lifespan;
    this.p = p;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.bullet = true;
    bd.position.set(box2d.coordPixelsToWorld(location.x,location.y));
    body = box2d.createBody(bd);

   // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2); 
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
             
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();
    Vec2 vel = body.getLinearVelocity();
    //if(vel.length() < maxspeed)
    //  body.applyForce(force,body.getWorldCenter());
    body.setLinearVelocity(force);  
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
    lifespan--;
  }
  
  Vec2 getPos()
  {
    return body.getPosition();
  }
  
  void setLifespan(int lifespan)
  {
    this.lifespan = lifespan;
  }
  
  boolean isalive()
  {
    return lifespan>0;
  }
  
  player getPlayer()
  {
    return p;
  }
    
  void killBody() {
    box2d.destroyBody(body);
  }
}
