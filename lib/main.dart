import 'package:flutter/material.dart';
import 'package:note/model/NoteOperation.dart';
import 'package:note/model/note.dart';
import 'package:note/screen/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<NoteOperation>(
    create: (context) => NoteOperation(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    ),
  ));
}
