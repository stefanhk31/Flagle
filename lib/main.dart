import 'package:flagle/screens/loading_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Flagle());
}

class Flagle extends StatelessWidget {
  const Flagle({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flagle',
      theme: ThemeData.dark(),
      home: const LoadingScreen(title: 'Flagle'),
    );
  }
}
