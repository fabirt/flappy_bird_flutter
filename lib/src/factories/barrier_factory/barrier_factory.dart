part of factories;

abstract class BarrierFactory {
  /// Barrier creation speed
  double get speed;

  BarrierPair create(Size world);
}

mixin RandomBarrierGenerator {
  final _random = Random();

  BarrierPair generate({
    required Size world,
    required double gapTopLimit,
    required double gapBottomLimit,
    required double gapMinHeight,
    required double gapMaxHeight,
    double bottomBarrierMinHeight = 0,
  }) {
    const double barrierWidth = 60;

    final gapHeight = gapMinHeight +
        _random.nextInt(
            (max(gapMaxHeight, gapMinHeight)).toInt() - gapMinHeight.toInt());

    final topBarrierHeight = _random.nextInt(
            (world.height - gapHeight - bottomBarrierMinHeight).toInt() -
                gapTopLimit.toInt()) +
        gapTopLimit;

    final bottomBarrierHeight = world.height - gapHeight - topBarrierHeight;

    final topBarrier = Barrier(
      top: true,
      x: world.width,
      y: 0,
      width: barrierWidth,
      height: topBarrierHeight,
    );

    final bottomBarrier = Barrier(
      top: false,
      x: world.width,
      y: world.height - bottomBarrierHeight,
      width: barrierWidth,
      height: bottomBarrierHeight,
    );

    return BarrierPair(top: topBarrier, bottom: bottomBarrier);
  }
}
