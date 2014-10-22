class bridge
{
  bridge_fixture bf1;
  bridge_fixture bf2;
  ArrayList<bridge_particle> particles;
  float jointlen;
  
  bridge(Vec2 fixture1,Vec2 fixture2,float totallen,int jointcount)
  {
    particles = new ArrayList<bridge_particle>();
    bf1 = new bridge_fixture(fixture1);
    bf2 = new bridge_fixture(fixture2);
    jointlen = totallen/jointcount;
    
    DistanceJointDef djd = new DistanceJointDef();
    djd.length = box2d.scalarPixelsToWorld(jointlen);
    djd.frequencyHz = 0;
    djd.dampingRatio = 0;
    
    Body last = bf1.body;
    for(int i = 0;i < jointcount-1;i++)
    {
      bridge_particle p = new bridge_particle(new Vec2(fixture1.x+(i*jointlen),fixture1.y));
      particles.add(p);
      djd.bodyA = last;
      djd.bodyB = p.body;
      DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
      last = p.body;
    }
    djd.bodyA = last;
    djd.bodyB = bf2.body;
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
  }
  
  void display(){
    
    bf1.display();
    bf2.display();
    for(bridge_particle bp:particles)
    {
      bp.display();
    }
  }
}

class bridge_particle
{
  Body body;
  float r;
  bridge_particle(Vec2 pos)
  {
    this.r = 10;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    
    bd.position = box2d.coordPixelsToWorld(pos.x,pos.y);
    body = box2d.world.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
    body.setUserData(this);
  }
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    pushMatrix();
    translate(pos.x,pos.y);
    fill(142,78,9);
    stroke(1);
    ellipse(0,0,r,r);
    popMatrix();
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
}

class bridge_fixture extends box
{
  bridge_fixture(Vec2 pos)
  {
    super(pos.x,pos.y,5,5);
  }
}
