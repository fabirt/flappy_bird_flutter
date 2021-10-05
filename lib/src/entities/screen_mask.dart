part of entities;

class ScreenMask extends LoopElement {
  ColorFilter _filter = ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.dst);

  ColorFilter get filter => _filter;

  @override
  void update(double dt) {}

  void clear() {
    _setNormalFilter();
  }

  void blinkDark() {
    _setDarkFilter();
  }

  void _setNormalFilter() {
    _filter = const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.dst);
  }

  void _setDarkFilter() {
    _filter = const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.difference);
  }
}
