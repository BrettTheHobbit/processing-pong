

/* //<>// //<>// //<>//
 Brett Hobbs
 Assignment 3 - Pong
 ICS 3U1
 A simple game of pong, bounce ball left and right for 20 mins of fun at max.
 */
// WHENEVER A NEW VALUE IS ADDED, ADD THAT VAR. TO THE REFRESH VALUES FUNCTION!!!!
boolean maniaMode = false;
int speedUpBall;
int aiContPlayers = 0;// how many AI there are
int scoreOne = 0;// debugging purposes only : change later
int scoreTwo = 0;
int scoreThree = 0;
int scoreFour = 0;
int multiplierSpeedX = round(random(1, 4)); 
int multiplierSpeedY = round(random(1, 4)); 
int gameState = 0;// allows for switching screens
float xOne = 0;// x and y for four paddles
float yOne = 0;
float yTwo = 0;
float xTwo = 0;
float xThree = 0;
float yThree = 0;
float xFour = 0;
float yFour = 0;
float ballX = 250;
float ballY = 250;
float ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
float ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
float ballW = 50;
float ballH = 50;// it stands for Ball Size, I promise.
boolean TopLeft = false;//movement checks for muliple players
boolean TopRight = false;
boolean BottomLeft = false;
boolean BottomRight = false;
boolean leftUp = false;
boolean leftDown = false;
boolean rightUp = false;
boolean rightDown = false;
int speedONE = 5;// movement speed
int speedTWO = 5;
int speedTHREE = 5;
int speedFOUR = 5;
boolean startMovement = false;// allows some time for you to relax before starting pong
int pongPlayers = 2;// how many peeps playin'
String lastPaddle;
boolean detectOnce = false;
int scoreLimit = 5;
pongPaddle firstPong;// instances Pong class
pongPaddle secondPong;
pongPaddle thirdPong;
pongPaddle fourthPong;
pongBall singularBall;//instance of ball class
pongBall startingBall;
pongBall extraBallOne;
pongBall extraBallTwo;
pongBall extraBallThree;
pongBall extraBallFour;
pongBall extraBallFive;

void setup() {
  size(500, 500);
  surface.setResizable(true);// allows parameraterizing
  rectMode(CORNERS);
  ellipseMode(CENTER);
  refreshValues();
}

