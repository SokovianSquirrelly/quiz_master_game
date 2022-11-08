import 'package:flutter/material.dart';
import 'summary_answers.dart';

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset('assets/simple-background.png'), //   <-- image
              // SettingsButton(),
              TextButton( //
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              ),
              const Text(
                'Title goes here',
              ),
              const Text( //
                "This is where the story will be shown and the problem question asked.",
              ),
              TextButton( //
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                  );
                },
                child: const Text("Answer 1"),
              ),
              TextButton( //
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                  );
                },
                child: const Text("Answer 2"),
              ),
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
      )
    return Scaffold(


      body: Column(
        children: [
          Row(
            children: [
              TextButton(onPressed: null, child: Text("Settings",
                style: TextStyle(
                  fontSize: 20,
                ),),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(125))
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical:0 ,horizontal: 10)),
              TextButton(onPressed: null, child: Text("Back",
                style: TextStyle(
                  fontSize: 20,
                ),),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(125))
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SettingsButton(),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                Text(
                  "Title goes here",
                    style: Theme.of(context).textTheme.headline1,),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                Text( //
                    "This is where the story will be shown and the problem question asked.",
                    style: Theme.of(context).textTheme.headline2),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                TextButton( //
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                    );
                  },
                  child: const Text("Answer 1"),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                TextButton( //
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SummaryAnswers(index: 0)),
                    );
                  },
                  child: const Text("Answer 2"),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),

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

    );
  }
}

