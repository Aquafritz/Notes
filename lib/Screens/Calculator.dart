import 'package:final_project_notes/Theme/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late String _output;
  late String _outputHistory;
  late double _num1;
  late double _num2;
  late String _operand;

  @override
  void initState() {
    super.initState();
    _output = "0";
    _outputHistory = "";
    _num1 = 0;
    _num2 = 0;
    _operand = "";
  }

 void _buttonPressed(String buttonText) {
  if (buttonText == "C") {
    _output = "0";
    _outputHistory = "";
    _num1 = 0;
    _num2 = 0;
    _operand = "";
  } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
    if (_output != "0") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _outputHistory = _output + buttonText;
      _output = "0"; // Reset _output only after the first operand
    }
  } else if (buttonText == "=") {
    _num2 = double.parse(_output);
    if (_operand == "+") {
      _output = (_num1 + _num2).toString();
    }
    if (_operand == "-") {
      _output = (_num1 - _num2).toString();
    }
    if (_operand == "x") {
      _output = (_num1 * _num2).toString();
    }
    if (_operand == "/") {
      _output = (_num1 / _num2).toString();
    }

    _operand = "";
    _num1 = 0;
    _num2 = 0;
    _outputHistory = "";
  } else {
    if (_output == "0" || _output == "0.0") {
      _output = buttonText;
    } else {
      _output += buttonText;
    }
  }

  setState(() {});
}


  Widget buildButton(String buttonText) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    Color textColor = isDarkMode ? Colors.black : Colors.white;
    Color buttonColor = (buttonText == "C") ? Colors.red : (isDarkMode ? Colors.white : Colors.black);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          ),
          onPressed: () {
            _buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    Color outputColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      
      backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
             Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                _outputHistory, // Display button history here
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: outputColor),
              ),
            ),
          ),
            Expanded( 
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: outputColor),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("1"),
                        buildButton("2"),
                        buildButton("3"),
                        buildButton("/"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("4"),
                        buildButton("5"),
                        buildButton("6"),
                        buildButton("x"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("7"),
                        buildButton("8"),
                        buildButton("9"),
                        buildButton("-"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("."),
                        buildButton("0"),
                        buildButton("00"),
                        buildButton("+"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("C"),
                        buildButton("="),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
