import 'package:flutter/material.dart';
import 'story_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyHomePage(title: "Home Page"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Quiz Master",
      home: Scaffold(
      )
    );
  }
}
