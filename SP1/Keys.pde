class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;

  public Keys() {}

  public boolean wDown()
  {
    return wDown;
  }

  public boolean aDown()
  {
    return aDown;
  }

  public boolean sDown()
  {
    return sDown;
  }

  public boolean dDown()
  {
    return dDown;
  }


  //player one
  void onKeyPressed(char ch)
  {
    if (ch == 'W' || ch == 'w')
    {
      wDown = true;
    } else if (ch == 'A' || ch == 'a')
    {
      aDown = true;
    } else if (ch == 'S' || ch == 's')
    {
      sDown = true;
    } else if (ch == 'D' || ch == 'd')
    {
      dDown = true;
    }
  }


  void onKeyReleased(char ch)
  {
    if (ch == 'W' || ch == 'w')
    {
      wDown = false;
    } else if (ch == 'A' || ch == 'a')
    {
      aDown = false;
    } else if (ch == 'S' || ch == 's')
    {
      sDown = false;
    } else if (ch == 'D' || ch == 'd')
    {
      dDown = false;
    }
  }
}


class KeysTwo 
{

  private boolean iDown = false;
  private boolean jDown = false;
  private boolean kDown = false;
  private boolean lDown = false;

  //player two keys
  public KeysTwo(){}

  public boolean iDown()
  {
    return iDown;
  }

  public boolean jDown()
  {
    return jDown;
  }

  public boolean kDown()
  {
    return kDown;
  }

  public boolean lDown()
  {
    return lDown;
  }


  void playerTwoKeyPressed()
  {
    if(key==CODED){
    if (keyCode == UP)
    {
      iDown = true;
    } else if (keyCode == LEFT)
    {
      jDown = true;
    } else if (keyCode == DOWN)
    {
      kDown = true;
    } else if (keyCode == RIGHT)
    {
      lDown = true;
    }
    }
  }

  void playerTwoKeyReleased()
  {
    if(key==CODED){
   if (keyCode == UP)
    {
      iDown = false;
    } else if (keyCode == LEFT)
    {
      jDown = false;
    } else if (keyCode == DOWN)
    {
      kDown = false;
    } else if (keyCode == RIGHT)
    {
      lDown = false;
    }
    }
  }
}
