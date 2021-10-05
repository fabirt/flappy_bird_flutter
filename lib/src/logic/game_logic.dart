part of logic;

class GameLogic {
  static const int _maxBarrierFactoryChangeInterval = 10;
  final _audioPlayer = AudioCache(prefix: kAudioPrefix);

  Player _player = Player();
  GameState _gameState = GameState.idle;
  BarrierFactory _barrierFactory = EasyBarrierFactory();
  List<BarrierPair> _barriers = [];
  double _createBarrierTimer = 0;
  int _barrierFactoryChangeInterval = _maxBarrierFactoryChangeInterval;
  int _score = 0;

  int get score => _score;
  Player get player => _player;
  List<BarrierPair> get barriers => _barriers;
  GameState get gameState => _gameState;

  void load(Size world) {
    _player.init(world);
    _audioPlayer.load(kWingSound);
  }

  void startGame(Size world) {
    _barriers.clear();
    _barrierFactory = EasyBarrierFactory();
    _barrierFactoryChangeInterval = _maxBarrierFactoryChangeInterval;
    _createBarrierTimer = 2;
    _gameState = GameState.started;
    _score = 0;
    _player.init(world);
    _player.fall();
  }

  void update(double dt, Size world) {
    // Player
    _player.update(dt);
    if (_player.y >= world.height && _gameState == GameState.started) {
      _gameState = GameState.finished;
      _audioPlayer.play(kDieSound, mode: PlayerMode.LOW_LATENCY);
    }

    // Barrier creation
    _createBarrierTimer -= dt;
    if (_createBarrierTimer < 0 && _gameState == GameState.started) {
      _createBarrierTimer = _barrierFactory.speed;
      // create a pair of barriers
      final barriers = _barrierFactory.create(world);
      _barriers.add(barriers);
    }

    // Barriers
    if (_gameState == GameState.started) {
      for (int i = 0; i < _barriers.length; i++) {
        final pair = _barriers.elementAt(i);
        pair.update(dt);

        final refBarrier = pair.top;

        // remove barrier
        if (refBarrier.x < -refBarrier.width) {
          _barriers.removeAt(i);
        }

        // update score
        if (refBarrier.x < (world.width / 2 - refBarrier.width / 2) &&
            !refBarrier.crossHalfWay) {
          _audioPlayer.play(kPointSound, mode: PlayerMode.LOW_LATENCY);
          refBarrier.goThrough();
          _score++;
          _barrierFactoryChangeInterval--;
        }

        // check collisions
        if (_player.collisionFilter(pair.top) ||
            _player.collisionFilter(pair.bottom)) {
          _audioPlayer.play(kHitSound, mode: PlayerMode.LOW_LATENCY);
          _gameState = GameState.finished;
        }
      }
    }

    // change barrier factory
    if (_gameState == GameState.started && _barrierFactoryChangeInterval <= 0) {
      _barrierFactoryChangeInterval = _maxBarrierFactoryChangeInterval;
      if (_score >= 10 && _score < 20) {
        _barrierFactory = NormalBarrierFactory();
      } else if (score >= 20) {
        _barrierFactory = HardBarrierFactory();
      }
    }
  }

  void jump() {
    _audioPlayer.play(kWingSound, mode: PlayerMode.LOW_LATENCY);
    _player.jump();
  }
}
