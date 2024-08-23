// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Screens/InitialScreen.dart';

import 'Screens/PlayScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/playScreen': (context) => PlayScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: InitialScreen(),
    );
  }
}
