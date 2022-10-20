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
            onPressed: null,
            child: Text('Settings'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade100)
            ),),

          Center(
            child: Column(
              children: [
                Text('Choose a topic'),
                TextButton(
                    onPressed: null,
                    child: Text('Science'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade100)
                    ),),
                TextButton(
                  onPressed: null,
                  child: Text('Math'),),
                TextButton(
                  onPressed: null,
                  child: Text('Geography'),),
                TextButton(
                  onPressed: null,
                  child: Text('Spelling'),),
                TextButton(
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

void main() => runApp(MaterialApp(
  home: GameChoice(),
));