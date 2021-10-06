import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flappy_bird_flutter/src/models/models.dart';
import 'package:flappy_bird_flutter/src/screens/screens.dart';

class FlappyBirdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerExperience>(
          create: (_) => PlayerExperience(),
        ),
      ],
      child: MaterialApp(
        title: 'Flappy Dash',
        debugShowCheckedModeBanner: false,
        home: const GameScreen(),
      ),
    );
  }
}
