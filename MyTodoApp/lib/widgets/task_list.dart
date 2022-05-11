import 'package:flutter/material.dart';
import 'package:mytodoapp/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:mytodoapp/Screens/TaskScreen.dart';
import 'package:mytodoapp/models/task_data.dart';

//without using provider
// import 'package:mytodoapp/models/task_dart.dart';

class TaskList extends StatelessWidget {
  //without using the provider:
  // final List<Task> task;
  // //initialazing the task property variable
  // TaskList(this.task);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              isChecked: task.isDone,
              // without using the provider: widget.task[index].isDone
              tasktitle: task.name,
              //without using the provider: widget.task[index].name
              checkboxCallback: (checkboxState) {
                //using the provider plugin
                taskData.updateTask(task);
                // setState(() {
                //   // without using the provider: widget.task[index].toggleDone()
                // });
              },
              longPressCallback: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCount,
          // without using the provider: widget.task.length
        );
      },
    );
  }
}
