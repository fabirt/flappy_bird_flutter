part of models;

class Character extends Equatable {
  const Character._({
    required this.assetImage,
    required this.cost,
  });

  final String assetImage;
  final int cost;

  static const Character dash = Character._(
    assetImage: kPlayerImage_1,
    cost: 0,
  );

  static const Character grumpy = Character._(
    assetImage: kPlayerImage_2,
    cost: 0,
  );

  static const Character marcos = Character._(
    assetImage: kPlayerImage_3,
    cost: 0,
  );

  static const List<Character> options = [dash, grumpy, marcos];

  @override
  List<Object?> get props => [assetImage, cost];
}
