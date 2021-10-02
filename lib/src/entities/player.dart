part of entities;

class Player extends Entity {
  Player()
      : super(
          x: 0,
          y: 0,
          width: 40,
          height: 40,
        );

  bool _isAlive = true;
  bool _isGoingUp = false;
  double _velocity = 0;
  double _acc = 30;
  late Size world;
  static const _friction = 40;
  static const _maxVelocity = 40;

  void init(Size screen) {
    world = screen;
    x = (screen.width / 2) - (width / 2);
    y = (screen.height / 2) - (height / 2);
    _isAlive = true;
    _isGoingUp = false;
    _velocity = 0;
  }

  void update(double dt, GameState gameState) {
    if (gameState == GameState.idle) {
      return;
    }

    if (_isGoingUp && _isAlive) {
      // jump
      _velocity = _velocity * (1 - math.min(dt * _friction, 1)) - 10;
      _isGoingUp = false;
    } else if (_velocity < _maxVelocity) {
      // apply gravity
      _velocity = _velocity + _acc * dt;
    }

    final goalY = y + _velocity;
    y = goalY.clamp(-height, world.height).toDouble();
  }

  void jump() {
    _isGoingUp = true;
  }

  void die() {
    _isAlive = false;
  }

  bool collisionFilter(Entity other) {
    return rect.right > other.rect.left &&
        rect.left < other.rect.right &&
        rect.top < other.rect.bottom &&
        rect.bottom > other.rect.top;
  }

  @override
  Widget draw() {
    double angle = (_velocity.clamp(0, 10) / 10) * math.pi;

    return Transform.rotate(
      angle: angle,
      child: SizedBox(
        width: width,
        height: height,
        child: Image(
          image: AssetImage(kPlayerImage),
        ),
      ),
    );
  }
}
