part of logic;

abstract class LevelStrategy {
  void activate(GameState state, AudioCache audio);
}

class EasyLevelStrategy implements LevelStrategy {
  @override
  void activate(GameState state, AudioCache audio) {
    state.barrierFactory = EasyBarrierFactory();
    state.screenMask.clear();
  }
}

class NormalLevelStrategy implements LevelStrategy {
  @override
  void activate(GameState state, AudioCache audio) {
    state.barrierFactory = NormalBarrierFactory();
    state.screenMask.clear();
  }
}

class HardLevelStrategy implements LevelStrategy {
  @override
  void activate(GameState state, AudioCache audio) {
    state.barrierFactory = HardBarrierFactory();
    audio.sfx(kNegativeSound);
    state.screenMask.blinkDark();
  }
}
