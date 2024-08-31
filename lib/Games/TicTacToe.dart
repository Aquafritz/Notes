// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math';

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tictactoe.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                   backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen(1)),
                  );
                },
                child: Text('1 Player', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                   backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen(2)),
                  );
                },
                child: Text('2 Players', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      )
    );
  }
}

class GameScreen extends StatefulWidget {
  final int players;

  GameScreen(this.players);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> gameState;
  late bool isPlayerTurn;
  late bool gameOver;
  int playerXScore = 0;
  int playerOScore = 0;
  int maxGames = 3; 

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    gameState = List.filled(9, '');
    isPlayerTurn = true;
    gameOver = false;
  }

  void makeMove(int index) {
    if (!gameOver && gameState[index] == '') {
      setState(() {
        gameState[index] = isPlayerTurn ? 'X' : 'O';
        isPlayerTurn = !isPlayerTurn;
        checkWin();
        if (!gameOver && !isPlayerTurn && widget.players == 1) {
          makeAIMove();
        }
      });
    }
  }

  void makeAIMove() {
    List<int> emptyCells = [];
    for (int i = 0; i < gameState.length; i++) {
      if (gameState[i] == '') {
        emptyCells.add(i);
      }
    }
    int randomIndex = Random().nextInt(emptyCells.length);
    makeMove(emptyCells[randomIndex]);
  }

  void checkWin() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (gameState[condition[0]] != '' &&
          gameState[condition[0]] == gameState[condition[1]] &&
          gameState[condition[1]] == gameState[condition[2]]) {
        setState(() {
          gameOver = true;
          if (gameState[condition[0]] == 'X') {
            playerXScore++;
          } else {
            playerOScore++;
          }
          if (playerXScore == maxGames || playerOScore == maxGames) {
            gameOver = true;
          }
        });
        return;
      }
    }

    if (!gameState.contains('')) {
      setState(() {
        gameOver = true;
      });
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Tic Tac Toe'),
      centerTitle: true,
      backgroundColor: Colors.teal,
    ),
    body: Center(
      child: SizedBox(
        width: 450,
        height: 650,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 SizedBox(height: 20.0),
                        Text(
                          'Player X: $playerXScore',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Player O: $playerOScore',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      makeMove(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.teal,
                        child: Center(
                          child: Text(
                            gameState[index],
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                if (gameOver)
                  Column(
                    children: [
                      Text(
                        gameOver ? (gameState.contains('X') ? 'Winner: Player X' : gameState.contains('O') ? 'Winner: Player O' : 'Draw') : '',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: 350,
                        child: ElevatedButton(
                          style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(10),
                           backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                        ),
                          onPressed: () {
                            setState(() {
                              startNewGame();
                            });
                          },
                          child: Text('New Game', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}