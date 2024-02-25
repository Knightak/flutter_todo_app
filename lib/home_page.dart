// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/database.dart';
import 'package:flutter_todo_app/pages/dialog_box.dart';
import 'package:flutter_todo_app/pages/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  todoDatebase db = todoDatebase();

  @override
  void initState() {
    super.initState();
    //for the 1st time create defult data
    if (_myBox.get('TODOLIST') == null) {
      db.creatIntialData();
    } else {
      //thir already exists data
      db.loadData();
    }
  }

  //text controlar
  final _controller = TextEditingController();

  //checkbox taped
  void checkBoxChanged(bool? value, index) {
    setState(() {
      db.TodoList[index][1] = !db.TodoList[index][1];
    });
    db.updateDataBase();
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
    if (_controller.text != '') {
      setState(() {
        db.TodoList.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.pop(context as BuildContext, true);
      db.updateDataBase();
    } else {
      if (kDebugMode) {
        print("the input box can't be blank");
      }
    }
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.TodoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 242, 168, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(context),
        backgroundColor: const Color.fromARGB(255, 242, 168, 255),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: db.TodoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.TodoList[index][0],
            taskCompleted: db.TodoList[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            deleteFunction: (contex) => deleteTask(index),
          );
        },
      ),
    );
  }
}
