part of entities;

class Player extends Entity {
  Player()
      : super(
          x: 0,
          y: 0,
          width: 40,
          height: 40,
        );

  late Size world;
  bool _moving = false;
  Character _character = Character.dash;
  double _velocity = 0;
  double _gravity = kGravity;
  double _jumpVelocity = kJumpVelocity;

  double get gravity => _gravity;

  void init(Size screen) {
    world = screen;
    x = (screen.width / 2) - (width / 2);
    y = (screen.height / 2) - (height / 2);
    _velocity = 0;
    _moving = false;
  }

  @override
  void update(double dt) {
    if (!_moving) {
      return;
    }

    // apply gravity
    _velocity = _velocity + _gravity * dt;
    final goalY = y + _velocity * dt;

    y = goalY.clamp(-height, world.height);
  }

  void fall() {
    _moving = true;
  }

  void jump() {
    _velocity = _jumpVelocity;
  }

  void setGravity(double value) {
    _gravity = value;
  }

  void setJumpVelocity(double value) {
    _jumpVelocity = value;
  }

  bool collisionFilter(Entity other) {
    // add collision space
    return rect.right > other.rect.left + 6 &&
        rect.left < other.rect.right - 6 &&
        rect.top < other.rect.bottom - 6 &&
        rect.bottom > other.rect.top + 6;
  }

  void setCharacter(Character character) {
    _character = character;
  }

  @override
  Widget draw(BuildContext context) {
    const maxSpeed = 600;
    double angle = (_velocity.clamp(0, maxSpeed) / maxSpeed) * math.pi;
    if (_gravity < 0) {
      angle = (_velocity.clamp(-maxSpeed, 0) / maxSpeed) * math.pi + math.pi;
    }

    return Transform.rotate(
      angle: angle,
      child: SizedBox(
        width: width,
        height: height,
        child: Image(
          image: AssetImage(_character.assetImage),
        ),
      ),
    );
  }
}
