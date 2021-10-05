part of widgets;

class Background extends StatelessWidget {
  const Background({
    Key? key,
    this.assetImage = kBgImage,
  }) : super(key: key);

  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(assetImage),
      fit: BoxFit.cover,
    );
  }
}
