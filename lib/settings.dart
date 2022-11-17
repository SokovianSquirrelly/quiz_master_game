import 'package:flutter/material.dart';
import 'package:quizmastergame/timer.dart';
import 'package:vibration/vibration.dart';

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
  IconData _iconLight = Icons.wb_sunny;
  IconData _iconDark = Icons.nights_stay;

  ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.light
  );

  ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark
  )


  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
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
                  Padding(padding: EdgeInsets.symmetric(vertical: 70,horizontal: 0)),
                  TextButton(
                    onPressed: null,
                    child: Text("Sound",),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        _iconBool = !_iconBool;
                      });
                    } ,
                    child: Text("Night Mode",),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){

                    },
                    child: Text("Timer",),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      Vibration.vibrate(duration: 1000, amplitude: 128);
                    },
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