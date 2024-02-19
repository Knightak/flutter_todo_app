import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/app_button.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  Dialogbox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 242, 168, 255),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            //button - save+ cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                AppButton(text: "Save", onPressed: onSave),
                SizedBox(
                  width: 10,
                ),
                //cancel button
                AppButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
