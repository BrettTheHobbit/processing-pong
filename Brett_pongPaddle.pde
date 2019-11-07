public class pongPaddle {// Paddle class to recreate paddles depending on players
  float xPaddle;//paddle draw parameters
  float yPaddle;
  float wPaddle;
  float hPaddle;
  color paddleColourR;//paddle colours
  color paddleColourG;
  color paddleColourB;
  String lastTouched;
  public pongPaddle(float xPaddles, float yPaddles, float wPaddles, float hPaddles, color paddleColourRs, color paddleColourGs, color paddleColourBs, String touchedLast) {
    xPaddle = xPaddles;
    yPaddle = yPaddles;
    wPaddle = wPaddles;
    hPaddle = hPaddles;
    paddleColourR = paddleColourRs;
    paddleColourG = paddleColourGs;
    paddleColourB = paddleColourBs;
    lastTouched = touchedLast;
  }//constructor

  void drawPaddle() {// draws the paddle
    fill(0);
    stroke(paddleColourR, paddleColourG, paddleColourB);
    rect(xPaddle, yPaddle, wPaddle, hPaddle);//the physical paddle


    if (xOne*width/500 < 0 - 300*width/500) {// limits the first paddle from moving outside of the given space.

      xOne = width - 300*width/500;
    } else if (xOne*width/500 > width - 300*width/500 ) {
      xOne =  width -700*width/500;
    }

    if (xTwo < -width + 300*width/500) {// limits the second paddle from moving outside of its given space.
      xTwo = width - 300*width/500;
    } else if (xTwo*width/500 > width - 300*width/500) {
      xTwo = width -700*width/500;
    }
  }
}
