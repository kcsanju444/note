import 'package:flutter/material.dart';
import 'package:note/model/note.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _contentcontroller = TextEditingController();
  @override
  void initState() {
    if (widget.note != null) {
      _titlecontroller = TextEditingController(text: widget.note!.title);
      _contentcontroller = TextEditingController(text: widget.note!.title);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.white),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                    ))
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                TextField(
                  controller: _titlecontroller,
                  style: TextStyle(color: Colors.black87, fontSize: 30),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 30)),
                ),
                TextField(
                  controller: _contentcontroller,
                  style: TextStyle(color: Colors.black87, fontSize: 30),
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something...',
                      hintStyle: TextStyle(color: Colors.black87)),
                )
              
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
              context, [_titlecontroller.text, _contentcontroller.text]);
        },
        elevation: 10,
        backgroundColor: Colors.grey,
        child: Icon(Icons.save),
      ),
    );
  }
}
