import 'dart:math';

import 'package:flutter/material.dart';

import 'database.dart';
import 'home_page.dart';
import 'settings.dart';
import 'summary_answers.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key, required this.subject});

  final String subject;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  // const StoryPage({super.key, required this.subject});
  //
  // final String subject;
  EventText text = const EventText(
      question: "question",
      answer1: "answer 1",
      answer2: "answer 2",
      answer3: "answer 3",
      story: "story");

  // void getStory() async{
  //   text = await getText(subject);
  // }

  Widget questions(BuildContext context, EventText text) {
    var order = [Random().nextInt(3), Random().nextInt(2), 0];
    if (order[0] == 0) {
      order[1] += 1;
    } else if (order[0] == 1) {
      if (order[1] == 1) {
        order[1] = 2;
      }
    }
    var sum = order[0] + order[1];
    if (sum == 1) {
      order[2] = 2;
    } else if (sum == 2) {
      order[2] = 1;
    } else {
      order[2] = 0;
    }
    var answers = ["", "", ""];
    answers[order[0]] = "Answer 1";
    answers[order[1]] = "Answer 2";
    answers[order[2]] = "Answer 3";

    return Column(children: <Widget>[
      TextButton(
        //
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SummaryAnswers(
                      index: 0,
                      answer: text.toString(),
                      correct: true,
                    )),
          );
        },
        child: Text(answers[0]),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
      TextButton(
        //
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SummaryAnswers(
                      index: 0,
                      answer: '',
                      correct: true,
                    )),
          );
        },
        child: Text(answers[1]),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
      TextButton(
        //
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SummaryAnswers(
                      index: 0,
                      answer: '',
                      correct: true,
                    )),
          );
        },
        child: Text(answers[2]),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // EventText text;
    // getText(widget.subject).then({return text;});
    // var textEvent =
    // EventText text = await getText(widget.subject);
    // getText(widget.subject).then((textEvent) {
    //   text = textEvent;
    //   return text;
    // });

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
              title: Text(widget.subject),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Settings',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Settings(title: 'Settings')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.home),
                  tooltip: 'Home',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'Home Page')),
                    );
                  },
                ),
              ],
            ),
            body: FutureBuilder<EventText>(
                future: getText(widget.subject),
                builder: (context, AsyncSnapshot<EventText> snapshot) {
                  if (snapshot.hasData) {
                    // return Text(snapshot.data);
                    // text = snapshot.data!;
                    return Column(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // SettingsButton(),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0)),

                              Text(
                                "Title goes here",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0)),
                              Text(
                                  //
                                  "This is where the story will be shown and the problem question asked.",
                                  style: Theme.of(context).textTheme.headline2),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0)),

                              Text(text.toString(),
                                  style: Theme.of(context).textTheme.headline2),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0)),
                              questions(context, text),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator(color: Colors.red,);
                  }
                }
                )
        )
    );
  }
}
