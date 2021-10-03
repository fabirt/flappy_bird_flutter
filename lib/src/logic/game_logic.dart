part of logic;

class GameLogic {
  static const double _createBarrierTimerMax = 3;
  final _audioPlayer = AudioCache(prefix: kAudioPrefix);

  Player _player = Player();
  GameState _gameState = GameState.idle;
  BarrierFactory _barrierFactory = EasyBarrierFactory();
  Queue<BarrierPair> _barriers = Queue<BarrierPair>();
  double _createBarrierTimer = _createBarrierTimerMax;
  int _score = 0;

  int get score => _score;
  Player get player => _player;
  Queue<BarrierPair> get barriers => _barriers;
  GameState get gameState => _gameState;

  void load(Size world) {
    _player.init(world);
  }

  void startGame(Size world) {
    _barriers.clear();
    _gameState = GameState.started;
    _createBarrierTimer = 2;
    _score = 0;
    _player.init(world);
    _player.fall();
  }

  void update(double dt, Size world) {
    // Player
    _player.update(dt);
    if (_player.y >= world.height && _gameState == GameState.started) {
      _gameState = GameState.finished;
      _audioPlayer.play(kDieSound);
    }

    // Barrier creation
    _createBarrierTimer -= dt;
    if (_createBarrierTimer < 0 && _gameState == GameState.started) {
      _createBarrierTimer = _createBarrierTimerMax;
      // create a pair of barriers
      final barriers = _barrierFactory.create(world);
      _barriers.add(barriers);
    }

    // Barriers
    if (_gameState == GameState.started) {
      for (int i = 0; i < _barriers.length; i++) {
        final pair = _barriers.elementAt(i);
        pair.update(dt);

        // remove barrier
        if (pair.top.x < -pair.top.width) {
          _barriers.removeFirst();
        }

        // update score
        final refBarrier = pair.top;
        if (refBarrier.x < (world.width / 2 - refBarrier.width / 2) &&
            !refBarrier.crossHalfWay) {
          _audioPlayer.play(kPointSound);
          refBarrier.crossHalfWay = true;
          _score++;
        }

        // check collisions
        if (_player.collisionFilter(pair.top) ||
            _player.collisionFilter(pair.bottom)) {
          _audioPlayer.play(kHitSound);
          _gameState = GameState.finished;
        }
      }
    }
  }

  void jump() {
    if (_gameState == GameState.started) {
      _audioPlayer.play(kWingSound);
      _player.jump();
    }
  }
}
