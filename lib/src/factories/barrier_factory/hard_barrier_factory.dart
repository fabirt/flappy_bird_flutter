part of factories;

class HardBarrierFactory extends BarrierFactory with RandomBarrierGenerator {
  @override
  double get speed => 1;

  @override
  BarrierPair create(Size world) {
    final gapMinHeight = 140.0;
    final gapMaxHeight = 180.0;
    final gapTopLimit = world.height / 2 - gapMaxHeight / 2;
    final gapBottomLimit = world.height / 2 + gapMaxHeight / 2;

    return generate(
      world: world,
      gapTopLimit: gapTopLimit,
      gapBottomLimit: gapBottomLimit,
      gapMinHeight: gapMinHeight,
      gapMaxHeight: gapMaxHeight,
      bottomBarrierMinHeight: gapTopLimit / 2,
    );
  }
}
