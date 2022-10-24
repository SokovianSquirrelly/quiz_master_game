import 'package:flutter/material.dart';

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
            // SettingsButton(),
            const Text(
              'Title goes here',
            ),
            TextButton( //
              onPressed: (){},
              child: const Text("This is where the story will be shown and the problem question asked."),
            ),
            TextButton( //
              onPressed: (){

              },
              child: const Text("Answer 1"),
            ),
            TextButton( //
              onPressed: (){},
              child: const Text("Answer 2"),
            ),
            TextButton( //
              onPressed: (){},
              child: const Text("Answer 3"),
            ),
          ],
        ),
      ),
    );
  }
}

