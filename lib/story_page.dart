import 'package:flutter/material.dart';
import 'summary_answers.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key, required this.title});

  final String title;

  String findStory() {
    return ("This is where the story will be shown and the problem question asked.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/simplebackground.png'),
            // SettingsButton(),
            TextButton( //
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
            const Text(
              'Title goes here',
            ),
            const Text( //
              "This is where the story will be shown and the problem question asked.",
            ),
            TextButton( //
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                );
              },
              child: const Text("Answer 1"),
            ),
            TextButton( //
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                );
                },
              child: const Text("Answer 2"),
            ),
            TextButton( //
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                );
              },
              child: const Text("Answer 3"),
            ),
          ],
        ),
      ),
    );
  }
}

