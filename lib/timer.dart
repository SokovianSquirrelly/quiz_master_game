import 'dart:async';
import 'package:flutter/material.dart';

class _CountdownTimer extends State {
  Timer? countdownTimer;
  Duration duration = const Duration(seconds: 15);
  bool timeOut = false;

  void initState()
  {
    super.initState();
  }

  void startTimer()
  {
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
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            seconds,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 50),
            ),
            const SizedBox(height: 20)
        ]
      )
    ));
  }
}