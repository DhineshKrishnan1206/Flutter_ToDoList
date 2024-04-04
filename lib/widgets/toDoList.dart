import 'package:flutter/material.dart';

class ToDoListBuilder extends StatefulWidget {
  List<String> toDoList;
  void Function() updateLocalData;
  ToDoListBuilder(
      {super.key, required this.toDoList, required this.updateLocalData});

  @override
  State<ToDoListBuilder> createState() => _ToDoListBuilderState();
}

class _ToDoListBuilderState extends State<ToDoListBuilder> {
  void showBottomSheet({required int index}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.toDoList.removeAt(index);
                  });
                  widget.updateLocalData();
                  Navigator.pop(context);
                },
                child: const Text("Mark as Done")),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.toDoList.isEmpty)
        ? Center(
            child: Text("No Tasks Added",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          )
        : ListView.builder(
            itemCount: widget.toDoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                secondaryBackground: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.delete),
                      )
                    ],
                  ),
                  color: Colors.red[400],
                ),
                background: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.check),
                      )
                    ],
                  ),
                  color: Colors.green[400],
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    widget.toDoList.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    showBottomSheet(index: index);
                  },
                  title: Text(
                    widget.toDoList[index],
                    style: const TextStyle(
                        fontFamily: "Poppins", fontWeight: FontWeight.bold),
                  ),
                ),
              );
            });
  }
}
