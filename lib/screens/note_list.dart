import 'package:flutter/material.dart';
import 'dart:async';
import '../databse_helper.dart';
import '../note.dart';
import 'note_details.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          "TaskMe",
        ),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () {
          navigationToDetails(Note('', '', 2), "Add Note");
        },
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, position) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.00),
            ),
            color: Colors.deepPurple,
            elevation: 4.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/originals/31/14/5e/31145e7925e59e8fb344f13422435dba.jpg"),
              ),
              title: Text(
                this.noteList[position].title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              subtitle: Text(
                this.noteList[position].date,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.open_in_new,
                  color: Colors.white,
                ),
                onTap: () {
                  navigationToDetails(this.noteList[position], "Edit Task");
                },
              ),
            ),
          );
        });
  }

  void navigationToDetails(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
