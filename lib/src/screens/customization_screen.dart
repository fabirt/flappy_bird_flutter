part of screens;

class CustomizationScreen extends StatefulWidget {
  const CustomizationScreen({Key? key}) : super(key: key);

  @override
  _CustomizationScreenState createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  @override
  Widget build(BuildContext context) {
    final playerExp = context.watch<PlayerExperience>();

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: BackgroundImage.options.map((BackgroundImage image) {
              final index = BackgroundImage.options.indexOf(image);
              BorderSide borderSide = BorderSide.none;
              double spacing = 8;

              if (image == playerExp.backgroundImage) {
                borderSide = BorderSide(
                  width: 4,
                  color: Colors.red,
                );
              }

              if (index == 0) {
                spacing = 0;
              }

              return Padding(
                padding: EdgeInsets.only(left: spacing),
                child: GestureDetector(
                  onTap: () {
                    playerExp.changeBackground(image);
                  },
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: borderSide,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          image.assetImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
