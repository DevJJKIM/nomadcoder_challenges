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
      home: PomodoroTimer(),
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

  void resetTimer() {
    setState(() {
      isRunning = false;
      currentTime = selectedTime * 60;
    });
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
    timer?.cancel();
  }

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

  Widget _buildTimeButton(int time) {
    final isSelected = selectedTime == time;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTime = time;
            currentTime = time * 60;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            time.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: isSelected ? Color(0xFFE64D3D) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final minutes = currentTime ~/ 60;
    final seconds = currentTime % 60;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'POMOTIMER',
                    style: TextStyle(
                      fontSize: 20,
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
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Center(
                      child: Text(
                        minutes.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 65,
                          color: Color(0xFFE64D3D),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 65,
                      color: Colors.white.withValues(alpha: 0.5),
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
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Center(
                      child: Text(
                        seconds.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 65,
                          color: Color(0xFFE64D3D),
                          fontWeight: FontWeight.w800,
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
                    onPressed: startTimer,
                    iconSize: 90,
                    icon:
                        isRunning
                            ? Icon(Icons.pause_circle_outlined)
                            : Icon(Icons.play_circle_outlined),
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: resetTimer,
                    iconSize: 90,
                    icon: Icon(Icons.refresh),
                    color: Colors.white,
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
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ROUND',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 24,
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
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'GOAL',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 24,
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
    );
  }
}
