import 'package:flutter/material.dart';
import 'package:note/screen/HomeScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => const HomeScreen(),
    },
  ));
}
