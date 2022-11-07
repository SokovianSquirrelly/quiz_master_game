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
              overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade600),
              padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              fixedSize: MaterialStateProperty.all(Size.fromWidth(325)),
              ),
              ),
          textTheme: TextTheme(
            button: TextStyle(
              fontSize: 30,
              fontFamily: "Cambria",
                    ),
            headline2: TextStyle(
              fontSize: 40,
              color: Colors.green.shade600,
              fontFamily: "Cambria",
              fontWeight: FontWeight.w500,

            )


                ),

              )
            ,


        home: Scaffold(

          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Row(
                children: [SettingsButton(),
                ],
              ),
              Center(
                child: Column(
                  children: const <Widget>[
                    Padding(padding: EdgeInsets.symmetric(vertical: 50,horizontal: 0)),
                    Text(
                      'Quiz Master',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    ContinueButton(),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    NewGameButton()
                  ],
                ),
              ),
            ]
        )
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
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size.fromWidth(125))
      ),
      child: const Text("Settings",
      style: TextStyle(
        fontSize: 20,
      ),),
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