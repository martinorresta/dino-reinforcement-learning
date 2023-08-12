int DINOS_PER_GENERATION = 1000;
float MIN_SPAWN_MILLIS = 500;
float MAX_SPAWN_MILLIS = 1500;

class Simulation {
  ArrayList<Dino> dinos;
  ArrayList<Enemy> enemies;
  float speed;
  Ground ground;
  int score;
  int generation;
  int last_gen_avg_score;
  int last_gen_max_score;
  int dinos_alive;

  // to control enemies spawn time
  float last_spawn_time;
  float time_to_spawn;
  
  Simulation() {
    dinos = new ArrayList<Dino>();
    for (int i = 0; i < DINOS_PER_GENERATION; i++) {
      dinos.add(new Dino());
    }
    enemies = new ArrayList<Enemy>();
    speed = 15;
    ground = new Ground();
    score = 0;
    generation = 1;
    last_gen_avg_score = 0;
    last_gen_max_score = 0;
    dinos_alive = DINOS_PER_GENERATION;
    last_spawn_time = millis();
    time_to_spawn = random(MIN_SPAWN_MILLIS, MAX_SPAWN_MILLIS);
  }
  
  void update() {
    for (Dino dino : dinos) {
      if (dino.alive){
        dino.update(next_obstacle_info(dino), (int)speed);
      }
    }
    Iterator<Enemy> iterator = enemies.iterator();
    while (iterator.hasNext()) {
      Enemy enemy = iterator.next();
      enemy.update((int)speed);
      if (enemy.is_offscreen()) {
        iterator.remove();
      }
    }
    if (millis() - last_spawn_time > time_to_spawn) {
      spawn_enemy();
      last_spawn_time = millis();
      time_to_spawn = random(MIN_SPAWN_MILLIS, MAX_SPAWN_MILLIS);
    }
    check_collisions();
    ground.update((int)speed);
    speed += 0.001;
