import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'calculator.dart';

void main() => runApp(ScientificCalculator());

class ScientificCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  final Calculator _calculator = Calculator();

  void _buttonPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '';
      } else if (text == '⌫') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (text == '=') {
        _result = _calculator.evaluate(_expression);
      } else if (text == 'exit') {
        SystemNavigator.pop(); // This exits the entire application
      } else if (text == 'sin' || text == 'cos') {
        _expression += '$text('; // Add function with open parenthesis
      } else {
        _expression += text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade200,
        title: Text(
          'Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              children: [
                '(',
                ')',
                'C',
                '⌫',
                '7',
                '8',
                '9',
                '/',
                '4',
                '5',
                '6',
                '*',
                '1',
                '2',
                '3',
                '-',
                '0',
                '.',
                '=',
                '+',
                'sin',
                'cos',
                '^',
                'exit'
              ].map((text) {
                return InkWell(
                  onTap: () => _buttonPressed(text),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      text,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'By: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                'M. Zahir Akbari',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
