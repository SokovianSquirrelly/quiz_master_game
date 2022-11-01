import 'package:flutter/material.dart';
import 'package:quizmastergame/game_choice.dart';
import 'settings.dart';
import 'story_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              overlayColor: MaterialStateProperty.all<Color>(Colors.black54),
              padding: MaterialStateProperty.all(EdgeInsets.all(17)),
              fixedSize: MaterialStateProperty.all(Size.fromWidth(325)),
              ),
              ),
          textTheme: TextTheme(
            button: TextStyle(
              fontSize: 30,
                    ),

                ),

              )
            ,


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
          MaterialPageRoute(builder: (context) => const GameChoice()),
        );
      },
      child: const Text("New Game"),
    );
  }
}