import 'dart:async';

void main()
{
  scheduleTimeout(5 * 1000); // 5 seconds.
}

Timer scheduleTimeout([int milliseconds = 10000]) =>
    Timer(Duration(milliseconds: milliseconds), handleTimeout);

void handleTimeout()
{  // callback function
  // Do some work.
}