import 'package:flutter/material.dart';
import 'package:quizmastergame/game_choice.dart';
import 'settings.dart';
import 'story_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade600,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings(title: 'Settings')),
              );
            },
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          // Row(
          //   children: const [SettingsButton(),
          //   ],
          // ),
          Center(
            child: Column(
              children: const <Widget>[
                Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0)),
                // Text(
                //   'Quiz Master',
                //   style: TextStyle(
                //     fontSize: 70,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.green,
                //   ),
                // ),
                // Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                Image(image: AssetImage('assets/images/quiz-master.png'), height: 300,),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                ContinueButton(),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                NewGameButton()
              ],
            ),
          ),
        ]
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
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(125))
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
          MaterialPageRoute(builder: (context) => const StoryPage(subject: "continue")),
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