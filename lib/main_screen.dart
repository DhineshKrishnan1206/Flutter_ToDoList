import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:todoapp/addToDo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/widgets/toDoList.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> list = [];
  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void addToDo({required String toDoText}) {
    if (list.contains(toDoText)) {
      print("Already Exsists");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already Exsits"),
              content: Text("This Task Already Exsits"),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close"))
              ],
            );
          });
      return;
    }
    setState(() {
      list.insert(0, toDoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('toDoList', list);
  }

  void getLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    list = (prefs.getStringList("toDoList") ?? []).toList();
    setState(() {});
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              child: AddToDo(
                addToDo: addToDo,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.grey[900],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: showBottomSheet),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blueGrey[600],
              child: Center(
                  child: Text(
                "Drawer",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://google.com"));
              },
              leading: Icon(Icons.person),
              title: Text("About Me",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  )),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("mailto:dhineshd68@gmail.com"));
              },
              leading: Icon(Icons.person),
              title: Text("Contact Me",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Todo App",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: showBottomSheet,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(FeatherIcons.plus),
            ),
          )
        ],
      ),
      body: Container(
          child: ToDoListBuilder(
        toDoList: list,
        updateLocalData: updateLocalData,
      )),
    );
  }
}