void draw() {
  if (gameState == 0) {// Intro Screen
    background(0);
    if (keyCode == 66) {
      startingBall = new pongBall(ballX*width/500, ballY*height/500, ballW*width/500, ballH*width/500, ballSpeedX, ballSpeedY);// if you press space, a fun ball should spawn
      startingBall.drawPong();
      ballX = width/2;
      ballY = height/2;
      ballSpeedX += random(-5, 5);
      ballSpeedY += random(-5, 5);
      ballX += ballSpeedX;
      ballY += ballSpeedY;
      if (ballX*width/500 > width) {// stops the ball from going away so you have a nice visual
        multiplierSpeedX = round(random(3, 4)); 
        multiplierSpeedY = round(random(1, 4));
        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);//speeds up over time.
        // change angles
      }

      if (ballY*width/500 > height) {
        multiplierSpeedX = round(random(1, 4)); 
        multiplierSpeedY = round(random(3, 4));
        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
      }

      if (ballX < 0) {
        multiplierSpeedX = round(random(1, 2)); 
        multiplierSpeedY = round(random(1, 4));
        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
      }

      if (ballY < 0) {
        multiplierSpeedX = round(random(1, 4));
        multiplierSpeedY = round(random(1, 2));
        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
      }
    }
    fill(255, 0, 0);
    textSize(50*width/500+50*height/500);
    text("PONG", 2*width/5-0.93*width/5, 2*height/6);
    fill(255, 40, 40);
    text("PONG", 2*width/5-0.90*width/5, 2*height/6);
    fill(0);
    stroke(255, 0, 0);
    rect(2*width/5, 2.5*height/6, 2*width/5+1*width/5, 3*height/6);//play button
    rect(2*width/5, 3.5*height/6, 2*width/5+1*width/5, 4*height/6);// instructions
    rect(2*width/5, 4.5*height/6, 2*width/5+1*width/5, 5*height/6);//player settings

    if (mouseX > 2*width/5 && mouseX < 2*width/5+1*width/5) {// mouse detection within click boxes (rectangles if you prefer to call them those)
      if (mouseY > 2.5*height/6 && mouseY < 3*height/6) {// play button detection
        fill(255, 0, 0);
        textSize(12.5*width/500+12.5*height/500);
        text("PLAY", 2*width/5+0.05*width/2, 2.85*height/6+4*width/500);
        fill(255, 40, 40);
        text("PLAY", 2*width/5+0.059*width/2, 2.85*height/6+4*width/500);
        if (mousePressed) {
          refreshValues();
          gameState = 1;
        }
      }
      if (mouseY > 3.5*height/6 && mouseY < 4*height/6) {// instruct. button detection
        fill(255, 0, 0);
        textSize(6.5*width/500+6.5*height/500);
        text("INSTRUCTIONS", 2*width/5+0.01*width/2, 3.85*height/6+width/500);
        fill(255, 40, 40);
        text("INSTRUCTIONS", 2*width/5+0.015*width/2, 3.85*height/6+width/500);
        if (mousePressed) {
          gameState = 2;
        }
      }
      if (mouseY > 4.5*height/6 && mouseY < 5*height/6) {// settings button detection
        fill(255, 0, 0);
        textSize(10*width/500+10*height/500);
        text("SETTINGS", 2*width/5+0.01*width/2, 4.85*height/6+width/500);
        fill(255, 40, 40);
        text("SETTINGS", 2*width/5+0.015*width/2, 4.85*height/6+width/500);
        if (mousePressed) {
          gameState = 3;
        }
      }
    }
  } else if (gameState == 1) {// the game!
    background(0);
    xOne += speedONE;// moves the first paddle
    xTwo += speedTWO;// moes the second paddle
    yThree += speedTHREE;
    yFour += speedFOUR;

    if (TopLeft) {// interprets the boolean switchs in keyPressed/Released and picks how fast paddle will move

      speedONE = +5; //moves left
    } else if (TopRight) {

      speedONE = -5;  // moves right
    } else {// doesnt move paddle one

      speedONE = 0;
    }

    if (BottomLeft) {

      speedTWO = -5;// moves left
    } else if (BottomRight) {

      speedTWO = 5;// moves right
    } else {

      speedTWO = 0;// stops movement for paddle 2
    }

    if (leftUp) {
      speedTHREE = -5;
    } else if (leftDown) {
      speedTHREE = 5;
    } else {
      speedTHREE = 0;
    }

    if (rightUp) {
      speedFOUR = -5;
    } else if (rightDown) {
      speedFOUR = 5;
    } else {
      speedFOUR = 0;
    }
    if (ballX*width/500 > width && pongPlayers < 3) {


      multiplierSpeedX = round(random(3, 4)); 

      ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);


      // change angles
    } else if (ballX*width/500 < width && pongPlayers < 3){
      addScore();
      refreshValues();
    }

    if (ballY*height/500 > height) {

      addScore();
      refreshValues();
    }
    if (ballX < 0 && pongPlayers != 4) {

      multiplierSpeedX = round(random(1, 2)); 

      ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
    } else if (ballX < 0 && pongPlayers == 4){
     addScore();
     refreshValues();
    }
    if (ballY < 0) {

      addScore();
      refreshValues();
    }

    //hit detection ball --> paddle:

    if ( ballY + ballH/2 >= (4.25*height/5)*height/500 && ballX + ballW/2 >= 2*width/5+xTwo*width/500 && ballX +ballW/2 <= 2*width/5+1*width/5+xTwo*width/500 && detectOnce == false ) {// first paddle ball collision
      lastPaddle = "Green2";

      multiplierSpeedY = round(random(3, 4));

      ballSpeedY = random(2, 5);
      detectOnce = true;
    } else if ( ballY + ballH/2 <= yOne+height/5+height/10 && ballX + ballW/2 >= 2*width/5+xOne*width/500 && ballX +ballW/2 <= 2*width/5+1*width/5+xOne*width/500 && detectOnce == false ) {// first paddle ball collision
      lastPaddle = "Red1";

      multiplierSpeedY = round(random(1, 2));

      ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
      detectOnce = true;
    } else if (pongPlayers >= 3 &&  ballX + ballW/2 <= xThree+width/5+width/10 && ballY + ballH/2 >= 2*height/5+yThree*height/500 && ballY +ballH/2 <= 2*height/5+1*height/5+yThree*height/500 && detectOnce == false) {
      lastPaddle = "Orange3";

      multiplierSpeedX = round(random(1, 2));

      ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
      detectOnce = true;
    } else if (pongPlayers == 4 &&  ballX + ballW/2 >= xThree+width/5+width/10 && ballY + ballH/2 >= 2*height/5+yThree*height/500 && ballY +ballH/2 <= 2*height/5+1*height/5+yThree*height/500 && detectOnce == false) {
      lastPaddle = "Purple4";

      multiplierSpeedX = round(random(1, 2));

      ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
      detectOnce = true;
    } else {
      detectOnce = false;
    }



    if (scoreOne >= scoreLimit || scoreTwo >= scoreLimit || scoreThree >= scoreLimit || scoreFour >= scoreLimit) {// ends the game if score > a set limit
      gameState = 4;//endState
    }

    // speedMultiplier for x values
    /*
    if (multiplierSpeedX == 1) {
     ballSpeedX *= 1;
     } else if (multiplierSpeedX == 2) {
     ballSpeedX *= -1;
     }
     */
    if (startMovement) {
      if (multiplierSpeedX >= 3) {
        ballX -= ballSpeedX;
      } else {

        ballX += ballSpeedX;// moves the ball in random directions
      }
      if (multiplierSpeedY >= 3) {
        ballY -= ballSpeedY;
      } else {
        ballY += ballSpeedY;
      }
    }
    if (maniaMode) {
      float ballX1 = 100;// more x variables.... oh god why
      float ballX2 = 150;
      float ballX3 = 200;
      float ballX4 = 300;
      float ballX5 = 350;
      float ballY1 = 250;// now the y variables for each ball
      float ballY2 = 250;
      float ballY3 = 250;
      float ballY4 = 250;
      float ballY5 = 250;
      int multiplierSpeedX1 = round(random(1, 4)); // now some multiplier speeds
      int multiplierSpeedY1 = round(random(1, 4)); 
      int multiplierSpeedX2 = round(random(1, 4)); 
      int multiplierSpeedY2 = round(random(1, 4)); 
      int multiplierSpeedX3 = round(random(1, 4)); 
      int multiplierSpeedY3 = round(random(1, 4)); 
      int multiplierSpeedX4 = round(random(1, 4)); 
      int multiplierSpeedY4 = round(random(1, 4)); 
      int multiplierSpeedX5 = round(random(1, 4)); 
      int multiplierSpeedY5 = round(random(1, 4)); 
      extraBallOne = new pongBall(ballX1*width/500, ballY1*height/500, ballW*width/500, ballH*width/500, ballSpeedX, ballSpeedY);// and some instanciations
      extraBallTwo = new pongBall(ballX2*width/500, ballY2*height/500, ballW*width/500, ballH*width/500, ballSpeedX, ballSpeedY);
      extraBallThree = new pongBall(ballX3*width/500, ballY3*height/500, ballW*width/500, ballH*width/500, ballSpeedX, ballSpeedY);
      extraBallFour = new pongBall(ballX4*width/500, ballY4*height/500, ballW*width/500, ballH*width/500, ballSpeedX, ballSpeedY);
      extraBallFive = new pongBall(ballX5*width/500, ballY5*height/500, ballW*width/500, ballH*width/500, ballSpeedX, ballSpeedY);

      if (startMovement) {
        if (multiplierSpeedX1 >= 3) {
          ballX1 -= ballSpeedX;
        } else {

          ballX1 += ballSpeedX;// moves the ball in random directions (BALL 1)
        }
        if (multiplierSpeedY1 >= 3) {
          ballY1 -= ballSpeedY;
        } else {
          ballY1 += ballSpeedY;
        }


        if (multiplierSpeedX2 >= 3) {
          ballX2 -= ballSpeedX;
        } else {

          ballX2 += ballSpeedX;// moves the ball in random directions (BALL 2)
        }

        if (multiplierSpeedY2 >= 3) {
          ballY2 -= ballSpeedY;
        } else {
          ballY2 += ballSpeedY;
        }


        if (multiplierSpeedX3 >= 3) {
          ballX3 -= ballSpeedX;
        } else {

          ballX3 += ballSpeedX;// moves the ball in random directions (BALL 3)
        }
        if (multiplierSpeedY3 >= 3) {
          ballY3 -= ballSpeedY;
        } else {
          ballY3 += ballSpeedY;
        }


        if (multiplierSpeedX4 >= 3) {
          ballX4 -= ballSpeedX;
        } else {

          ballX4 += ballSpeedX;// moves the ball in random directions (BALL 4)
        }
        if (multiplierSpeedY4 >= 3) {
          ballY4 -= ballSpeedY;
        } else {
          ballY4 += ballSpeedY;
        }


        if (multiplierSpeedX5 >= 3) {
          ballX5 -= ballSpeedX;
        } else {

          ballX5 += ballSpeedX;// moves the ball in random directions (BALL 5)
        }
        if (multiplierSpeedY5 >= 3) {
          ballY5 -= ballSpeedY;
        } else {
          ballY5 += ballSpeedY;
        }
      }
      if (ballX1*width/500 > width) {


        multiplierSpeedX1 = round(random(3, 4)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);


        // change angles
      }

      if (ballY1*height/500 > height) {

        scoreOne++;
        refreshValues();
      }
      if (ballX1 < 0) {

        multiplierSpeedX1 = round(random(1, 2)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
      }
      if (ballY1 < 0) {

        scoreTwo++;
        refreshValues();
      }

      //hit detection ball --> paddle:

      if ( ballY1 + ballH/2 >= (4.25*height/5)*height/500 && ballX1 + ballW/2 >= 2*width/5+xTwo*width/500 && ballX1 +ballW/2 <= 2*width/5+1*width/5+xTwo*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Green2";

        multiplierSpeedY1 = round(random(3, 4));

        ballSpeedY = random(2, 5);
        detectOnce = true;
      } else if ( ballY1 + ballH/2 <= yOne+height/5+height/10 && ballX1 + ballW/2 >= 2*width/5+xOne*width/500 && ballX1 +ballW/2 <= 2*width/5+1*width/5+xOne*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Red1";

        multiplierSpeedY1 = round(random(1, 2));

        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
        detectOnce = true;
      } else {
        detectOnce = false;
      }
      // extra ball 2
      if (ballX2*width/500 > width) {


        multiplierSpeedX2 = round(random(3, 4)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);


        // change angles
      }

      if (ballY2*height/500 > height) {

        scoreOne++;
        refreshValues();
      }
      if (ballX2 < 0) {

        multiplierSpeedX2 = round(random(1, 2)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
      }
      if (ballY2 < 0) {

        scoreTwo++;
        refreshValues();
      }

      //hit detection ball --> paddle:

      if ( ballY2 + ballH/2 >= (4.25*height/5)*height/500 && ballX2 + ballW/2 >= 2*width/5+xTwo*width/500 && ballX2 +ballW/2 <= 2*width/5+1*width/5+xTwo*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Green2";

        multiplierSpeedY2 = round(random(3, 4));

        ballSpeedY = random(2, 5);
        detectOnce = true;
      } else if ( ballY2 + ballH/2 <= yOne+height/5+height/10 && ballX2 + ballW/2 >= 2*width/5+xOne*width/500 && ballX2 +ballW/2 <= 2*width/5+1*width/5+xOne*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Red1";

        multiplierSpeedY2 = round(random(1, 2));

        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
        detectOnce = true;
      } else {
        detectOnce = false;
      }
      //ball 3
      if (ballX3*width/500 > width) {


        multiplierSpeedX3 = round(random(3, 4)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);


        // change angles
      }

      if (ballY3*height/500 > height) {

        scoreOne++;
        refreshValues();
      }
      if (ballX3 < 0) {

        multiplierSpeedX3 = round(random(1, 2)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
      }
      if (ballY3 < 0) {

        scoreTwo++;
        refreshValues();
      }

      //hit detection ball --> paddle:

      if ( ballY3 + ballH/2 >= (4.25*height/5)*height/500 && ballX3 + ballW/2 >= 2*width/5+xTwo*width/500 && ballX3 +ballW/2 <= 2*width/5+1*width/5+xTwo*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Green2";

        multiplierSpeedY3 = round(random(3, 4));

        ballSpeedY = random(2, 5);
        detectOnce = true;
      } else if ( ballY3 + ballH/2 <= yOne+height/5+height/10 && ballX3 + ballW/2 >= 2*width/5+xOne*width/500 && ballX3 +ballW/2 <= 2*width/5+1*width/5+xOne*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Red1";

        multiplierSpeedY = round(random(1, 2));

        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
        detectOnce = true;
      } else {
        detectOnce = false;
      }
      //ball 4
      if (ballX4*width/500 > width) {


        multiplierSpeedX4 = round(random(3, 4)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);


        // change angles
      }

      if (ballY4*height/500 > height) {

        scoreOne++;
        refreshValues();
      }
      if (ballX4 < 0) {

        multiplierSpeedX4 = round(random(1, 2)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
      }
      if (ballY4 < 0) {

        scoreTwo++;
        refreshValues();
      }

      //hit detection ball --> paddle:

      if ( ballY4 + ballH/2 >= (4.25*height/5)*height/500 && ballX4 + ballW/2 >= 2*width/5+xTwo*width/500 && ballX4 +ballW/2 <= 2*width/5+1*width/5+xTwo*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Green2";

        multiplierSpeedY4 = round(random(3, 4));

        ballSpeedY = random(2, 5);
        detectOnce = true;
      } else if ( ballY4 + ballH/2 <= yOne+height/5+height/10 && ballX4 + ballW/2 >= 2*width/5+xOne*width/500 && ballX4 +ballW/2 <= 2*width/5+1*width/5+xOne*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Red1";

        multiplierSpeedY4 = round(random(1, 2));

        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
        detectOnce = true;
      } else {
        detectOnce = false;
      }
      //ball 5
      if (ballX5*width/500 > width) {


        multiplierSpeedX5 = round(random(3, 4)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);


        // change angles
      }

      if (ballY5*height/500 > height) {

        scoreOne++;
        refreshValues();
      }
      if (ballX5 < 0) {

        multiplierSpeedX5 = round(random(1, 2)); 

        ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
      }
      if (ballY5 < 0) {

        scoreTwo++;
        refreshValues();
      }

      //hit detection ball --> paddle:

      if ( ballY5 + ballH/2 >= (4.25*height/5)*height/500 && ballX + ballW/2 >= 2*width/5+xTwo*width/500 && ballX +ballW/2 <= 2*width/5+1*width/5+xTwo*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Green2";

        multiplierSpeedY5 = round(random(3, 4));

        ballSpeedY = random(2, 5);
        detectOnce = true;
      } else if ( ballY5 + ballH/2 <= yOne+height/5+height/10 && ballX5 + ballW/2 >= 2*width/5+xOne*width/500 && ballX5 +ballW/2 <= 2*width/5+1*width/5+xOne*width/500 && detectOnce == false ) {// first paddle ball collision
        lastPaddle = "Red1";

        multiplierSpeedY5 = round(random(1, 2));

        ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
        detectOnce = true;
      } else {
        detectOnce = false;
      }

      extraBallOne.drawPong();
      extraBallTwo.drawPong();
      extraBallThree.drawPong();
      extraBallFour.drawPong();
      extraBallFive.drawPong();
    }

    println(multiplierSpeedX);
    //speedMultiplier for y values

    println(height);
    println(multiplierSpeedY);

    firstPong = new pongPaddle(2*width/5+xOne*width/500, height/5, 2*width/5+1*width/5+xOne*width/500, height/10, 255, 0, 0, "Red1");// all of the width and height mumbo jumbo allow for fair play when windows are minimized and maximized
    secondPong = new pongPaddle(2*width/5+xTwo*width/500, 4.5*height/5, 2*width/5+1*width/5+xTwo*width/500, 8*height/10, 0, 255, 0, "Green2");
    if (pongPlayers >= 3) {
     thirdPong = new pongPaddle(4.5*height/5, 2*width/5+yThree*width/500, 8*height/10, 2*width/5+1*width/5+yThree*width/500, 255,183,0,"Orange3");
     thirdPong.drawPaddle();
     fill(255, 183, 0);
    text(scoreThree, 425*width/500, 50*height/500);
    fill(255, 183, 40);
    text(scoreThree, 427*width/500, 50*height/500);
    }
    if (pongPlayers == 4) {
     fourthPong = new pongPaddle(height/5, 2*width/5+yFour*width/500, height/10, 2*width/5+1*width/5+yFour*width/500, 255,0,255,"Purple4"); 
     fourthPong.drawPaddle();
     fill(255, 0, 255);
    text(scoreFour, 25*width/500, 450*height/500);
    fill(255, 40, 255);
    text(scoreFour, 27*width/500, 450*height/500);
    }
    singularBall = new pongBall(ballX*width/500, ballY*height/500, ballW*width/500, ballH*width/500, ballSpeedX, ballSpeedY);
    aiControlledPaddle();
    textSize(15*width/500+15*height/500);//drawing the score
    fill(255, 0, 0);
    text(scoreOne, 25*width/500, 50*height/500);
    fill(255, 40, 40);
    text(scoreOne, 27*width/500, 50*height/500);
    fill(0, 255, 0);
    text(scoreTwo, 425*width/500, 450*height/500);
    fill(40, 255, 40);
    text(scoreTwo, 427*width/500, 450*height/500);
    firstPong.drawPaddle();//top
    secondPong.drawPaddle(); //bottom
    singularBall.drawPong();//the ball


    //firstPong.detectCollision(ballX,ballY,2*width/5+xOne*width/500,height/5);
    // secondPong.detectCollision(ballX,ballY,2*width/5+xOne*width/500,4.5*height/5);
  } else if (gameState == 2) {// instructions
    background(0);
    textSize(25*width/500+25*height/500);
    fill(0, 0, 255);
    text("HOW TO PLAY!", 0.75*width/5-0.9*width/500, 50*height/500);
    fill(40, 40, 255);
    text("HOW TO PLAY!", 0.75*width/5+width/500, 50*height/500);
    textSize(15*width/500+15*height/500);
    fill(0, 0, 255);
    text("     Use A+S, F+G,\n K+L and Arrow Keys\n    in order to move\n        your paddle.\n\n    Use your paddle\n to deflect them balls.\nPress [SPACE] to continue!", 0.95*width/5-0.9*width/500, 100*height/500);
    fill(40, 40, 255);
    text("     Use A+S, F+G,\n K+L and Arrow Keys\n    in order to move\n        your paddle.\n\n    Use your paddle\n to deflect them balls.\nPress [SPACE] to continue!", 0.95*width/5+width/500, 100*height/500);
    if (keyCode == 32) {
      refreshValues();//only needed for the secret in the menu
      gameState = 0;
    }
  } else if (gameState == 3) {// settings
    background(0);
    textSize(25*width/500+25*height/500);
    fill(0, 255, 0);
    text("SETTINGS", 135*width/500, 100*height/500);//title
    text("AI", 335*width/500, 190*height/500);
    textSize(10*width/500+10*height/500);
    text("PRESS [SPACE] TO CONTINUE", 136*width/500, 400*height/500);
    noStroke();
    textSize(25*width/500+25*height/500);
    fill(60, 255, 60);
    text("SETTINGS", 136*width/500, 100*height/500);//title offset
    text("AI", 336*width/500, 190*height/500);
    textSize(10*width/500+10*height/500);
    text("PRESS [SPACE] TO CONTINUE", 136*width/500, 400*height/500);
    rect(300*width/500, 200*height/500, 350*width/500, 250*height/500);//AI boxes
    rect(400*width/500, 200*height/500, 450*width/500, 250*height/500);
    rect(300*width/500, 300*height/500, 350*width/500, 350*height/500);
    rect(400*width/500, 300*height/500, 450*width/500, 350*height/500);
    fill(0);
    text("0", 310*width/500, 245*height/500);
    text("1", 410*width/500, 245*height/500);
    text("2", 310*width/500, 345*height/500);
    text("3", 410*width/500, 345*height/500);
    // players
    fill(0,255,0);
    rect(50*width/500, 150*height/500, 100*width/500, 200*height/500);
    rect(150*width/500, 150*height/500, 200*width/500, 200*height/500);
    rect(250*width/500, 150*height/500, 300*width/500, 200*height/500);
    fill(0);
    textSize(5*width/500+5*height/500);
    text("2\n Players", 60*width/500, 175*height/500);
    text("3\n Players", 160*width/500, 175*height/500);
    text("4\n Players", 260*width/500, 175*height/500);
    textSize(10*width/500+10*height/500);
    if (mouseX > 50*width/500 && mouseX < 100*width/500 && mouseY > 150*height/500 && mouseY < 200*height/500 && mousePressed) {// 2 players (pongPlayers)
      pongPlayers = 2;
      println(pongPlayers);
    }
    if (mouseX > 150*width/500 && mouseX < 200*width/500 && mouseY > 150*height/500 && mouseY < 200*height/500 && mousePressed) {// 3 players (pongPlayers)
      pongPlayers = 3;
      println(pongPlayers);
    }
    if (mouseX > 250*width/500 && mouseX < 300*width/500 && mouseY > 150*height/500 && mouseY < 200*height/500 && mousePressed) {// 4 players (pongPlayers)
      pongPlayers = 4;
      println(pongPlayers);
    }
    if (keyCode == 32) {
      gameState = 0;
    }
    if (mousePressed) {
      if (mouseX > 300*width/500 && mouseX < 350*width/500 && mouseY < 250*height/500 && mouseY > 200*height/500 || aiContPlayers == 0) {//0 collision box 
        fill(255);
        text("0", 310*width/500, 245*height/500);
        aiContPlayers = 0;
      } 
      if (mouseX > 400*width/500 && mouseX < 450*width/500 && mouseY > 200*height/500 && mouseY < 250*height/500 || aiContPlayers == 1) {
        fill(255);
        text("1", 410*width/500, 245*height/500);
        aiContPlayers = 1;
      } 
      if (mouseX > 300*width/500 && mouseX < 350*width/500 &&  mouseY > 300*height/500 && mouseY < 350*height/500 || aiContPlayers == 2) {
        fill(255);
        text("2", 310*width/500, 345*height/500);
        aiContPlayers = 2;
      } 
      if (mouseX > 400*width/500 && mouseX < 450*width/500 && mouseY > 300*height/500 && mouseY < 350*height/500 || aiContPlayers == 3) {
        fill(255);
        text("3", 410*width/500, 345*height/500);
        aiContPlayers = 3;
      }
    }
    println(aiContPlayers);


    if ( mouseX > 100*width/500 && mouseX < 100*width/500+200*width/500 && mouseY > 250*height/500 && mouseY < 250*height/500 + 100*height/500 ) {
      fill(60, 255, 60);
      rect(100*width/500, 250*height/500, 200*width/500, 350*height/500);
      textSize(10*width/500+10*height/500);
      fill(0);
      if (mousePressed) {
        if (maniaMode == false) {
          fill(255, 0, 0);
          maniaMode = true;
        } else if (maniaMode) {
          fill(255);
          maniaMode = false;
        }
      }
      if (maniaMode) {
        fill(255, 0, 0);
      }
      text("Mania\nMode", 120*width/500, 280*height/500);
    } else {
      fill(0, 255, 0);
      rect(100*width/500, 250*height/500, 200*width/500, 350*height/500);
    }
  } else if (gameState == 4) {// end of game
    background(0);
    textSize(12.5*width/500+12.5*height/500);// 12.5+12.5 = 25 which is the intended text size for a normal screen
    fill(200);
    text("        has won Pong!\n Press [R] to go back\n      to the main screen", 100*width/500, 300*height/500);
    fill(255);
    text("        has won Pong!\n Press [R] to go back\n      to the main screen", 101*width/500, 300*height/500);
    textSize(25*width/500+25*width/500);
    if (scoreOne >= scoreLimit) {//p1 wins
      fill(255, 0, 0);
      text("PLAYER ONE", 100*width/500, 200*height/500);// winning messages
      fill(255, 40, 40);
      text("PLAYER ONE", 101*width/500, 200*height/500);
    } else if (scoreTwo >= scoreLimit) {//p2 wins
      fill(0, 255, 0);
      text("PLAYER TWO", 100*width/500, 200*height/500);
      fill(40, 255, 40);
      text("PLAYER TWO", 101*width/500, 200*height/500);
    } else if (scoreThree >= scoreLimit) {// p3 wins
      fill(255, 183, 0);
      text("PLAYER THREE", 100*width/500, 200*height/500);
      fill(255, 183, 40);
      text("PLAYER THREE", 101*width/500, 200*height/500);
    } else if (scoreFour >= scoreLimit) {// p4 wins
      fill(0, 0, 255);
      text("PLAYER FOUR", 100*width/500, 200*height/500);
      fill(40, 40, 255);
      text("PLAYER FOUR", 101*width/500, 200*height/500);
    }
    if (keyPressed && key == 'r' || key == 'R') {
      scoreOne = 0;
      scoreTwo = 0;
      scoreThree = 0;
      scoreFour = 0;
      gameState = 0;
    }
  }
}



void keyPressed() {
  if (keyCode == 83) {// s key
    TopLeft = true;
  } 
  if (keyCode == 65) {// a key
    TopRight = true;
  }
  if (keyCode == 37) {// {- key
    BottomLeft = true;
  }
  if (keyCode == 39) {// --} key
    BottomRight = true;
  }
  if (keyCode == 70) {// F key
    leftUp = true;
  }
  if (keyCode == 71) {// G key
    leftDown = true;
  }
  if (keyCode == 75) {// J key
    rightUp = true;
  }
  if (keyCode == 76) {// K key
    rightDown = true;
  }
  if (keyCode == 32) {
    startMovement = true;
  }// SPACE key
}

void keyReleased() {
  if (keyCode == 83) {// s key
    TopLeft = false;
  } 
  if (keyCode == 65) {// a key
    TopRight = false;
  }
  if (keyCode == 37) {// {- key
    BottomLeft = false;
  }
  if (keyCode == 39) {// --} key
    BottomRight = false;
  }
  if (keyCode == 70) {// F key
    leftUp = false;
  }
  if (keyCode == 71) {// G key
    leftDown = false;
  }
  if (keyCode == 75) {// J key
    rightUp = false;
  }
  if (keyCode == 76) {// K key
    rightDown = false;
  }
}

void addScore() {
 if (lastPaddle == "Red1") {
  scoreOne++; 
 } else if (lastPaddle == "Green2") {
  scoreTwo++; 
 } else if (lastPaddle == "Orange3") {
  scoreThree++; 
 } else if (lastPaddle == "Purple4") {
  scoreFour++; 
 } else {
  refreshValues(); 
 }
}

void aiControlledPaddle() {
  if (aiContPlayers == 1) {//one AI paddle
    xOne = ballX -250;
    // next paddle
  } else if (aiContPlayers == 2) {// two AI paddle
    xOne = ballX -250;
    yThree = ballY -250;
  } else if (aiContPlayers == 3) {// three AI paddle
    xOne = ballX -250;
    yThree = ballY -250;
    yFour = ballY -250;
  }
}

void refreshValues() {
  multiplierSpeedX = round(random(1, 4)); 
  multiplierSpeedY = round(random(1, 4)); 
  ballX = 250;
  ballY = 250;
  ballSpeedX = random(2 + speedUpBall, 5 + speedUpBall);
  ballSpeedY = random(2 + speedUpBall, 5 + speedUpBall);
  ballW = 50;
  ballH = 50;// it stands for Ball Size, I promise.
  TopLeft = false;//movement checks for muliple players
  TopRight = false;
  BottomLeft = false;
  BottomRight = false;
  speedONE = 5;// movement speed
  speedTWO = 5;
  startMovement = false;
  detectOnce = false;
  xOne = 0;
  yOne = 0;
  xTwo = 0;
  yTwo = 0;
  speedUpBall += 0.5;// causes slight progression within the game






  /*  println(ballSpeedX);
   if (floor(multiplierSpeedX) == 3 || floor(multiplierSpeedX) == 4){
   ballSpeedX *= -1;
   }
   println(ballSpeedX);*/
}
