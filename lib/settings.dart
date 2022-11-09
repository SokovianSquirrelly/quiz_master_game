import 'dart:ffi';

import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                        // fixedSize: MaterialStateProperty.all(Size.fromWidth(125))
                    )),
              Padding(padding: EdgeInsets.symmetric(vertical:0 ,horizontal: 10)),
              TextButton(onPressed: null, child: Text("Back",
                style: TextStyle(
                  fontSize: 20,
                ),),
                  style: ButtonStyle(
                      // fixedSize: MaterialStateProperty.all(Size.fromWidth(125))
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(vertical: 70,horizontal: 0)),
                TextButton(
                  onPressed: null,
                  child: Text("Sound",),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                TextButton(
                  onPressed: null ,
                  child: Text("Night Mode",),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                TextButton(
                  onPressed: null,
                  child: Text("Timer",),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                TextButton(
                  onPressed: null,
                  child: Text("Rumble",),
                ),

              ],
            ),

          ),
        ]
      ),
    );
  }
}