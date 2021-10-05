part of views;

class GameStartedView extends StatelessWidget {
  const GameStartedView({
    Key? key,
    required this.score,
    required this.player,
    required this.barriers,
    required this.onTap,
  }) : super(key: key);

  final int score;
  final Player player;
  final Iterable<BarrierPair> barriers;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Stack(
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
        ],
      ),
    );
  }
}
