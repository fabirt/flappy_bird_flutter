part of factories;

abstract class BarrierFactory {
  BarrierPair create(Size world);
}

class EasyBarrierFactory extends BarrierFactory {
  @override
  BarrierPair create(Size world) {
    final random = Random();
    const double barrierWidth = 60;

    final gapTopLimit = world.height / 4;
    final gapBottomLimit = world.height - world.height / 4;

    final gapMinHeight = 140;
    final gapMaxHeight = gapBottomLimit - gapTopLimit;
    final gapHeight = gapMinHeight +
        random.nextInt(
            (max(gapMaxHeight, gapMinHeight)).toInt() - gapMinHeight.toInt());

    final topBarrierHeight = random
            .nextInt((world.height - gapHeight).toInt() - gapTopLimit.toInt()) +
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
