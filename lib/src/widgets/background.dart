part of widgets;

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(kBgImage),
      fit: BoxFit.cover,
    );
  }
}
