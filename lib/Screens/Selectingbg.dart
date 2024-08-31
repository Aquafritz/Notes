import 'package:flutter/material.dart';

class SelectingBg extends StatelessWidget {
   SelectingBg({super.key});

  final List<String> backgrounds = [
    'assets/1.jpg',
    'assets/2.png',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.png',
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Background'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: backgrounds.length,
        itemBuilder: (context, index) {
          final background = backgrounds[index];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, background);
            },
            child: Image.asset(
              background,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
