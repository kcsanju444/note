import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note/constants/colors.dart';
import 'package:note/model/note.dart';
import 'package:note/screen/EditScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;
  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  List<Note> sortNoteByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort(((a, b) => a.modifiedTime.compareTo(b.modifiedTime)));
    } else {
      notes.sort(((a, b) => a.modifiedTime.compareTo(b.modifiedTime)));
    }
    sorted = !sorted;
    return notes;
  }

  getrandomColor() {
    Random random = Random();
    return backgroundColor[random.nextInt(backgroundColor.length)];
  }

  void onsearchTextChange(String searchText) {
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int index) {
    setState(() {
      Note note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        filteredNotes = sortNoteByModifiedTime(filteredNotes);
                      });
                    },
                    icon: Container(
                      width: 40,
                      height: 40,
                      // decoration: BoxDecoration(color: Colors.white),
                      child: const Icon(
                        Icons.sort,
                        color: Colors.black,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: onsearchTextChange,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Search notes...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Color.fromARGB(48, 0, 0, 0))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent))),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: getrandomColor(),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditScreen(note: filteredNotes[index]),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            int originalIndex =
                                sampleNotes.indexOf(filteredNotes[index]);

                            sampleNotes[originalIndex] = Note(
                                id: sampleNotes[originalIndex].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());

                            filteredNotes[index] = Note(
                                id: filteredNotes[index].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());
                          });
                        }
                      },
                      title: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: '${filteredNotes[index].title}\n',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.5),
                            children: [
                              TextSpan(
                                text: '${filteredNotes[index].content}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ]),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${filteredNotes[index].modifiedTime}',
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            final result = await confirmdialog(context);
                            if (result != null && result) {
                              deleteNote(index);
                            }
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const EditScreen()),
          );
          if (result != null) {
            setState(() {
              sampleNotes.add(Note(
                  id: sampleNotes.length,
                  title: result[0],
                  content: result[1],
                  modifiedTime: DateTime.now()));
              filteredNotes = sampleNotes;
            });
          }
        },
        backgroundColor: Colors.grey,
        elevation: 20,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  Future<dynamic> confirmdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const SizedBox(
                        width: 60,
                        child: const Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ))),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const SizedBox(
                        width: 60,
                        child: const Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
          );
        });
  }
}
