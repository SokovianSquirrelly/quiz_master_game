//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'home_page.dart';

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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
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
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Container(
      //         height: 70.0,
      //         width: 160,
      //         decoration: BoxDecoration(
      //             color: Colors.grey,
      //             borderRadius: BorderRadius.circular(50)),
      //         margin: const EdgeInsets.all(40),
      //         child: const Text("SETTINGS",
      //           style: TextStyle(fontSize: 30, color: Colors.brown, height: 1.8),
      //           textAlign: TextAlign.center,),
      //         // Row is a horizontal, linear layout.
      //       ),
      //       Container(
      //         height: 60.0, // in logical pixels
      //         width: 120,
      //         decoration: const BoxDecoration(color: Colors.grey),
      //         margin: const EdgeInsets.all(30),
      //         child: const Text("SOUND",
      //           style: TextStyle(fontSize: 27,color: Colors.deepPurple, height: 1.8),
      //           textAlign: TextAlign.center,),
      //       ),
      //       Container(
      //         height: 60.0, // in logical pixels
      //         width: 120,
      //         decoration: const BoxDecoration(color: Colors.grey),
      //         margin: const EdgeInsets.all(30),
      //         child: const Text("NIGHT MODE",
      //           style: TextStyle(fontSize: 27,color: Colors.deepPurple),
      //           textAlign: TextAlign.center,),
      //       ),
      //       Container(
      //         height: 60.0, // in logical pixels
      //         width: 120,
      //         decoration: const BoxDecoration(color: Colors.grey),
      //         margin: const EdgeInsets.all(30),
      //         child: const Text("TIMER",
      //           style: TextStyle(fontSize: 27,color: Colors.deepPurple, height: 1.8),
      //           textAlign: TextAlign.center,),
      //       ),
      //       Container(
      //         height: 60.0, // in logical pixels
      //         width: 120,
      //         decoration: const BoxDecoration(color: Colors.grey),
      //         margin: const EdgeInsets.all(30),
      //         child: const Text("RUMBLE",
      //             style: TextStyle(fontSize: 27,color: Colors.deepPurple, height: 1.8),
      //             textAlign: TextAlign.center),
      body: Column(
        children: [
          // Row(
          //   children: [
          //     TextButton(onPressed: null,
          //           style: ButtonStyle(
          //               fixedSize: MaterialStateProperty.all(const Size.fromWidth(125))
          //           ), child: const Text("Settings",
          //         style: TextStyle(
          //           fontSize: 20,
          //         ),)),
          //     const Padding(padding: EdgeInsets.symmetric(vertical:0 ,horizontal: 10)),
          //     TextButton(onPressed: null,
          //         style: ButtonStyle(
          //             fixedSize: MaterialStateProperty.all(const Size.fromWidth(125))
          //         ), child: const Text("Back",
          //       style: TextStyle(
          //         fontSize: 20,
          //       ),)),
          //     const Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
          //   ],
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
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
        ],
      ),
      // ),
    );
  }
}