part of components;

abstract class Entity {
  Entity({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  double x, y, width, height;

  Rect get rect => Offset(x, y) & Size(width, height);

  void update(double dt);

  Widget draw();
}
