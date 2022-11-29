import 'package:flutter/material.dart';
import 'package:quizmastergame/timer.dart';
import 'package:vibration/vibration.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Settings> createState() => _SettingsState();
}

bool _iconBool = false;

ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.light
);

ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark
);


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
                    onPressed: (){},
                    child: Text("Sound",),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0)),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        _iconBool = !_iconBool;
                      });
                    } ,
                    child: Text("Light / Dark")
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