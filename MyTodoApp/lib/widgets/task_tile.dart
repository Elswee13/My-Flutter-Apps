import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String tasktitle;
  //adding void Function(bool?) fixed the error call of checkboxCallback cant be null.
  final void Function(bool?) checkboxCallback;
  final Function() longPressCallback;

  TaskTile({
    required this.isChecked,
    required this.tasktitle,
    required this.checkboxCallback,
    required this.longPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        tasktitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.indigo,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}

// (bool? checkboxState) {
// setState(() {
// isChecked = checkboxState ?? true;
// });
// },

// class TaskCheckBox extends StatelessWidget {
//   final bool checkboxState;
//   final Function(bool?) toggleCheckboxState;
//
//   TaskCheckBox(
//       {required this.checkboxState, required this.toggleCheckboxState});
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
