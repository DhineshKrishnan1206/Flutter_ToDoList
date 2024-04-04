import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  void Function({required String toDoText}) addToDo;

  AddToDo({super.key, required this.addToDo});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

TextEditingController toDoText = TextEditingController();

class _AddToDoState extends State<AddToDo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("AddTo Do"),
        TextField(
          onSubmitted: (value) {
            if (toDoText.text.isNotEmpty) {
              widget.addToDo(toDoText: toDoText.text);
              toDoText.text = "";
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
          ),
          controller: toDoText,
        ),
        ElevatedButton(
            onPressed: () {
              print(toDoText.text);

              if (toDoText.text.isNotEmpty) {
                widget.addToDo(toDoText: toDoText.text);
                toDoText.text = "";
              }
            },
            child: Text("Add Task"))
      ],
    );
  }
}
