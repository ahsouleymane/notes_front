import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes_front/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Django Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retrieveNotes();
    super.initState();
  }

  _retrieveNotes() async {
    notes = [];

    List response = json.decode((await client.get(retrieveUrl)).body);
    response.forEach((element) { 
      notes.add(Note.fromMap(element));
    });
  }

  void _addNote() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(notes[index].note),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
