part of factories;

class EasyBarrierFactory extends BarrierFactory with RandomBarrierGenerator {
  @override
  double get speed => 3;

  @override
  BarrierPair create(Size world) {
    final gapTopLimit = world.height / 4;
    final gapBottomLimit = world.height - world.height / 4;

    final gapMaxHeight = gapBottomLimit - gapTopLimit;

    return generate(
      world: world,
      gapTopLimit: gapTopLimit,
      gapBottomLimit: gapBottomLimit,
      gapMinHeight: 200.0,
      gapMaxHeight: gapMaxHeight,
      bottomBarrierMinHeight: gapTopLimit,
    );
  }
}
