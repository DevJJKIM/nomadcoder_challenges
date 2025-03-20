import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFE64D3D)),
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(children: [Text('POMOTIMER')]),
            ],
          ),
        ),
      ),
    );
  }
}
