import 'package:flutter/material.dart';
import 'package:sqflite_project/screens/note_list.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo App",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: NoteList(),
    );
  }
}
