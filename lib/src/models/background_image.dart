part of models;

class BackgroundImage extends Equatable {
  final String assetImage;
  final int cost;

  const BackgroundImage._({
    required this.assetImage,
    required this.cost,
  });

  static const BackgroundImage blueSky = BackgroundImage._(
    assetImage: kBgImage,
    cost: 0,
  );

  static const BackgroundImage mountains = BackgroundImage._(
    assetImage: kBgImage_2,
    cost: 0,
  );

  static const BackgroundImage stars = BackgroundImage._(
    assetImage: kBgImage_3,
    cost: 0,
  );

  static const List<BackgroundImage> options = [blueSky, mountains, stars];

  @override
  List<Object?> get props => [assetImage, cost];
}
