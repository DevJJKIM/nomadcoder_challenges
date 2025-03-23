import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFE64D3D)),
      home: const PomodoroTimer(),
    );
  }
}

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int selectedTime = 25;
  int currentTime = 25 * 60; // 초 단위로 변환
  int currentCycle = 0;
  int currentRound = 0;
  bool isRunning = false;
  bool isBreak = false;
  Timer? timer;

  void startTimer() {
    if (isRunning) {
      pauseTimer();
    } else {
      setState(() {
        isRunning = true;
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (currentTime > 0) {
            currentTime--;
          } else {
            if (isBreak) {
              // 휴식 시간 종료
              isBreak = false;
              currentTime = selectedTime * 60;
              currentCycle++;
              if (currentCycle >= 4) {
                currentRound++;
                currentCycle = 0;
                isBreak = true;
                currentTime = 5 * 60; // 5분 휴식
              }
            } else {
              // 작업 시간 종료
              isBreak = true;
              currentTime = 5 * 60; // 5분 휴식
            }
          }
        });
      });
    }
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
    timer?.cancel();
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      isBreak = false;
      currentTime = selectedTime * 60;
      currentCycle = 0;
      currentRound = 0;
    });
    timer?.cancel();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildTimeButton(int time) {
    final isSelected = selectedTime == time;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTime = time;
            if (!isRunning) {
              currentTime = time * 60;
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected
                    ? Colors.white
                    : Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text(
            time.toString(),
            style: TextStyle(
              color:
                  isSelected
                      ? Color(0xFFE64D3D)
                      : Colors.white.withOpacity(0.5),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = currentTime ~/ 60;
    final seconds = currentTime % 60;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'POMOTIMER',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 35,
                        horizontal: 15,
                      ),
                      child: Center(
                        child: Text(
                          minutes.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: Color(0xFFE64D3D),
                            fontSize: 65,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      ':',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 65,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 35,
                        horizontal: 15,
                      ),
                      child: Center(
                        child: Text(
                          seconds.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: Color(0xFFE64D3D),
                            fontSize: 65,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeButton(15),
                      _buildTimeButton(20),
                      _buildTimeButton(25),
                      _buildTimeButton(30),
                      _buildTimeButton(35),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 90,
                      color: Colors.white,
                      onPressed: startTimer,
                      icon: Icon(
                        isRunning
                            ? Icons.pause_circle_outlined
                            : Icons.play_circle_outline,
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      iconSize: 90,
                      color: Colors.white,
                      onPressed: resetTimer,
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$currentCycle/4',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'ROUND',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$currentRound/12',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'GOAL',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isBreak) ...[
                  SizedBox(height: 20),
                  Text(
                    '휴식 시간',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
