import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/dialog_box.dart';
import 'package:flutter_todo_app/pages/todo_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //text controlar
  final _controller = TextEditingController();

  //checkbox taped
  void checkBoxChanged(bool? value, index) {
    setState(() {
      TodoList[index][1] = !TodoList[index][1];
    });
  }

  //create new task
  void createNewTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          onSave: () => saveNewTask(this.context),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // save new task
  Future<void> saveNewTask(
    context,
  ) async {
    setState(() {
      TodoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.pop(context as BuildContext, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Text('TO DO'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Color.fromARGB(255, 242, 168, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(context),
        backgroundColor: Color.fromARGB(255, 242, 168, 255),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: TodoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: TodoList[index][0],
            taskCompleted: TodoList[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
          );
        },
      ),
    );
  }
}
