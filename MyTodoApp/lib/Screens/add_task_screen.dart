import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/models/task_dart.dart';
import 'package:provider/provider.dart';
import 'package:mytodoapp/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 25.0,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                onPrimary: Colors.white,
              ),
              child: Text(
                'Add',
                style: TextStyle(),
              ),
              onPressed: () {
                //this method is using the provider plugin
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskTitle!);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

//if i use statefull widget in taskscreen declare this variables and method in this screen
//this in the top of the override return

//  final void Function(String) addTaskCallBack;
//
//   AddTaskScreen(this.addTaskCallBack);

//this in the onPressed method in TextStyle
//add our task to the list
// addTaskCallBack(newTaskTitle!);
