import 'package:flutter/material.dart';
import 'random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.yellow,
      ), // ... to here.

      home: RandomWords(),
    );
  }
}
