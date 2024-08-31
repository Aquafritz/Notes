// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';

class DiceRollingSimulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Rolling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiceHomePage(),
    );
  }
}

class DiceHomePage extends StatefulWidget {
  @override
  _DiceHomePageState createState() => _DiceHomePageState();
}
class _DiceHomePageState extends State<DiceHomePage> {
  int _diceNumber = 1;

  void _rollDice() {
    setState(() {
      _diceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Dice Game'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue.shade200,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Colors.white, Colors.teal],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Dice Roll Result: $_diceNumber',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset('assets/Dice$_diceNumber.png', width: 350, height: 350),
              ),
              SizedBox(height: 40),
              IconButton(
                icon: Icon(
                  Icons.casino_sharp,
                  size: 70,
                  color: Colors.teal,
                ),
                onPressed: _rollDice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
