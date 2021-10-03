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
  static const double _acc = 1400;

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
    _velocity = _velocity + _acc * dt;
    final goalY = y + _velocity * dt;

    y = goalY.clamp(-height, world.height);
  }

  void fall() {
    _moving = true;
  }

  void jump() {
    _velocity = -450;
  }

  bool collisionFilter(Entity other) {
    return rect.right > other.rect.left &&
        rect.left < other.rect.right &&
        rect.top < other.rect.bottom &&
        rect.bottom > other.rect.top;
  }

  @override
  Widget draw() {
    double angle = (_velocity.clamp(0, 600) / 600) * math.pi;

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
