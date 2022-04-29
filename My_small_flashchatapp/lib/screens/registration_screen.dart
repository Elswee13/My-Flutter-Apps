import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flash_chat/components/rounded_button.dart';
import 'package:my_flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flash_chat/screens/chat_screen.dart';
import 'package:my_flash_chat/screens/welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Creating the instance for the firebase authorization, will use a private variable.
  final _auth = FirebaseAuth.instance;
  //variables for the email and password for the user.
  late String email;
  late String password;
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                        'images/logo.png',
                        color: Colors.deepOrange,
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
                      //Do something when the user inputs the email address.
                      email = value;
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
                      //Do something when the user inputs the password for his account.
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    colour: Colors.blueAccent,
                    title: 'Register',
                    onPressed: () async {
                      //state to call the progress variable to show when it touch register button
                      setState(() {
                        showProgress = true;
                      });
                      //here will be using the variable of auth to register the new user,
                      //in the database using Firebase.
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        //this condition is being used to check if newUser is = to null
                        if (newUser != null) {
                          Navigator.pushNamed(context, WelcomeScreen.id);
                        }
                        //state to stop the progress circle action
                        setState(() {
                          showProgress = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
