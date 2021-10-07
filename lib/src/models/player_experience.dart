part of models;

class PlayerExperience extends ChangeNotifier {
  BackgroundImage _backgroundImage = BackgroundImage.blueSky;
  Character _character = Character.dash;
  int _highScore = 0;
  int _money = 0;

  BackgroundImage get backgroundImage => _backgroundImage;
  Character get character => _character;
  int get highScore => _highScore;
  int get money => _money;

  void changeBackground(BackgroundImage value) {
    _backgroundImage = value;
    notifyListeners();
  }

  void changeCharacter(Character value) {
    _character = value;
    notifyListeners();
  }

  void changeHighScore(int value) {
    if (value > _highScore) {
      _highScore = value;
      notifyListeners();
    }
  }

  void addMoney(int value) {
    _money += value;
    notifyListeners();
  }

  void subtractMoney(int value) {
    _money -= value;
    notifyListeners();
  }
}
