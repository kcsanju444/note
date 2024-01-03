import 'dart:collection';

import 'package:flutter/material.dart';
import 'note.dart';

class NoteOperation extends ChangeNotifier {
  final List<Note> _notes = [];

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
