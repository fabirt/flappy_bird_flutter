part of screens;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    implements GameplayStateListener {
  final _logic = GameLogic();

  @override
  void initState() {
    super.initState();
    _logic.setGameplayStateListener(this);
    final playerExp = Provider.of<PlayerExperience>(context, listen: false);
    playerExp.addListener(() {
      _logic.player.setCharacter(playerExp.character);
    });
  }

  void _startGame() {
    final screen = MediaQuery.of(context).size;
    _logic.startGame(screen);
  }

  Widget _buildGameView(GameplayState state) {
    switch (state) {
      case GameplayState.idle:
        return GameIdleView(
          player: _logic.player,
          onStart: _startGame,
        );
      case GameplayState.started:
        return GameStartedView(
          score: _logic.score,
          player: _logic.player,
          barriers: _logic.barriers,
          onTap: _logic.jump,
        );
      case GameplayState.finished:
        return GameFinishedView(
          score: _logic.score,
          player: _logic.player,
          barriers: _logic.barriers,
          onRestart: _startGame,
        );
      default:
        throw ArgumentError('Illegal GameplayState: $state');
    }
  }

  @override
  Widget build(BuildContext context) {
    final world = MediaQuery.of(context).size;

    return GameLoop(
      load: (_) => _logic.load(world),
      update: (double dt) => _logic.update(dt, world),
      draw: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.green,
          body: ColorFiltered(
            colorFilter: _logic.screenMask.filter,
            child: _buildGameView(_logic.gameplayState),
          ),
        );
      },
    );
  }

  @override
  void onFinished(int score) {
    // Save data. Update high score.
  }
}
