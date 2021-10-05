part of widgets;

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 70),
        primary: Colors.white,
        onPrimary: Colors.green,
      ),
      child: const Icon(Icons.play_arrow_rounded),
    );
  }
}
