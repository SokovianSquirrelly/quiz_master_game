import 'dart:async';
import 'package:flutter/material.dart';

class QuizTimer extends StatefulWidget {
  const QuizTimer({super.key, required this.onTimeOut});
  final void Function() onTimeOut;

  @override
  State<QuizTimer> createState()  => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer> {
  Timer? countdownTimer;
  Duration duration = const Duration(seconds: 15);
  bool timeOut = false;

  @override
  void initState()
  {
    super.initState();
    countdownTimer = Timer.periodic(const Duration(seconds: 1),
            (_) => setCountdown());
  }

  void stopTimer()
  {
    setState(() => countdownTimer!.cancel());
  }

  void setCountdown()
  {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timeOut = true;
        countdownTimer!.cancel();
        widget.onTimeOut();
      }
      else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  bool isTimeOut()
  {
    return timeOut;
  }



  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(duration.inSeconds);
    return Text(
      seconds,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20),
    );
  }
}