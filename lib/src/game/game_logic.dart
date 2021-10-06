part of game;

class GameLogic {
  final _audioPlayer = AudioCache(prefix: kAudioPrefix);
  LevelStrategy _strategy = EasyLevelStrategy();
  GameState _state = GameState.initial();
  GameplayStateListener? _listener;

  int get score => _state.score;
  Player get player => _state.player;
  List<BarrierPair> get barriers => _state.barriers;
  GameplayState get gameplayState => _state.gameplayState;
  BarrierFactory get barrierFactory => _state.barrierFactory;
  ScreenMask get screenMask => _state.screenMask;

  void load(Size world) {
    _state.player.init(world);
    _audioPlayer.load(kWingSound);
  }

  void startGame(Size world) {
    _strategy = EasyLevelStrategy();
    _state.barriers.clear();
    _state.barrierFactory = EasyBarrierFactory();
    _state.pointsUntilLevelChange = kMaxPointsPerLevelChange;
    _state.createBarrierTimer = 2;
    _state.gameplayState = GameplayState.started;
    _state.score = 0;
    _state.player.init(world);
    _state.player.fall();
    _state.screenMask.clear();
  }

  void update(double dt, Size world) {
    // Player
    _state.player.update(dt);
    if (_state.player.y >= world.height &&
        _state.gameplayState == GameplayState.started) {
      _audioPlayer.sfx(kDieSound);
      finish();
    }

    // Barrier creation
    _state.createBarrierTimer -= dt;
    if (_state.createBarrierTimer < 0 &&
        _state.gameplayState == GameplayState.started) {
      _state.createBarrierTimer = _state.barrierFactory.speed;
      // create a pair of barriers
      final barriers = _state.barrierFactory.create(world);
      _state.barriers.add(barriers);
    }

    // Barriers
    if (_state.gameplayState == GameplayState.started) {
      for (int i = 0; i < _state.barriers.length; i++) {
        final pair = _state.barriers.elementAt(i);
        pair.update(dt);

        final refBarrier = pair.top;

        // remove barrier
        if (refBarrier.x < -refBarrier.width) {
          _state.barriers.removeAt(i);
        }

        // update score
        if (refBarrier.x < (world.width / 2 - refBarrier.width / 2) &&
            !refBarrier.crossHalfWay) {
          _audioPlayer.sfx(kPointSound);
          refBarrier.goThrough();
          _state.score++;
          _state.pointsUntilLevelChange--;
        }

        // check collisions
        if (_state.player.collisionFilter(pair.top) ||
            _state.player.collisionFilter(pair.bottom)) {
          _audioPlayer.sfx(kHitSound);
          finish();
        }
      }
    }

    // change level strategy
    if (_state.gameplayState == GameplayState.started &&
        _state.pointsUntilLevelChange <= 0) {
      _state.pointsUntilLevelChange = kMaxPointsPerLevelChange;
      if (_state.score >= 10 && _state.score < 20) {
        _strategy = NormalLevelStrategy();
      } else if (score >= 20 && _state.score < 30) {
        _strategy = HardLevelStrategy();
      } else {
        _strategy = NormalLevelStrategy();
      }
      _strategy.activate(_state, _audioPlayer);
    }

    // screen mask
    _state.screenMask.update(dt);
  }

  void jump() {
    _audioPlayer.sfx(kWingSound);
    _state.player.jump();
  }

  void finish() {
    _state.gameplayState = GameplayState.finished;
    _listener?.onFinished(score);
  }

  void setGameplayStateListener(GameplayStateListener l) {
    _listener = l;
  }
}

extension Sfx on AudioCache {
  /// Play sound effect.
  void sfx(String fileName) {
    play(fileName, mode: PlayerMode.LOW_LATENCY);
  }
}
