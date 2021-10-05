part of screens;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _logic = GameLogic();

  void _startGame() {
    final screen = MediaQuery.of(context).size;
    _logic.startGame(screen);
  }

  Widget _buildGameView(GameState gameState) {
    switch (gameState) {
      case GameState.idle:
        return GameIdleView(
          player: _logic.player,
          onStart: _startGame,
        );
      case GameState.started:
        return GameStartedView(
          score: _logic.score,
          player: _logic.player,
          barriers: _logic.barriers,
          onTap: _logic.jump,
        );
      case GameState.finished:
        return GameFinishedView(
          score: _logic.score,
          player: _logic.player,
          barriers: _logic.barriers,
          onRestart: _startGame,
        );
      default:
        throw ArgumentError('Illegal GameState: $gameState');
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
          body: _buildGameView(_logic.gameState),
        );
      },
    );
  }
}
