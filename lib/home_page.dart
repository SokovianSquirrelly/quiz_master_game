import 'package:flutter/material.dart';
import 'settings.dart';
import 'story_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SettingsButton(),
                Text(
                  'Title goes here',
                ),
                ContinueButton(),
                NewGameButton()
              ],
            ),
          ),
        )
    );

  }
}

class SettingsButton extends StatelessWidget
{
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context)
  {
    return TextButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Settings(title: 'Settings')),
        );
      },
      child: const Text("Settings"),
    );
  }
}

class ContinueButton extends StatelessWidget
{
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context)
  {
    return TextButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
        );
      },
      child: const Text("Continue"),
    );
  }
}

class NewGameButton extends StatelessWidget
{
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context)
  {
    return TextButton
      (
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoryPage(title: "New Story")),
        );
      },
      child: const Text("New Game"),
    );
  }
}