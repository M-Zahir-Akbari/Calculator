import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

// The Calculator class handles parsing and evaluating mathematical expressions.
class Calculator {
  // Create a parser object to parse the mathematical expressions.
  Parser p = Parser();
  // Create a context model to maintain the state of variables and functions.
  ContextModel cm = ContextModel();

  // Method to evaluate a given expression.
  String evaluate(String expression) {
    try {
      // Replace 'sin' and 'cos' to convert degrees to radians
      expression = expression.replaceAllMapped(
        RegExp(r'sin\(([^)]+)\)'),
        (Match m) {
          // Convert the argument from degrees to radians
          String? degreesStr = m.group(1);
          if (degreesStr == null) {
            return 'sin(0)'; // Default value or handle error as needed
          }
          double degrees = double.parse(degreesStr);
          double radians = degrees * (pi / 180);
          return 'sin($radians)';
        },
      );

      expression = expression.replaceAllMapped(
        RegExp(r'cos\(([^)]+)\)'),
        (Match m) {
          // Convert the argument from degrees to radians
          String? degreesStr = m.group(1);
          if (degreesStr == null) {
            return 'cos(0)'; // Default value or handle error as needed
          }
          double degrees = double.parse(degreesStr);
          double radians = degrees * (pi / 180);
          return 'cos($radians)';
        },
      );

      // Parse the expression into an Expression object.
      Expression exp = p.parse(expression);
      // Evaluate the expression and get the result.
      double result = exp.evaluate(EvaluationType.REAL, cm);
      // Return the result as a string.
      return result.toString();
    } catch (e) {
      // Return 'Error' if there is an exception during evaluation.
      return 'Error';
    }
  }
}
