library utils;

import 'package:flutter/material.dart';

void launchedEffect(VoidCallback callback) {
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    callback();
  });
}

enum GameState {
  idle,
  started,
  finished,
}
