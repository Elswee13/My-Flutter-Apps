import 'dart:ui';
import 'package:mytodoapp/widgets/task_list.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/Screens/add_task_screen.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:mytodoapp/models/task_data.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo,
            Colors.purple.shade800,
            Colors.indigo.shade700,
            Colors.indigo.shade600,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(Icons.add),
          onPressed: () {
            //bottomsheet to add more task
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskScreen(),
                ),
              ),
            );
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 60,
                left: 30,
                right: 30,
                bottom: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Using CircleAvatar to make the circle shape for the icon,size,color inside this widget
                  CircleAvatar(
                    child: Icon(
                      Icons.list,
                      size: 30.0,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30.0,
                  ),
                  SizedBox(
                    //giving some space between title and icon
                    height: 10.0,
                  ),
                  Text(
                    'TodoApp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontFamily: 'Adieresis',
                    ),
                  ),
                  Text(
                    '${Provider.of<TaskData>(context).taskCount} Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 0.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: TaskList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//in case you make this taskscreen a statefull widget
//you can use this code in the AddScreen to add more task

// (newTaskTitle) {
// // setState(() {
// //   //code to add new task using the small add task window
// //   task.add(Task(name: newTaskTitle));
// // });
// Navigator.pop(context);
// }
