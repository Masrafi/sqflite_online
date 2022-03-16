import 'package:flutter/material.dart';

import 'add_data.dart';
import 'db/database.dart';
import 'model/model.dart';

class ShowData extends StatefulWidget {
  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: refreshNotes(),
        builder: (context, snapshot) {
          // if (snapshot.hasData) {
          //   studlist = notes;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              final st = notes[index];
              final color = _lightColors[index % _lightColors.length];
              return Container(
                // height: 70,
                decoration: BoxDecoration(
                  color: color,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Title: ${st.title}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Email: ${st.email}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Password: ${st.password}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Number: ${st.number}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Bool: ${st.isImportant}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Time: ${st.createdTime}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Description: ${st.description}',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ],
                ),
              );
            },
          );
          // }
          return new CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TextFieldTest()),
          );
        },
      ),
    );
  }
}

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];
