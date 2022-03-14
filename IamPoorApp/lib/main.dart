import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: NewGradientAppBar(
            title: Center(
              child: Text('I am Poor'),
            ),
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.cyan, Colors.greenAccent])),
        // backgroundColor: Colors.purpleAccent,
        body: Center(
          child: Image(
            image: AssetImage('images/BGBody.jpg'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Container(
            width: 60,
            height: 60,
            child: Icon(Icons.navigation),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.cyan, Colors.greenAccent])),
          ),
        ),
      ),
    ),
  );
}
