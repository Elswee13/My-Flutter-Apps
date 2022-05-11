import 'package:flutter/material.dart';
import 'package:mytodoapp/models/task_data.dart';
import 'package:provider/provider.dart';
import 'Screens/TaskScreen.dart';
import 'package:mytodoapp/models/task_data.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
