import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flash_chat/screens/welcome_screen.dart';
import 'package:my_flash_chat/screens/login_screen.dart';
import 'package:my_flash_chat/screens/registration_screen.dart';
import 'package:my_flash_chat/screens/chat_screen.dart';

// void main() => runApp(FlashChat());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        WelcomeScreen.id: (context) => WelcomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        LoginScreen.id: (context) => LoginScreen(),
        // When navigating to the "/third" route, build the SecondScreen widget.
        RegistrationScreen.id: (context) => RegistrationScreen(),
        // When navigating to the "/fourth" route, build the SecondScreen widget.
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
