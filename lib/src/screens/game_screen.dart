part of screens;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Ticker _ticker;
  Duration _timeStamp = Duration.zero;
  final _logic = GameLogic();

  @override
  void initState() {
    super.initState();

    launchedEffect(() {
      final screen = MediaQuery.of(context).size;
      _logic.load(screen);
      _ticker = Ticker(_tick)..start();
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration timeStamp) {
    double dt = (timeStamp.inMilliseconds - _timeStamp.inMilliseconds) / 1000;
    _update(dt);
    _timeStamp = timeStamp;
    setState(() {});
  }

  void _startGame() {
    final screen = MediaQuery.of(context).size;
    _logic.startGame(screen);
  }

  void _update(double dt) {
    final screen = MediaQuery.of(context).size;
    _logic.update(dt, screen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _logic.jump,
        child: Stack(
          children: [
            const Positioned.fill(
              child: Background(),
            ),
            ..._logic.barriers
                .expand((pair) => [pair.top, pair.bottom])
                .map((barrier) => Positioned(
                      left: barrier.x,
                      top: barrier.y,
                      width: barrier.width,
                      height: barrier.height,
                      child: barrier.draw(),
                    )),
            Positioned(
              left: _logic.player.x,
              top: _logic.player.y,
              width: _logic.player.width,
              height: _logic.player.height,
              child: _logic.player.draw(),
            ),
            if (_logic.gameState == GameState.started ||
                _logic.gameState == GameState.finished)
              Align(
                alignment: Alignment(0, -0.9),
                child: Text(
                  _logic.score.toString(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            if (_logic.gameState == GameState.idle ||
                _logic.gameState == GameState.finished)
              Align(
                alignment: Alignment(0, -0.6),
                child: Text(
                  'Flappy Dash',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            if (_logic.gameState == GameState.idle ||
                _logic.gameState == GameState.finished)
              Align(
                alignment: Alignment(0, 0.6),
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120, 70),
                    primary: Colors.white,
                    onPrimary: Colors.green,
                  ),
                  child: Icon(Icons.play_arrow_rounded),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
