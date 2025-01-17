import 'package:final_project_notes/Screens/HomeScreen.dart';
import 'package:final_project_notes/Theme/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeProvider(), 
        child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (HomeScreen()),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}