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

          TextButton( //
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Back"),
          ),
          TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade100)
            ),
            child: const Text('Settings')),

          Center(
            child: Column(
              children: [
                const Text('Choose a topic'),
                TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade100)
                    ),
                    child: const Text('Science'),),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                    );
                  },
                  child: const Text('Math'),),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                    );
                  },
                  child: const Text('Geography'),),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StoryPage(title: "Old Story")),
                    );
                  },
                  child: const Text('Spelling'),),
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