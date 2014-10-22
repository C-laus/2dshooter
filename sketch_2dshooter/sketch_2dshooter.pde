import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;
import java.io.File;
import java.io.*;

public ArrayList<player> players;
public ArrayList<box> boxes;
public ArrayList<bullet> bullets;
public ArrayList<bridge> bridges;
public ArrayList<Vec2> spanpoints;
public ArrayList<team> teams;
public ArrayList<mine> mines;

public team nullteam;

Box2DProcessing box2d;

game game;

int w,h;
int followplayer = 0;

boolean console = false;
String command = "";





void setup()
{
  frameRate(40);
  size(displayWidth, displayHeight);
  frame.setResizable(true);

  boxes = new ArrayList<box>();
  bridges = new ArrayList<bridge>();
  bullets = new ArrayList<bullet>();
  players = new ArrayList<player>();
  spanpoints = new ArrayList<Vec2>();
  teams = new ArrayList<team>();
  mines = new ArrayList<mine>();

  box2d = new Box2DProcessing(this);
  //game = new game(0,"map.xml");
}

void draw()
{
  frame.setTitle(frameRate+"");
  background(#2F79DE);
  if(console)
  {
    textSize(32);
    fill(0);
    text(command, 10, 30);
  }
  if(game != null)
    game.display();
  int pointpos = 0;
  for(team t:teams)
  {
    textSize(16);
    fill(t.getColor());
    text(t.getName()+":"+t.getScoor(), width*10/11, 30 + 20 * pointpos);
    //println(t.getName()+":"+t.getScoor());
    pointpos++;
  }
}

boolean sketchFullScreen() {
  return false;
}
