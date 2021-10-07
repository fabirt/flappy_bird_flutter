part of game;

class GameState {
  GameState({
    required this.score,
    required this.barrierSpeed,
    required this.pointsUntilLevelChange,
    required this.createBarrierTimer,
    required this.gameplayState,
    required this.player,
    required this.barrierFactory,
    required this.barriers,
    required this.screenMask,
  });

  factory GameState.initial() => GameState(
        score: 0,
        barrierSpeed: kDefaultBarrierSpeed,
        pointsUntilLevelChange: kMaxPointsPerLevelChange,
        createBarrierTimer: 0,
        gameplayState: GameplayState.idle,
        player: Player(),
        barrierFactory: EasyBarrierFactory(),
        barriers: [],
        screenMask: ScreenMask(),
      );

  int score;
  int barrierSpeed;
  int pointsUntilLevelChange;
  double createBarrierTimer;
  GameplayState gameplayState;
  Player player;
  BarrierFactory barrierFactory;
  List<BarrierPair> barriers;
  ScreenMask screenMask;

  void resetBarrierSpeed() {
    barrierSpeed = kDefaultBarrierSpeed;
  }

  void resetGravity() {
    player
      ..setGravity(kGravity)
      ..setJumpVelocity(kJumpVelocity);
  }
}
