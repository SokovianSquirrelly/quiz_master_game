import 'package:flutter/material.dart';
import 'summary_answers.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Question q = Question();
    return const MaterialApp(
      title: "Quiz Master",
      home: SummaryAnswers(index: 0, question: q.question)
      // Scaffold()
    );
  }
}
