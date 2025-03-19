import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('assets/images/profile.webp'),
                  ),
                  IconButton(
                    onPressed: () {
                      print('Add Button Clicked');
                    },
                    icon: Icon(Icons.add, size: 40, color: Colors.white),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 현재날짜 표시(MONDAY 16)
                  Text(
                    DateFormat('EEEE d').format(DateTime.now()).toUpperCase(),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8.0),
                  // TODAY, 주일 표시
                  Row(
                    children: [
                      Text(
                        'TODAY',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(Icons.circle, size: 10, color: Color(0xFFB12680)),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 30,
                            itemBuilder: (context, index) {
                              final date = DateTime.now().add(
                                Duration(days: index + 1),
                              );
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  DateFormat('d').format(date),
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ScheduleCard(
                    title: 'DESIGN\nMEETING',
                    startTime: '11:30',
                    endTime: '12:20',
                    color: Color(0xFFFEF655),
                    textColor: Colors.black,
                    members: ['ALEX', 'HELENA', 'NANA'],
                  ),
                  SizedBox(height: 16.0),
                  ScheduleCard(
                    title: 'DAILY\nPROJECT',
                    startTime: '12:35',
                    endTime: '14:10',
                    color: Color(0xFF956DC8),
                    textColor: Colors.black,
                    members: ['ME', 'RICHARD', 'CIRY', '+4'],
                  ),
                  SizedBox(height: 16.0),
                  ScheduleCard(
                    title: 'WEEKLY\nPLANNING',
                    startTime: '15:00',
                    endTime: '16:30',
                    color: Color(0xFFC6ED67),
                    textColor: Colors.black,
                    members: ['DEN', 'NANA', 'MARK'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String title, startTime, endTime;
  final Color color;
  final Color textColor;
  final List<String> members;

  const ScheduleCard({
    super.key,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.textColor,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.0,
                child: Column(
                  children: [
                    Text(
                      startTime.split(':')[0],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        height: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      startTime.split(':')[1],
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.0,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      width: 1,
                      height: 20,
                      color: Colors.black,
                    ),
                    Text(
                      endTime.split(':')[0],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      endTime.split(':')[1],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 52,
                  height: 0.9,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 56.0),
            child: Row(
              children: [
                ...members.map((name) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            name == 'ME'
                                ? textColor
                                : Colors.black.withValues(alpha: 0.5),
                        fontWeight:
                            name == 'ME' ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
