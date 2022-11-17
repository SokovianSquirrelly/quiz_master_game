import 'package:flutter/material.dart';
import 'story_page.dart';

class GameChoice extends StatelessWidget {
  const GameChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child :Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),

                      );
                    },

                    child: const Text('Settings',
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size.fromWidth(125))
                    )
                ),
                Padding(padding: EdgeInsets.symmetric(vertical:0 ,horizontal: 10)),
                TextButton( //
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Back",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size.fromWidth(125))
                    )
                ),


              ],
            ),


            Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  Text('Choose a topic',
                    style: Theme.of(context).textTheme.headline1,),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                      );
                    },
                    child: const Text('Science'),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                      );
                    },
                    child: const Text('Math'),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                      );
                    },
                    child: const Text('Geography'),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                      );
                    },
                    child: const Text('Spelling'),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                      );
                    },
                    child: const Text('Programming'),),
                ],

              ),

            ),
          ]
      ),

    );

  }
}

// void main() => runApp(const MaterialApp(
//   home: GameChoice(),
// ));