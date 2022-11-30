import 'dart:math';

import 'package:flutter/material.dart';
import 'summary_answers.dart';
import 'home_page.dart';
import 'settings.dart';
import 'database.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key, required this.subject});

  final String subject;

  Widget questions(BuildContext context, Future<EventText> text){
    var order = [Random().nextInt(3),Random().nextInt(2),0];
    if (order[0] == 0) {
      order[1] += 1;
    } else if (order[0] == 1) {
      if (order[1] == 1) {
        order[1] = 2;
      }
    }
    var sum = order[0]+order[1];
    if (sum == 1){
      order[2] = 2;
    } else if (sum == 2){
      order[2] = 1;
    } else {
      order[2] = 0;
    }
    var answers = ["", "", ""];
    answers[order[0]] = "Answer 1";
    answers[order[1]] = "Answer 2";
    answers[order[2]] = "Answer 3";

    return Column(
      children: <Widget>[
        TextButton( //
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SummaryAnswers(index: 0, answer: text.toString(), correct: true,)),
            );
          },
          child: Text(answers[0]),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
        TextButton( //
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0, answer: '', correct: true,)),
            );
          },
          child: Text(answers[1]),

        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),

        TextButton( //
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0, answer: '', correct: true,)),
            );
          },
          child: Text(answers[2]),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {

    Future<EventText> text = getText(subject);

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
          title: Text(subject),
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

                // TextButton( //
                //   onPressed: (){
                //     Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0, answer: '', correct: true,)),
                //     );
                //   },
                //   child: const Text("Answer 1"),
                // ),
                // const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                //
                // TextButton( //
                //   onPressed: (){
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0, answer: '', correct: true,)),
                //     );
                //   },
                //   child: const Text("Answer 2"),
                // ),
                // const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                //
                // TextButton( //
                //   onPressed: (){
                //     Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0, answer: '', correct: true,)),
                //     );
                //   },
                //   child: const Text("Answer 3"),
                // ),
                Text(
                    text.toString(),
                    style: Theme.of(context).textTheme.headline2),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                questions(context, text),
              ],
            ),
          ),
          ],
        )
      )
    );
  }
}

