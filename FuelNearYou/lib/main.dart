// ignore_for_file: unused_import, unused_shown_name

import 'package:fillme/splashScreen.dart' show SplashScreen;
import 'package:flutter/material.dart' show AppBarTheme, BuildContext, Color, MaterialApp, StatelessWidget, ThemeData, Widget, WidgetsFlutterBinding, runApp;
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color:Color.fromRGBO(0, 214, 227, 1),
         )
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}