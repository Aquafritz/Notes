import 'package:final_project_notes/Theme/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.teal
      ),
      body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.fromLTRB(25, 10, 25, 5),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      ),
                  ),
                    SizedBox(
                      width: 100,
                    ),
                   CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                      onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                    ),
                ],
              ),
            ),
          ]
      )
    );
  }
}