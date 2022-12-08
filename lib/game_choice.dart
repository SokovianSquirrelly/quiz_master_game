import 'package:flutter/material.dart';
import 'story_page.dart';
import 'settings.dart';
import 'home_page.dart';

class GameChoice extends StatelessWidget {
  const GameChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/images/green-correct.png'),
      //       fit: BoxFit.cover
      //   ),
      // ),
      // color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.green.shade600,
          title: const Text("Choose Game"),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     TextButton(
              //         onPressed: (){
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
              //
              //           );
              //         },
              //         style: ButtonStyle(
              //             fixedSize: MaterialStateProperty.all(const Size.fromWidth(125))
              //         ),
              //
              //         child: const Text(
              //           'Settings',
              //           style: TextStyle(
              //             fontSize: 20,
              //           ),
              //         )
              //     ),
              //     const Padding(padding: EdgeInsets.symmetric(vertical:0 ,horizontal: 10)),
              //     TextButton( //
              //         onPressed: (){
              //           Navigator.pop(context);
              //         },
              //         style: ButtonStyle(
              //             fixedSize: MaterialStateProperty.all(const Size.fromWidth(125))
              //         ),
              //         child: const Text("Back",
              //           style: TextStyle(
              //             fontSize: 20,
              //           ),
              //         )
              //     ),
              //   ],
              // ),
              Center(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    Text('Choose a topic',
                      style: Theme.of(context).textTheme.headline1,),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StoryPage(subject: "science")),
                        );
                      },
                      child: const Text('Science'),),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StoryPage(subject: "math")),
                        );
                      },
                      child: const Text('Math'),),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StoryPage(subject: "geography")),
                        );
                      },
                      child: const Text('Geography'),),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StoryPage(subject: "spelling")),
                        );
                      },
                      child: const Text('Spelling'),),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StoryPage(subject: "programming")),
                        );
                      },
                      child: const Text('Programming'),),
                  ],

                ),

              ),
            ]
        ),
      ),

    );

  }
}

// void main() => runApp(const MaterialApp(
//   home: GameChoice(),
// ));