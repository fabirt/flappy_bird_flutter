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
  double _velocity = 0;
  bool _moving = false;

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
    _velocity = _velocity + kGravity * dt;
    final goalY = y + _velocity * dt;

    y = goalY.clamp(-height, world.height);
  }

  void fall() {
    _moving = true;
  }

  void jump() {
    _velocity = kJumpVelocity;
  }

  bool collisionFilter(Entity other) {
    // add collision space
    return rect.right > other.rect.left + 6 &&
        rect.left < other.rect.right - 6 &&
        rect.top < other.rect.bottom - 6 &&
        rect.bottom > other.rect.top + 6;
  }

  @override
  Widget draw() {
    final angle = (_velocity.clamp(0, 600) / 600) * math.pi;

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
