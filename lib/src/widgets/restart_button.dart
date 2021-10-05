part of widgets;

class RestartButton extends StatelessWidget {
  const RestartButton({
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
      child: const Icon(Icons.refresh_rounded),
    );
  }
}
