import 'dart:html';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade600),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                fixedSize: MaterialStateProperty.all(const Size.fromWidth(325)),
              ),
            ),
            textTheme: TextTheme(
              button: const TextStyle(
                fontSize: 30,
                fontFamily: "Cambria",
              ),
              headline2: TextStyle(
                fontSize: 30,
                color: Colors.green.shade600,
                fontFamily: "Cambria",
                fontWeight: FontWeight.w500,
              ),
              headline1: TextStyle(
                fontSize: 50,
                color: Colors.green.shade600,
                fontFamily: "Cambria",
                fontWeight: FontWeight.w500,

              ),

            )
        ),
        darkTheme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black
              ),

            ),
            scaffoldBackgroundColor: Colors.blueGrey,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                fixedSize: MaterialStateProperty.all(const Size.fromWidth(325)),
              ),
            ),
            textTheme: TextTheme(
              button: const TextStyle(
                fontSize: 30,
                fontFamily: "Cambria",
              ),
              headline2: TextStyle(
                fontSize: 30,
                color: Colors.grey,
                fontFamily: "Cambria",
                fontWeight: FontWeight.w500,
              ),
              headline1: TextStyle(
                fontSize: 50,
                color: Colors.grey,
                fontFamily: "Cambria",
                fontWeight: FontWeight.w500,

              ),

            )
        ),
        title: "Quiz Master",
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          // appBar: AppBar(
          //     title: const Text('App bar'),
          //     actions: <Widget>[
          //       IconButton(
          //         icon: const Icon(Icons.settings),
          //         tooltip: 'Settings',
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => const Settings(title: 'Settings')),
          //           );
          //         },
          //       ),
          //     ]
          // ),
          body: MyHomePage(title: "Home Page"),
        )
      // Scaffold()
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  PreferredSizeWidget build(BuildContext context){
    return AppBar(
      title: const Text('App bar'),
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
          icon: const Icon(Icons.navigate_next),
          tooltip: 'Go to the next page',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Next page'),
                  ),
                  body: const Center(
                    child: Text(
                      'This is the next page',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ],
    );
  }
}