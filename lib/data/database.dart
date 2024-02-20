// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:hive_flutter/hive_flutter.dart';

class todoDatebase {
  List TodoList = [];
  //reference the box
  final _myBox = Hive.box('mybox');
// run this for 1st time open the app
  void creatIntialData() {
    TodoList = [
      ['Do Something New', false],
      ['Learn Something New', false],
    ];
  }

  //load the data from database
  void loadData() {
    TodoList = _myBox.get('TODOLIST');
  }

  //update database
  void updateDataBase() {
    _myBox.put('TODOLIST', TodoList);
  }
}
