import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // title: "Quiz Master",
      home: MyHomePage(title: "Home Page")
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Image from assets"),
      //   ),
      //   body: Image.asset('assets/simple-background.png'), //   <-- image
      // ),
      // Scaffold()
    );
  }
}
