library utils;

import 'package:flutter/material.dart';

void launchedEffect(VoidCallback callback) {
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    callback();
  });
}

enum GameplayState {
  idle,
  started,
  finished,
}
