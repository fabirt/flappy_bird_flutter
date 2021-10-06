part of components;

abstract class Entity implements LoopElement {
  Entity({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  double x, y, width, height;

  Rect get rect => Offset(x, y) & Size(width, height);

  Widget draw(BuildContext context);
}
