import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/notes_databases.dart';
import '../model/note.dart';
import '../text_field_test.dart';
import '../widget/note_card_widget.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() =>
      // FutureBuilder(
      //   future: refreshNotes(),
      //   builder: (context, snapshot) {
      //     // if (snapshot.hasData) {
      //     //   studlist = notes;
      //     return ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: notes.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         final st = notes[index];
      //         return Card(
      //           child: Row(
      //             children: <Widget>[
      //               Container(
      //                 width: 50,
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: <Widget>[
      //                     Text(
      //                       'Name: ${st.title}',
      //                       style: TextStyle(fontSize: 15),
      //                     ),
      //                     Text(
      //                       'Course: ${st.description}',
      //                       style:
      //                           TextStyle(fontSize: 15, color: Colors.black54),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               IconButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => TextFieldTest()));
      //                 },
      //                 icon: Icon(
      //                   Icons.edit,
      //                   color: Colors.blueAccent,
      //                 ),
      //               ),
      //               IconButton(
      //                 onPressed: () {
      //                   // notes.deleteStudent(st.id);
      //                   // setState(() {
      //                   //   studlist.removeAt(index);
      //                   // });
      //                 },
      //                 icon: Icon(
      //                   Icons.delete,
      //                   color: Colors.red,
      //                 ),
      //               )
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //     // }
      //     return new CircularProgressIndicator();
      //   },
      // );

      StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
