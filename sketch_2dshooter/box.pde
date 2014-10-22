class box
{
  Body body;
  
  float w,h;
  String sendstring;
  
  box(float x, float y, float w,float h)
  {
    this.w = w;
    this.h = h;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);


    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2); 
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.1;
              
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();
    sendstring = "|"+(int)pos.x+"|"+(int)pos.y+"|";
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  String getSendString()
  {
    return sendstring;
  }
}
