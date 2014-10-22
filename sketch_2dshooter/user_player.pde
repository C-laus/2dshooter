class user_player extends player
{
  user_player(Vec2 span,team t)
  {
    super(span,t);
  }
  void keyPressed(char key)
  {
  if(key == 'w')
    super.jump();
  if(key == 'a')
    super.left();
  if(key == 'd')
    super.right();
  if(key == 'e')
    super.placemine();
  if(key == ' ')
    super.shoot();
  }
  
  void keyReleased(char key)
  {
  if(key =='a' || key == 'd')
    super.stop();
  if(key ==' ')
    super.stopshoot();
  }
  
  void mousePressed()
  {
    super.shoot();
  }
  
  void mouseReleased()
  {
    super.stopshoot();
  }
  
}
