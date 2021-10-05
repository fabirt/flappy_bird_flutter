part of views;

class GameFinishedView extends StatelessWidget {
  const GameFinishedView({
    Key? key,
    required this.score,
    required this.player,
    required this.barriers,
    required this.onRestart,
  }) : super(key: key);

  final int score;
  final Player player;
  final Iterable<BarrierPair> barriers;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned.fill(
          child: Background(),
        ),
        ...barriers
            .expand((pair) => [pair.top, pair.bottom])
            .map((barrier) => Positioned(
                  left: barrier.x,
                  top: barrier.y,
                  width: barrier.width,
                  height: barrier.height,
                  child: barrier.draw(),
                )),
        Positioned(
          left: player.x,
          top: player.y,
          width: player.width,
          height: player.height,
          child: player.draw(),
        ),
        Align(
          alignment: const Alignment(0, -0.9),
          child: Text(
            score.toString(),
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.6),
          child: Text(
            'Flappy Dash',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.6),
          child: RestartButton(onPressed: onRestart),
        ),
      ],
    );
  }
}
