part of factories;

class NormalBarrierFactory extends BarrierFactory with RandomBarrierGenerator {
  @override
  double get speed => 2;

  @override
  BarrierPair create(Size world) {
    final gapTopLimit = world.height / 4;
    final gapBottomLimit = world.height - world.height / 4;
    final gapMaxHeight = 250.0;

    return generate(
      world: world,
      gapTopLimit: gapTopLimit,
      gapBottomLimit: gapBottomLimit,
      gapMinHeight: 150,
      gapMaxHeight: gapMaxHeight,
      bottomBarrierMinHeight: gapTopLimit,
    );
  }
}
