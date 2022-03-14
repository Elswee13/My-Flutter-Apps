import 'package:flutter/material.dart';

//the main function is the starting point for all flutter apps.

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[600],
        appBar: AppBar(
          title: Center(
            child: Text('I am Rich'),
          ),
          backgroundColor: Colors.grey[700],
        ),
        body: Center(
          child: Image(image: AssetImage('images/diamond.png')
              //   NetworkImage('https://www.teahub.io/photos/full/34-349685_hot-original-anime-elf-girl-wallpaper-cool-hot.jpg'),
              ),
        ),
      ),
    ),
  );
}
