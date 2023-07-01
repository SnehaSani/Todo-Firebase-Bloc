import 'package:flutter/material.dart';
import 'package:todo_firebase_bloc/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.red,
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}