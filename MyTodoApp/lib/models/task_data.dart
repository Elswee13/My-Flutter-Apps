import 'package:flutter/foundation.dart';
import 'package:mytodoapp/models/task_dart.dart';
import 'dart:collection';

//this class is created to listen for any changes made by the user
class TaskData extends ChangeNotifier {
  List<Task> _task = [
    Task(name: 'Buy Chops'),
    Task(name: 'Buy Detergent'),
  ];

  //get the tasks list
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_task);
  }

//get the amount of task in the tasklist
  int get taskCount {
    return _task.length;
  }

  //method to add task
  void addTask(String newTaskTitle) {
    final tasks = Task(name: newTaskTitle);
    _task.add(tasks);
    notifyListeners();
  }

  //method to update the task using the checkbox
  void updateTask(Task tasks) {
    tasks.toggleDone();
    notifyListeners();
  }

  //method to delete data from the tasklist
  void deleteTask(Task tasks) {
    _task.remove(tasks);
    notifyListeners();
  }
}
