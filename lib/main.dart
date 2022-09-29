import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_system/login_page.dart';
import 'package:login_system/new_user.dart';
import 'package:login_system/second_page.dart';

import 'firebase_options.dart';
import 'forgot_password_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SecondScreen(),
        '/register': (context) => NewUser(),
        '/login': (context) => LoginPage(),
        '/forgot': (context) => ForgotPassWordPage(),
      },
    );
  }
}
