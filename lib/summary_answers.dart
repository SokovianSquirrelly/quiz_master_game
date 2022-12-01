import 'package:flutter/material.dart';
import 'settings.dart';
import 'home_page.dart';
import 'story_page.dart';

class SummaryAnswers extends StatelessWidget {
  // const SummaryAnswers({required Key key, required this.index, required this.question}) : super(key: key);
  const SummaryAnswers({ super.key, required this.index});

  final int index;
  final String title = "Answers";
  // final Question question;

  get circleAvatarBackground => null;

  get correctAnswerStyle => null;

  get wrongAnswerStyle => null;

  get notChosenStyle => null;

  get circleAvatarRadius => null;

  get questionStyle => null;

  // List<Widget> _buildAnswers(Question question) {
  //   final widgets = <Widget>[...question.answers.map((answer) {
  //         return Text(
  //           answer,
  //           style: question.isCorrect(answer)
  //               ? correctAnswerStyle
  //               : question.isChosen(answer) ? wrongAnswerStyle : notChosenStyle,
  //         );
  //       })]
  //     ;
  //
  //   return widgets;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/green-correct.png'),
          // fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Home',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home Page')),
              );
            },
          ),
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
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                  child: CircleAvatar(
                    backgroundColor: circleAvatarBackground,
                    radius: circleAvatarRadius,
                    child: Text(
                      '$index',
                      style: questionStyle,
                    ),
                  ),
                ),
                const Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("question"), //'${question.question}',
                      // style: questionStyle, textAlign: TextAlign.center),
                    )),
              ],
            ),
            TextButton( //
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                );
              },
              child: const Text("Next"),
            ),
            // Column(children: _buildAnswers(question)),
          ],
        ),
      ),
    );
  }
}

class Question {
  get answers => "temp answers";

  get question => "temp question";

  isCorrect(answer) {}

  isChosen(answer) {}
}