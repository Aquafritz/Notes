import 'package:final_project_notes/Games/RollingDice.dart';
import 'package:final_project_notes/Games/Snake.dart';
import 'package:final_project_notes/Games/TicTacToe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child:Column(
            children: [
              SizedBox(
                    height: 10,
                  ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TicTacToe()));
                    },
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/TicTacToe.jpg'),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tic Tac Toe',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => DiceRollingSimulator()));
                },
                child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/RollingDIce.jpg'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Rolling Dice',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => SnakeGame()));
                },
                child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/snake.jpg'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Snake',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
           ],
          ),
        ),
      ),
    );
  }
}