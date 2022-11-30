import 'package:flutter/material.dart';
import 'summary_answers.dart';
import 'home_page.dart';
import 'settings.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key, required this.title});

  final String title;

  String findStory() {
    return ("This is where the story will be shown and the problem question asked.");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/simple-background.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.green.shade600,
          title: Text(title),
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
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: 'Home',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home Page')),
                );
              },
            ),
          ],
        ),
        body: Column(
        children: [
          // Row(
          //   children: [
          //     TextButton(
          //         onPressed: null,
          //         style: ButtonStyle(
          //             fixedSize: MaterialStateProperty.all(const Size.fromWidth(125))
          //         ),
          //         child: const Text("Settings",
          //           style: TextStyle(
          //           fontSize: 20,
          //           ),
          //         )
          //     ),
          //     const Padding(padding: EdgeInsets.symmetric(vertical:0 ,horizontal: 10)),
          //     TextButton(
          //         onPressed: null,
          //         style: ButtonStyle(
          //         fixedSize: MaterialStateProperty.all(const Size.fromWidth(125))
          //         ),
          //         child: const Text("Back",
          //           style: TextStyle(
          //             fontSize: 20,
          //           ),
          //         )
          //     ),
          //     const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
          //   ],
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SettingsButton(),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),

                Text(
                  "Title goes here",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                Text( //
                  "This is where the story will be shown and the problem question asked.",
                  style: Theme.of(context).textTheme.headline2
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),

                TextButton( //
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                    );
                  },
                  child: const Text("Answer 1"),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),

                TextButton( //
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                    );
                  },
                  child: const Text("Answer 2"),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),

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
          ],
        )
      )
    );
  }
}

