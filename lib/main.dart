import 'package:chatapp/Pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/chat_page.dart';
import 'Pages/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Chat());
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginPage':(context) =>LoginPage(),
        'RegisterPage':(context) =>RegisterPage(),
        ChatPage.id:(context) =>ChatPage()
      },
      initialRoute: 'LoginPage',
    );
  }
}



