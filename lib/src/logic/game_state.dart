part of logic;

class GameState {
  GameState({
    required this.score,
    required this.barrierFactoryChangeInterval,
    required this.createBarrierTimer,
    required this.gameplayState,
    required this.player,
    required this.barrierFactory,
    required this.barriers,
    required this.screenMask,
  });

  int score;
  int barrierFactoryChangeInterval;
  double createBarrierTimer;
  GameplayState gameplayState;
  Player player;
  BarrierFactory barrierFactory;
  List<BarrierPair> barriers;
  ScreenMask screenMask;
}
