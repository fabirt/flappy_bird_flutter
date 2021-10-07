part of game;

abstract class LevelStrategy {
  void activate(GameState state, AudioCache audio);
}

abstract class DefaultLevelStrategy implements LevelStrategy {
  void activate(GameState state, AudioCache audio) {
    state
      ..resetBarrierSpeed()
      ..resetGravity()
      ..screenMask.clear();
  }
}

class EasyLevelStrategy extends DefaultLevelStrategy {
  @override
  void activate(GameState state, AudioCache audio) {
    super.activate(state, audio);
    state.barrierFactory = EasyBarrierFactory();
  }
}

class NormalLevelStrategy extends DefaultLevelStrategy {
  @override
  void activate(GameState state, AudioCache audio) {
    super.activate(state, audio);
    state.barrierFactory = NormalBarrierFactory();
  }
}

class HardLevelStrategy implements LevelStrategy {
  @override
  void activate(GameState state, AudioCache audio) {
    audio.sfx(kNegativeSound);

    // increase barrier speed
    state.barrierSpeed = (kDefaultBarrierSpeed * 1.34).toInt();

    state.barrierFactory = HardBarrierFactory();
    state.screenMask.blinkDark();

    // invert gravity
    state.player.setGravity(-kGravity);
    state.player.setJumpVelocity(-kJumpVelocity);
  }
}
