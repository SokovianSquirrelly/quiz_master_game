import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmastergame/dark_mode.dart';
import 'home_page.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(
          builder: (context, ThemeModel themeNotifier, child){
            return MaterialApp(
                theme: themeNotifier.isDark? ThemeData(
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.green.shade600,
                    ),
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
                ) :
                ThemeData(
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.grey,
                      iconTheme: IconThemeData(
                          color: Colors.black

                      ),

                    ),
                    scaffoldBackgroundColor: Colors.black26,
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
                  body: MyHomePage(title: "Home Page"),
                )
            );
          }
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Consumer<ThemeModel> build(BuildContext context){
    return Consumer(
        builder: (context, ThemeModel themeNotifier, child){
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
    );
  }
}