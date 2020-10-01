import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private KeysTwo keysPlayerTwo;
  private int playerLife;
  private int playerTwoLife;
  private Dot player;
  private Dot playerTwo;
  private Dot[] enemies;
  private Dot food;


  Game(int width, int height, int numberOfEnemies)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    keysPlayerTwo = new KeysTwo();
    player = new Dot(0, 0, width-1, height-1);
    playerTwo = new Dot(0, 15, width-1, height-1);
    food = new Dot(10, 15, width-1, height-1);
    
    
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
    this.playerTwoLife = 100;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }
  public int getPlayerTwoLife()
  {
    return playerTwoLife;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void playerTwoKeyPressed() {
    keysPlayerTwo.playerTwoKeyPressed();
  }

  public void playerTwoKeyReleased() {
    keysPlayerTwo.playerTwoKeyReleased();
  }
  public void update()
  {
    updatePlayer();
    updatePlayerTwo();
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }
  //PlayerOneMove
  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }
  //playerTwoMove
  private void updatePlayerTwo()
  {
    //update playerTwo
    if (keysPlayerTwo.iDown() && !keysPlayerTwo.kDown())
    {
      playerTwo.moveUp();
    }
    if (keysPlayerTwo.jDown() && !keysPlayerTwo.lDown())
    {
      playerTwo.moveLeft();
    }
    if (keysPlayerTwo.kDown() && !keysPlayerTwo.iDown())
    {
      playerTwo.moveDown();
    }
    if (keysPlayerTwo.lDown() && !keysPlayerTwo.jDown())
    {
      playerTwo.moveRight();
    }
  }
  //update food
  public void updateFood() {

    //Should we follow or move randomly?
    //1 out of 3 we will follow..
    if (rnd.nextInt(3) < 1)
    {
      //We follow
      int dx = player.getX() - food.getX();
      int dy = player.getY() - food.getY();
      int xX = playerTwo.getX() - food.getX();
      int yY = playerTwo.getY() - food.getY();
      if (abs(dx) > abs(dy) && abs(xX) > abs(yY)) 
      {
        if (dx < 0 && xX < 0) // will try to catch both players, but will attack the nearest
        {
          //Player is to the right
          food.moveRight();
        } else
        {
          //Player is to the left
          food.moveLeft();
        }
      } else if (dy < 0 && yY < 0)
      {
        //Player is down;
        food.moveDown();
      } else
      {//Player is up;
        food.moveUp();
      }
    } else
    {
      //We move randomly
      int move = rnd.nextInt(4);
      if (move == 0)
      {
        //Move right
        food.moveRight();
      } else if (move == 1)
      {
        //Move left
        food.moveLeft();
      } else if (move == 2)
      {
        //Move up
        food.moveUp();
      } else if (move == 3)
      {
        //Move down
        food.moveDown();
      }
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int Xx = playerTwo.getX() - enemies[i].getX();
        int Yy = playerTwo.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy) && abs(Xx) > abs(Yy))
        {
          if (dx > 0 || Xx > 0) // will try to catch both players, but will attack the nearest
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0 || Yy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert player2
    board[playerTwo.getX()][playerTwo.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //update food
    board[food.getX()][food.getY()] = 5;
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
      }//
      if (enemies[i].getX() == playerTwo.getX() && enemies[i].getY() == playerTwo.getY())
      {
        //We have a collision
        --playerTwoLife;
      }
    }
    //check food collision
    for (int i = 0; i < enemies.length; i++) {
      if (player.getX() == food.getX() && player.getY() == food.getY()) {
        if (game.getPlayerLife()  < 100 ) {
          getHealed();
          food = new Dot((int)random(0, 10), (int)random(0, 15), width-1, height-1);
        }
      }
      if (playerTwo.getX() == food.getX() && playerTwo.getY() == food.getY()) {
        if (game.getPlayerTwoLife() < 100 ) {
          getHealedTwo();
          food = new Dot((int)random(0, 10), (int)random(0, 15), width-1, height-1);
        }
      }
    }
  }
}
public void getHealed() {
  game.playerLife = Math.min(game.playerLife + 10, 100);
}

public void getHealedTwo() {
  game.playerTwoLife = Math.min(game.playerTwoLife + 10, 100);
}
