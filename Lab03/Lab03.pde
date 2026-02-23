//Set timer
int state = 0; 
int startTime;
int duration = 30; 

//Player 
float px = 350, py = 175;
float step = 6;
float pr = 20;
//Helper
float hx, hy;      
float ease = 0.10;

//Orb
float x, y;
float xs = 4, ys = 3;
float r = 20;

boolean trails = false;
int score = 0;

void setup() {
  size(700, 350);
  x = random(100, width-100);
  y = random(100, height-100);
}

void draw() {
  if (!trails) {
    background(245);   
  } else {
    fill(245, 40);     
    noStroke();
    rect(0, 0, width, height);
  }

  if (state == 0) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Press ENTER to Start", width/2, height/2);
  }

  if (state == 1) {
    int elapsed = (millis() - startTime) / 1000; 
    int left = duration - elapsed;

    textAlign(LEFT, TOP);
    textSize(18);
    fill(0);
    text("Trails: " + (trails ? "ON" : "OFF") + " (Press T)", 20, 80);
    text("Time Left: " + left, 20, 20);
    text("Score: " + score, 20, 50);
    
    //Orb move
    x += xs;
    y += ys;
    
    if (x > width - r || x < r) xs *= -1;
    if (y > height - r || y < r) ys *= -1;

    fill(255, 120, 80);
    ellipse(x, y, r*2, r*2);
    
    //Player move
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == DOWN)  py += step;
      if (keyCode == UP)    py -= step;
  }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    //Helper move  
    hx = hx + (px - hx) * ease;
    hy = hy + (py - hy) * ease;

    fill(60, 120, 200);
    ellipse(px, py, pr*2, pr*2);
    
    fill(80, 200, 120);
    ellipse(hx, hy, 16, 16);
    
    float d = dist(px, py, x, y);

if (d < pr + r) {
  score++;
  
  x = random(100, width-100);
  y = random(100, height-100);
  
  xs *= 1.05;
  ys *= 1.05;
}

    if (left <= 0) {
      state = 2; 
    }
  }

  if (state == 2) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Your score : "+ score, width/2, 150);
    text("Time Over! Press R to Reset", width/2, height/2);
  }
}

void keyPressed() {
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis(); 
  }

  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
    score = 0;
  }
  
  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}
