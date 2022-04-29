import 'package:flutter/material.dart';
import 'package:my_flash_chat/components/rounded_button.dart';
import 'package:my_flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Creating the instance for the firebase authorization, will use a private variable.
  final _auth = FirebaseAuth.instance;
  //variables for the email and password for the user.
  late String LogInEmail;
  late String LogInPassword;
  //this variable is for the progress or loading circle appears
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showProgress,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            //dont use this child in case of using Flexible widget in the hero widget
            // child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                        'images/logo.png',
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    LogInEmail = value;
                    //get the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  //in case to use a different style of character for password use the code below.
                  // obscuringCharacter: '*',
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    LogInPassword = value;
                    //get the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Login',
                  onPressed: () async {
                    //state to call the progress variable to show when it touch login button
                    setState(() {
                      showProgress = true;
                    });
                    //here will be using the variable of auth to login the user,
                    //in the database using Firebase.
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: LogInEmail, password: LogInPassword);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      //state to stop the progress circle action
                      setState(() {
                        showProgress = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
