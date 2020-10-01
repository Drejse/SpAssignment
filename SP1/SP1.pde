/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */

import java.util.Random;

Game game = new Game(25, 25, 5);
PFont font;
boolean gameOver = false;

public void settings() {
  size(1001, 1001);
}

void setup()
{
  frameRate(10);
  font = createFont("Arial", 16, true);
  textFont(font, 16);
}


void keyPressed()
{
  game.onKeyPressed(key);
  game.playerTwoKeyPressed();
}
void keyReleased()
{
  game.onKeyReleased(key);
  game.playerTwoKeyReleased();
}



void draw()
{
  if (gameOver == false) {
    game.update();
    background(0); //Black
    // This embedded loop skips over values in the arrays based on
    // the spacer variable, so there are more values in the array
    // than are drawn here. Change the value of the spacer variable
    // to change the density of the points
    int[][] board = game.getBoard();
    for (int y = 0; y < game.getHeight(); y++)
    {
      for (int x = 0; x < game.getWidth(); x++)
      {
        if (board[x][y] == 0)// board
        {
          fill(0, 0, 0);
        } else if (board[x][y] == 1) //player1
        {
          fill(0, 0, 255);//blue
        } else if (board[x][y] == 2) // enemies
        {
          fill(255, 0, 0);//red
        } else if (board[x][y] == 3)//playerTwo board update
        {
          fill(0, 255, 0);//green
        }//playerTwo
        else if (board[x][y] == 4)
        {
          fill(149, 149, 0);//weird yellow
        } else if (board[x][y] == 5)//food board update
        {
          fill(0, 200, 0);//darker green
        }
        stroke(100, 100, 100);
        rect(x*40, y*40, 40, 40);
      }
    }
    fill(255);
    text("Player 1 Lifes: "+game.getPlayerLife(), 25, 25);
    text("Player 2 Lifes: "+game.getPlayerTwoLife(), 50, 50);
    if (game.getPlayerLife() < 0) {
      gameOver = true;
      textSize(40);
      textAlign(CENTER);
      text("GAME OVER. PLAYER 2 WON! \n Thank you for playing", width/2, height/2);
    } else if (game.getPlayerTwoLife() < 0) {
      gameOver = true;
      textSize(40);
      textAlign(CENTER);
      text("GAME OVER. PLAYER 1 WON! \n Thank you for playing", width/2, height/2);
    }
    
      if(gameOver == true && keyPressed&&key==' ') {
        gameOver = false;
        draw();
      }
    }
  }
