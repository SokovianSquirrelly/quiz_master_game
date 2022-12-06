import 'package:flutter/material.dart';
import 'settings.dart';
import 'home_page.dart';
import 'story_page.dart';

class SummaryAnswers extends StatelessWidget {
  // const SummaryAnswers({required Key key, required this.index, required this.question}) : super(key: key);
  const SummaryAnswers({ super.key, required this.score, required this.answer, required this.subject, required this.correct});

  final String subject;
  final int score;
  final String answer;
  final bool correct;
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
    var image = 'assets/images/green-correct.png';
    if (!correct){
      image = 'assets/images/red-incorrect.png';
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      constraints: const BoxConstraints.expand(),
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //   image: AssetImage('assets/images/green-correct.png'),
      //   // fit: BoxFit.cover
      //   ),
      // ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(subject),
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
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                  child: CircleAvatar(
                    backgroundColor: circleAvatarBackground,
                    radius: circleAvatarRadius,
                    child: Text(
                      '$score',
                      style: questionStyle,
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(answer), //'${question.question}',
                      // style: questionStyle, textAlign: TextAlign.center),
                    )),
              ],
            ),

            Image(image: AssetImage(image),),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),

            TextButton( //
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoryPage(subject: subject)),
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