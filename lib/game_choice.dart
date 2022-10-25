import 'package:flutter/material.dart';
class GameChoice extends StatelessWidget {
  const GameChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: (){},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade100)
            ),
            child: const Text('Settings')),

          Center(
            child: Column(
              children: [
                const Text('Choose a topic'),
                TextButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade100)
                    ),
                    child: const Text('Science'),),
                const TextButton(
                  onPressed: null,
                  child: Text('Math'),),
                const TextButton(
                  onPressed: null,
                  child: Text('Geography'),),
                const TextButton(
                  onPressed: null,
                  child: Text('Spelling'),),
                const TextButton(
                  onPressed: null,
                  child: Text('Programming'),),
              ],

          ),
            
        ),
        ]
      ),

    );

  }
}

void main() => runApp(const MaterialApp(
  home: GameChoice(),
));