part of views;

class GameIdleView extends StatelessWidget {
  const GameIdleView({
    Key? key,
    required this.player,
    required this.onStart,
  }) : super(key: key);

  final Entity player;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final playerExp = context.watch<PlayerExperience>();

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Background(
            assetImage: playerExp.backgroundImage.assetImage,
          ),
        ),
        Positioned(
          left: player.x,
          top: player.y,
          width: player.width,
          height: player.height,
          child: player.draw(),
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
          child: PlayButton(onPressed: onStart),
        ),
      ],
    );
  }
}
