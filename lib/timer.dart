import 'dart:async';

class QuizTimer {
  Timer? timer;


  QuizTimer()
  {
    timer = Timer.periodic(const Duration(seconds: 15),
            (Timer t) => handleTimeout());
  }

  handleTimeout()
  {

  }

  void stopTimer()
  {
    timer?.cancel();
  }
}