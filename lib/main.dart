import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/Calculator.dart';
import 'ConverterFolder/Converter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator App",
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
