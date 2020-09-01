import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfinderprint/login_in_screen.dart';
import 'package:local_auth/local_auth.dart';

import 'my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white30,
        primarySwatch: Colors.blue,
      ),
      home: LoginInScreen(),
    );
  }
}

