import 'package:final_project_notes/Screens/Games.dart';
import 'package:final_project_notes/Theme/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:final_project_notes/Screens/Calculator.dart';
import 'package:final_project_notes/Screens/Notes.dart';
import 'package:final_project_notes/Screens/Settings.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Calculator(),
    Notes(),
    Games(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
        bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        selectedLabelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold), // Selected label text color
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() { 
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Calculator',
            icon: Icon(Icons.calculate_outlined, color: isDarkMode ? Colors.white : Colors.black),
            activeIcon: Icon(Icons.calculate, color: Colors.teal),
          ),
          BottomNavigationBarItem(
            label: 'Notes',
            icon: Icon(Icons.notes_outlined, color: isDarkMode ? Colors.white : Colors.black),
            activeIcon: Icon(Icons.notes, color: Colors.teal),
          ),
          BottomNavigationBarItem(
            label: 'Games',
            icon: Icon(Icons.games_outlined, color: isDarkMode ? Colors.white : Colors.black),
            activeIcon: Icon(Icons.settings_applications, color: Colors.teal),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings_applications_outlined, color: isDarkMode ? Colors.white : Colors.black),
            activeIcon: Icon(Icons.settings_applications, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
