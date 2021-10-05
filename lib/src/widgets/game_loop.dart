part of widgets;

class GameLoop extends StatefulWidget {
  const GameLoop({
    Key? key,
    required this.load,
    required this.update,
    required this.draw,
  }) : super(key: key);

  final ValueChanged<BuildContext> load;
  final ValueChanged<double> update;
  final WidgetBuilder draw;

  @override
  _GameLoopState createState() => _GameLoopState();
}

class _GameLoopState extends State<GameLoop> {
  late final Ticker _ticker;
  Duration _ellapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();

    launchedEffect(() {
      widget.load(context);
      _ticker = Ticker(_tick)..start();
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration timeStamp) {
    final dt = (timeStamp.inMilliseconds - _ellapsedTime.inMilliseconds) / 1000;
    _ellapsedTime = timeStamp;
    widget.update(dt);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.draw(context);
}
