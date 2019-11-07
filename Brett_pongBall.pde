public class pongBall {
  float pongX;// pong x
  float pongY;// pong y
  float pongW;// pong size
  float pongH;
  float pongXSpeed;// x speed of the ball
  float pongYSpeed;
  pongBall(float xPong, float yPong, float wPong, float hPong, float xSpeedPong, float ySpeedPong) {
    pongX = xPong;
    pongY = yPong;
    pongW = wPong;
    pongH = hPong;
    pongXSpeed = xSpeedPong;
    pongYSpeed = ySpeedPong;
  }



  void drawPong() {
    fill(255);
    noStroke();// gets rid of outline from other drawings
    ellipse(pongX, pongY, pongW, pongH);//physical ball
  }
}
