import 'package:flutter/material.dart';

import 'db/notes_databases.dart';
import 'model/note.dart';

class TextFieldTest extends StatefulWidget {
  const TextFieldTest({Key? key}) : super(key: key);

  @override
  _TextFieldTestState createState() => _TextFieldTestState();
}

class _TextFieldTestState extends State<TextFieldTest> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();
  TextEditingController nameController4 = TextEditingController();
  TextEditingController nameController5 = TextEditingController();

  late int num;

  Future addNote() async {
    final note = Note(
      title: nameController1.text,
      isImportant: true,
      number: num,
      description: nameController3.text,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: ListView(
          children: [
            TextField(
              controller: nameController1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            TextField(
              controller: nameController2,
              onChanged: (value) {
                num = int.parse(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            TextField(
              controller: nameController3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            TextField(
              controller: nameController4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            GestureDetector(
              child: Text("Click"),
              onTap: () {
                addNote();
              },
            )
          ],
        ),
      ),
    );
  }
}
