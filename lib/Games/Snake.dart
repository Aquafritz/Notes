import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:final_project_notes/Theme/ThemeProvider.dart';

void main() => runApp(SnakeGame());

class SnakeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData.light(), // Set light theme as default
      darkTheme: ThemeData.dark(), // Set dark theme
      home: Scaffold(
        appBar: AppBar(
          title: Text('Snake Game', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: SnakeGameScreen(),
      ),
    );
  }
}

class SnakeGameScreen extends StatefulWidget {
  @override
  _SnakeGameScreenState createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int gridSize = 20;
  static const int speed = 200;

  List<int> snake = [45, 44];
  int food = Random().nextInt(gridSize * gridSize);
  var direction = 'right';
  var isPlaying = false;

  void startGame() {
    snake = [45, 44];
    direction = 'right';
    food = Random().nextInt(gridSize * gridSize);
    isPlaying = true;
    Timer.periodic(Duration(milliseconds: speed), (Timer timer) {
      if (!isPlaying) {
        timer.cancel();
      }
      moveSnake();
    });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'up':
          if (snake.first < gridSize) {
            isPlaying = false;
          } else {
            snake.insert(0, snake.first - gridSize);
          }
          break;
        case 'down':
          if (snake.first > gridSize * (gridSize - 1)) {
            isPlaying = false;
          } else {
            snake.insert(0, snake.first + gridSize);
          }
          break;
        case 'left':
          if (snake.first % gridSize == 0) {
            isPlaying = false;
          } else {
            snake.insert(0, snake.first - 1);
          }
          break;
        case 'right':
          if ((snake.first + 1) % gridSize == 0) {
            isPlaying = false;
          } else {
            snake.insert(0, snake.first + 1);
          }
          break;
      }
      if (snake.first == food) {
        food = Random().nextInt(gridSize * gridSize);
      } else {
        snake.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double containerSize = MediaQuery.of(context).size.width / gridSize;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    Color backgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (direction != 'up' && details.delta.dy > 0) {
          direction = 'down';
        } else if (direction != 'down' && details.delta.dy < 0) {
          direction = 'up';
        }
      },
      onHorizontalDragUpdate: (details) {
        if (direction != 'left' && details.delta.dx > 0) {
          direction = 'right';
        } else if (direction != 'right' && details.delta.dx < 0) {
          direction = 'left';
        }
      },
      onTap: () {
        if (!isPlaying) {
          startGame();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor, // Set background color dynamically
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: gridSize * gridSize,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (snake.contains(index)) {
                    return Container(
                      width: containerSize,
                      height: containerSize,
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.green,
                        ),
                      ),
                    );
                  } else if (index == food) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: isDarkMode
                              ? Colors.grey.shade700
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            if (!isPlaying)
              Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            Container(
              child: ElevatedButton(
                 style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                   backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                onPressed: () => direction = 'up',
                child: Icon(Icons.arrow_upward, size: 50, color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ElevatedButton(
                     style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                   backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                    onPressed: () => direction = 'left',
                    child:
                        Icon(Icons.arrow_back, size: 50, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                   style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                   backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                  onPressed: () {
                    if (!isPlaying) {
                      startGame();
                    }
                  },
                  child: Text(isPlaying ? 'Playing' : 'Start', style: TextStyle(
                    fontSize: 20,
                      color: Colors.black,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                     style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                   backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                    onPressed: () => direction = 'right',
                    child:
                        Icon(Icons.arrow_forward, size: 50, color: Colors.black),
                  ),
                ),
              ],
            ),
            ElevatedButton(
               style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                   backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
              onPressed: () => direction = 'down',
              child:
                  Icon(Icons.arrow_downward, size: 50, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
