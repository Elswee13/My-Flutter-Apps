import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(
    home: BallPage(),
  ));
}

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        shadowColor: Colors.indigo.shade900,
        title: Center(
          child: Text('Ask me Anything'),
        ),
      ),
      body: Ball(),
    );
  }
}

// this class is the state before start randomizing the option whats going to appear
class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

//this class is where starts from 1 to 5 to select the answer for the user tap
class _BallState extends State<Ball> {
  int Ballnumber = 1;
  void ChangeBall() {
    setState(() {
      Ballnumber = Random().nextInt(5) + 1;
    });
  }

//this is where the user press the tap button and calls the method to change the image of the ball
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
                onPressed: () {
                  ChangeBall();
                },
                child: Image.asset('images/ball$Ballnumber.png')),
          ),
        ],
      ),
    );
  }
}
