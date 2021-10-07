part of entities;

class Barrier extends Entity {
  Barrier({
    required this.top,
    required double x,
    required double y,
    required double width,
    required double height,
    int speed = kDefaultBarrierSpeed,
  })  : _speed = speed,
        super(
          x: x,
          y: y,
          width: width,
          height: height,
        );

  final bool top;
  bool _crossHalfWay = false;
  int _speed;

  bool get crossHalfWay => _crossHalfWay;

  @override
  void update(double dt) {
    x = x - _speed * dt;
  }

  void goThrough() {
    _crossHalfWay = true;
  }

  void setSpeed(int speed) {
    _speed = speed;
  }

  @override
  Widget draw(BuildContext context) {
    final radius = Radius.circular(8);
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: top ? Radius.zero : radius,
              topRight: top ? Radius.zero : radius,
              bottomLeft: top ? radius : Radius.zero,
              bottomRight: top ? radius : Radius.zero,
            ),
            side: BorderSide(
              color: Color(0xFFFF8F00),
              width: 4,
            ),
          ),
          color: Color(0xFFFFC107),
        ),
      ),
    );
  }
}

class BarrierPair {
  BarrierPair({
    required this.top,
    required this.bottom,
  });

  final Barrier top;
  final Barrier bottom;

  void update(double dt) {
    top.update(dt);
    bottom.update(dt);
  }

  void setSpeed(int speed) {
    top.setSpeed(speed);
    bottom.setSpeed(speed);
  }
}
