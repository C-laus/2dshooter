class team
{
  color c;
  String name;
  int scoor;
  team(color c,String name)
  {
    this.c = c;
    this.name = name;
    scoor = 0;
  }
  
  void setColor(color c)
  {
    this.c = c;
  }
  
  color getColor()
  {
    return c;
  }
  
  void addScoor(int s)
  {
    scoor += s;
  }
  
  int getScoor()
  {
    return scoor;
  }
  
  String getName()
  {
    return name;
  }
}
