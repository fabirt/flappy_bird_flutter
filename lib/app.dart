import 'package:flutter/material.dart';
import 'package:flappy_bird_flutter/src/screens/screens.dart';

class FlappyBirdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Dash',
      debugShowCheckedModeBanner: false,
      home: const GameScreen(),
    );
  }
}
